"use strict";
// Max MIDI device wrapper and uncompressed mx@c resource archive.
// Layout cross-checked against Ableton's OSC MIDI Send.amxd (Connection Kit).
// Parsing validates framing/resources; successful loading still needs Max/Live.
const uint = (value, little = false) => {
  const b = Buffer.alloc(4);
  if (little) b.writeUInt32LE(value); else b.writeUInt32BE(value);
  return b;
};
function chunk(tag, payload) {
  return Buffer.concat([Buffer.from(tag, "ascii"), uint(payload.length + 8), payload]);
}
function filename(name) {
  const text = Buffer.from(name + "\0", "utf8");
  return Buffer.concat([text, Buffer.alloc((4 - text.length % 4) % 4)]);
}
function pack(files) {
  if (!files.length || files[0].type !== "JSON") throw new Error("Main JSON patch required");
  let offset = 16;
  const entries = files.map((file, index) => {
    if (!/^[^/\\\0]+$/.test(file.name)) throw new Error("Resource names must be flat");
    const entry = Buffer.concat([
      chunk("type", Buffer.from(file.type, "ascii")), chunk("fnam", filename(file.name)),
      chunk("sz32", uint(file.data.length)), chunk("of32", uint(offset)),
      chunk("vers", uint(file.version ?? 0)), chunk("flag", uint(file.flag ?? (index === 0 ? 0x11 : 0))),
      chunk("mdat", uint(file.mtime ?? 2082844800))
    ]);
    offset += file.data.length;
    return chunk("dire", entry);
  });
  const data = Buffer.concat(files.map(f => f.data));
  const archive = Buffer.concat([
    Buffer.from("mx@c"), uint(16), uint(0), uint(16 + data.length), data,
    chunk("dlst", Buffer.concat(entries))
  ]);
  return Buffer.concat([
    Buffer.from("ampf"), uint(4, true), Buffer.from("mmmmmeta"), uint(4, true),
    uint(7, true), Buffer.from("ptch"), uint(archive.length, true), archive
  ]);
}
function unpack(device) {
  function requireValue(ok, message) { if (!ok) throw new Error(message); }
  requireValue(device.length >= 48, "Truncated device header");
  requireValue(device.toString("ascii", 0, 4) === "ampf", "Not an AMXD device");
  requireValue(device.readUInt32LE(4) === 4, "Unsupported type chunk");
  requireValue(device.toString("ascii", 8, 12) === "mmmm", "Not a MIDI device");
  requireValue(device.toString("ascii", 12, 16) === "meta", "Missing metadata");
  requireValue(device.readUInt32LE(16) === 4, "Invalid metadata size");
  requireValue(device.toString("ascii", 24, 28) === "ptch", "Missing patch chunk");
  const a = device.subarray(32);
  requireValue(device.readUInt32LE(28) === a.length, "Incorrect patch chunk size");
  requireValue(a.toString("ascii", 0, 4) === "mx@c", "Unsupported Max archive");
  requireValue(a.readUInt32BE(4) === 16 && a.readUInt32BE(8) === 0, "Unsupported archive header");
  const end = a.readUInt32BE(12);
  requireValue(end >= 16 && end + 8 <= a.length, "Truncated archive data");
  requireValue(a.toString("ascii", end, end + 4) === "dlst", "Missing resource directory list");
  requireValue(end + a.readUInt32BE(end + 4) === a.length, "Incorrect directory list size");
  const files = [];
  function entry(begin, limit) {
    const fields = {};
    while (begin < limit && a.toString("ascii", begin, begin + 4) !== "dire") {
      requireValue(begin + 8 <= limit, "Truncated resource field");
      const tag = a.toString("ascii", begin, begin + 4), length = a.readUInt32BE(begin + 4);
      requireValue(length >= 8 && begin + length <= limit, "Invalid resource field size");
      requireValue(!fields[tag], "Duplicate resource field");
      fields[tag] = a.subarray(begin + 8, begin + length);
      begin += length;
    }
    for (const tag of ["type", "fnam", "sz32", "of32", "vers", "flag", "mdat"]) {
      requireValue(fields[tag], `Missing resource field ${tag}`);
      if (tag !== "fnam") requireValue(fields[tag].length === 4, `Invalid ${tag} field`);
    }
    const size = fields.sz32.readUInt32BE(), offset = fields.of32.readUInt32BE();
    requireValue(offset >= 16 && offset + size <= end, "Resource outside archive data");
    const zero = fields.fnam.indexOf(0);
    requireValue(zero > 0, "Invalid resource filename");
    files.push({ name: fields.fnam.toString("utf8", 0, zero), type: fields.type.toString("ascii"),
      data: a.subarray(offset, offset + size), offset, flag: fields.flag.readUInt32BE(),
      version: fields.vers.readUInt32BE(), mtime: fields.mdat.readUInt32BE() });
    return begin;
  }
  let cursor = end + 8;
  while (cursor < a.length) {
    requireValue(a.toString("ascii", cursor, cursor + 4) === "dire", "Invalid resource directory");
    const length = a.readUInt32BE(cursor + 4);
    requireValue(length >= 8 && cursor + length <= a.length, "Truncated directory entry");
    requireValue(entry(cursor + 8, cursor + length) === cursor + length, "Incomplete directory entry");
    cursor += length;
  }
  requireValue(files[0].type === "JSON" && files[0].flag === 0x11, "Missing main patch");
  requireValue(new Set(files.map(f => f.name)).size === files.length, "Duplicate resource name");
  const spans = files.slice().sort((x, y) => x.offset - y.offset);
  let next = 16;
  for (const file of spans) {
    requireValue(file.offset === next, "Gap or overlap in resource data");
    next += file.data.length;
  }
  requireValue(next === end, "Unindexed archive data");
  return files;
}
module.exports = { pack, unpack };
