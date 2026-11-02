"use strict";
const test = require("node:test");
const assert = require("node:assert/strict");
const fs = require("node:fs");
const path = require("node:path");
const { pack, unpack } = require("../scripts/amxd.js");
const directory = path.resolve(__dirname, "../device");
const read = name => fs.readFileSync(path.join(directory, name));

test("the generated MIDI device carries the complete patch and all three exact scripts", () => {
  const bytes = read("COASTLINE.amxd");
  assert.equal(bytes.subarray(0, 28).toString("hex"),
    "616d7066040000006d6d6d6d6d657461040000000700000070746368");
  assert.equal(bytes.readUInt32LE(28), bytes.length - 32);
  assert.equal(bytes.toString("ascii", 32, 36), "mx@c");
  assert.equal(bytes.readUInt32BE(36), 16);
  const directoryOffset = 32 + bytes.readUInt32BE(44);
  assert.equal(bytes.toString("ascii", directoryOffset, directoryOffset + 4), "dlst");
  assert.equal(bytes.toString("ascii", directoryOffset + 8, directoryOffset + 12), "dire");
  const files = unpack(bytes);
  assert.deepEqual(files.map(f => f.name),
    ["COASTLINE.amxd", "coastline-max.js", "coastline-core.js", "coastline-view.js"]);
  for (const resource of files.slice(1)) {
    assert.equal(resource.type, "TEXT");
    assert.deepEqual(resource.data, read(resource.name));
  }
  const built = JSON.parse(files[0].data.toString("utf8").replace(/\0$/, "")).patcher;
  const source = JSON.parse(read("COASTLINE.maxpat")).patcher;
  assert.deepEqual(built.boxes, source.boxes);
  assert.deepEqual(built.lines, source.lines);
  assert.deepEqual(built.parameters, source.parameters);
  assert.equal(built.openinpresentation, 1);
  assert.equal(built.devicewidth, 1110);
  assert.deepEqual(Object.keys(built.project.contents.code).sort(), files.slice(1).map(f => f.name).sort());
  for (const name of ["engine", "clock", "boot", "boot-delay", "active", "midi-output"]) {
    assert.ok(built.boxes.some(({ box }) => box.id === name), `${name} must be inside the device`);
  }
});

test("all automated controls are visible within device height in both Max views", () => {
  const p = JSON.parse(read("COASTLINE.maxpat")).patcher;
  const boxes = new Map(p.boxes.map(({ box }) => [box.id, box]));
  for (const id of Object.keys(p.parameters)) {
    const b = boxes.get(id);
    assert.equal(b.presentation, 1);
    for (const field of ["patching_rect", "presentation_rect"]) {
      const [x, y, width, height] = b[field];
      assert.ok(x >= 0 && y >= 0 && x + width <= p.devicewidth && y + height <= 169,
        `${id} must be visible in ${field}`);
    }
  }
});

test("archive offsets and byte counts account for UTF-8 resources and padded names", () => {
  const inputs = [
    { name: "Main.amxd", type: "JSON", data: Buffer.from('{"patcher":{}}\n\0') },
    { name: "rhythm.js", type: "TEXT", data: Buffer.from('// größe\n') },
    { name: "x.js", type: "TEXT", data: Buffer.from('var x = 1;\n') }
  ];
  const output = unpack(pack(inputs));
  let offset = 16;
  output.forEach((file, i) => {
    assert.equal(file.offset, offset);
    assert.equal(file.name, inputs[i].name);
    assert.deepEqual(file.data, inputs[i].data);
    offset += inputs[i].data.length;
  });
});

test("device parser rejects truncation, wrong type and corrupt length fields", () => {
  const bytes = read("COASTLINE.amxd");
  for (const end of [0, 32, 47, bytes.length - 1]) assert.throws(() => unpack(bytes.subarray(0, end)));
  const wrongType = Buffer.from(bytes); wrongType.write("aaaa", 8, "ascii");
  assert.throws(() => unpack(wrongType), /Not a MIDI/);
  const wrongLength = Buffer.from(bytes); wrongLength.writeUInt32LE(0, 28);
  assert.throws(() => unpack(wrongLength), /chunk size/);
  const wrongDirectory = Buffer.from(bytes); wrongDirectory.writeUInt32BE(16, 44);
  assert.throws(() => unpack(wrongDirectory), /directory list/);
  assert.throws(() => pack([{ name: "../escape.amxd", type: "JSON", data: Buffer.alloc(0) }]), /flat/);
});
