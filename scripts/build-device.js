"use strict";
// Generate editable source plus a self-contained MIDI device for host testing.
const fs = require("node:fs");
const path = require("node:path");
const { defaults } = require("../device/coastline-core.js");
const { pack, unpack } = require("./amxd.js");
const boxes = [], lines = [], parameters = {};
const controls = [];
function box(id, maxclass, rect, extra = {}) {
  boxes.push({ box: { id, maxclass, patching_rect: rect, ...extra } });
  return id;
}
function connect(from, outlet, to, inlet = 0, order) {
  const patchline = { source: [from, outlet], destination: [to, inlet] };
  if (order !== undefined) patchline.order = order;
  lines.push({ patchline });
}
function object(id, text, x, y, width = 160, extra = {}) {
  return box(id, "newobj", [x, y, width, 22], { text, ...extra });
}
function label(id, text, x, y, width, size = 10, color = [0.72, 0.77, 0.79, 1]) {
  return box(id, "comment", [x, y, width, 20], {
    text, fontsize: size, textcolor: color, presentation: 1,
    presentation_rect: [x, y, width, 20]
  });
}
function number(name, title, x, y, lo, hi, width = 44) {
  const id = `ui-${name}`;
  label(`label-${name}`, title, x, y - 19, width + 4);
  box(id, "live.numbox", [x, y, width, 19], {
    presentation: 1, presentation_rect: [x, y, width, 19],
    varname: name, parameter_enable: 1,
    saved_attribute_attributes: { valueof: {
      parameter_longname: `Coastline ${name}`, parameter_shortname: title,
      parameter_type: 1, parameter_mmin: lo, parameter_mmax: hi,
      parameter_initial_enable: 1, parameter_initial: [defaults[name]],
      parameter_unitstyle: 0
    }}
  });
  bind(id, name, title);
}
function menu(name, title, items, x, y, width = 86) {
  const id = `ui-${name}`;
  label(`label-${name}`, title, x, y - 19, width);
  box(id, "live.menu", [x, y, width, 19], {
    presentation: 1, presentation_rect: [x, y, width, 19],
    varname: name, parameter_enable: 1,
    saved_attribute_attributes: { valueof: {
      parameter_longname: `Coastline ${name}`, parameter_shortname: title,
      parameter_type: 2, parameter_enum: items,
      parameter_initial_enable: 1, parameter_initial: [defaults[name]]
    }}
  });
  bind(id, name, title);
}
function bind(id, name, title) {
  parameters[id] = [`Coastline ${name}`, title, 0];
  const prepend = object(`set-${name}`, `prepend param ${name}`, 1200, 240 + controls.length * 35);
  connect(id, 0, prepend);
  connect(prepend, 0, "engine");
  controls.push(id);
}
function action(name, title, x) {
  box(`ui-${name}`, "button", [x, 144, 17, 17], {
    presentation: 1, presentation_rect: [x, 142, 17, 17]
  });
  label(`label-${name}`, title, x + 20, 141, 54);
  box(`do-${name}`, "message", [x, 192, 55, 22], { text: name });
  connect(`ui-${name}`, 0, `do-${name}`);
  connect(`do-${name}`, 0, "engine");
}

label("title", "COASTLINE", 12, 7, 200, 21, [0.98, 0.71, 0.4, 1]);
label("subtitle", "MONO / POLYRHYTHMIC MIDI", 14, 33, 205, 10);
box("rhythm-view", "jsui", [14, 59, 190, 60], {
  filename: "coastline-view.js", jsarguments: [],
  presentation: 1, presentation_rect: [14, 59, 190, 60], parameter_enable: 0
});
label("key", "A: 1/16     B: 1/16 or 1/8T", 14, 119, 204, 9);
box("ui-enabled", "live.toggle", [14, 142, 17, 17], {
  presentation: 1, presentation_rect: [14, 142, 17, 17],
  varname: "enabled", parameter_enable: 1,
  saved_attribute_attributes: { valueof: {
    parameter_longname: "Coastline enabled", parameter_shortname: "Run",
    parameter_type: 2, parameter_enum: ["Off", "On"],
    parameter_initial_enable: 1, parameter_initial: [1]
  }}
});
label("run-label", "RUN", 34, 141, 33);
bind("ui-enabled", "enabled", "Run");
action("reset", "RESET", 76);
action("panic", "PANIC", 147);

label("a-title", "A / PULSE", 226, 8, 160, 13, [0.98, 0.62, 0.27, 1]);
number("aLength", "Length", 226, 53, 1, 32);
number("aHits", "Hits", 277, 53, 0, 32);
number("aRotate", "Rotate", 328, 53, 0, 31);
menu("blend", "Collision rule", ["MERGE", "XOR", "MEET"], 226, 104, 146);
label("a-help", "XOR removes shared hits.", 226, 131, 165, 9);
label("a-help2", "MEET keeps shared hits only.", 226, 145, 165, 9);

label("b-title", "B / CROSS RHYTHM", 399, 8, 200, 13, [0.3, 0.78, 0.76, 1]);
number("bLength", "Length", 399, 53, 1, 32);
number("bHits", "Hits", 450, 53, 0, 32);
number("bRotate", "Rotate", 501, 53, 0, 31);
menu("bRate", "B subdivision", ["1/16", "1/8T"], 399, 104, 146);
label("b-help", "1/8T against A = 4:3", 399, 131, 190, 9);
label("b-help2", "Independent cycle lengths.", 399, 145, 190, 9);

label("pitch-title", "PITCH / GATE", 578, 8, 250, 13);
number("root", "Root #", 578, 53, 0, 127);
number("pitchLength", "Cycle", 638, 53, 1, 8);
number("gate", "Gate %", 698, 53, 5, 90);
number("swing", "Swing %", 758, 53, 0, 45);
label("pitch-help", "Semitone offsets / independent 1/16 cycle", 578, 80, 258, 9);
for (let i = 0; i < 8; i++) number(`pitch${i}`, `${i + 1}`, 578 + i * 30, 119, -24, 24, 27);
label("pitch-help2", "Root uses MIDI numbers; pitch cycle runs through rests.", 578, 145, 269, 9);

label("output-title", "VARIATION / MIDI", 853, 8, 245, 13);
number("chance", "Hit %", 853, 53, 0, 100, 49);
number("ratchet", "Ratchet %", 916, 53, 0, 100, 49);
number("repeats", "Repeats", 979, 53, 2, 4, 49);
number("channel", "Channel", 1042, 53, 1, 16, 49);
number("seed", "Seed", 853, 119, 1, 9999, 66);
label("output-help", "Same seed = repeatable variation.", 933, 101, 170, 9);
label("output-help2", "PANIC latches mute; RESET resumes.", 933, 115, 174, 9);
label("output-help3", "0.2 / embedded-script prototype", 853, 145, 247, 9);

object("engine", "js coastline-max.js", 610, 420, 200);
object("unpack-notes", "unpack i i i", 610, 470, 130);
object("midi-output", "noteout", 610, 520, 100);
connect("engine", 0, "unpack-notes");
for (let i = 0; i < 3; i++) connect("unpack-notes", i, "midi-output", i);
connect("engine", 1, "rhythm-view");
object("clock", "metro 40 ticks @quantize 40 ticks", 610, 350, 260);
connect("engine", 2, "clock");
connect("clock", 0, "engine");

object("ready", "live.thisdevice", 14, 330, 120);
object("init-trigger", "t b b b", 14, 365, 100);
connect("ready", 0, "init-trigger");
// Apply restored Live parameters first, then resolve the Live API, then redraw.
controls.forEach((id, i) => connect("init-trigger", 2, id, 0, i));
object("live-set", "live.path live_set", 14, 420, 145);
object("device-path", "live.path this_device", 300, 420, 170);
connect("init-trigger", 1, "live-set", 0, 0);
connect("init-trigger", 1, "device-path", 0, 1);
box("init-message", "message", [14, 570, 45, 22], { text: "init" });
connect("init-trigger", 0, "init-message");
connect("init-message", 0, "engine");

function observer(id, property, method, source, x, y) {
  object(id, `live.observer @property ${property}`, x, y, 240);
  connect(source, 0, id, 1);
  // Accept both bare property values and selector-prefixed notifications.
  object(`${id}-route`, `route ${property}`, x, y + 35, 170);
  object(`${id}-method`, `prepend ${method}`, x, y + 70, 170);
  connect(id, 0, `${id}-route`);
  connect(`${id}-route`, 0, `${id}-method`);
  connect(`${id}-route`, 1, `${id}-method`);
  connect(`${id}-method`, 0, "engine");
}
observer("playing", "is_playing", "transport", "live-set", 14, 650);
observer("tempo", "tempo", "tempo", "live-set", 280, 650);
observer("active", "is_active", "deviceactive", "device-path", 14, 790);
object("close", "closebang", 300, 790, 100);
box("closing-panic", "message", [300, 825, 65, 22], { text: "panic" });
connect("close", 0, "closing-panic");
connect("closing-panic", 0, "engine");

box("clock-note", "comment", [610, 570, 520, 60], {
  text: "40 ticks = 1/12 quarter at Max's 480 PPQ. Tempo-relative metro uses the Live transport in a Max for Live device. MIDI generator: deliberately no MIDI input passthrough. Validate host timing in Live; classic js runs at low priority.",
  linecount: 4
});
const patch = { patcher: {
  fileversion: 1, appversion: { major: 8, minor: 5, revision: 0, architecture: "x64", modernui: 1 },
  classnamespace: "box", rect: [40, 80, 1460, 1040],
  openinpresentation: 1, devicewidth: 1110, default_fontname: "Arial", default_fontsize: 12,
  bglocked: 0, bgcolor: [0.075, 0.095, 0.11, 1], editing_bgcolor: [0.14, 0.16, 0.18, 1],
  description: "Monophonic 4:3 Euclidean MIDI generator for external synths.",
  boxes, lines, parameters,
  dependency_cache: ["coastline-max.js", "coastline-core.js", "coastline-view.js"].map(name => ({
    name, patcherrelativepath: ".", type: "TEXT", implicit: 1
  })), autosave: 0
}};
const destination = path.resolve(__dirname, "../device/COASTLINE.maxpat");
fs.writeFileSync(destination, JSON.stringify(patch, null, 2) + "\n");
console.log(`Built ${path.relative(process.cwd(), destination)} (${boxes.length} objects).`);
// Match the native resource archive framing, with the three scripts embedded.
// This is a programmatic build, not a claim of successful export or execution in Max.
const resources = patch.patcher.dependency_cache.map(({ name }) => ({
  name, type: "TEXT", data: fs.readFileSync(path.resolve(__dirname, "../device", name))
}));
const main = JSON.parse(JSON.stringify(patch));
main.patcher.project = {
  version: 1, creationdate: 2082844800, modificationdate: 2082844800,
  viewrect: [0, 0, 300, 500], autoorganize: 1, hideprojectwindow: 1,
  showdependencies: 1, autolocalize: 0,
  contents: { code: Object.fromEntries(resources.map(r => [r.name, { kind: "javascript", local: 1 }])) },
  layout: {}, searchpath: {}, detailsvisible: 0, amxdtype: 0, readonly: 1,
  devpathtype: 0, devpath: ".", sortmode: 0
};
main.patcher.latency = 0;
const file = pack([
  { name: "COASTLINE.amxd", type: "JSON", data: Buffer.from(JSON.stringify(main) + "\n\0") },
  ...resources
]);
const recovered = unpack(file);
if (recovered.length !== 4) throw new Error("Incomplete device resources");
fs.writeFileSync(path.resolve(__dirname, "../device/COASTLINE.amxd"), file);
console.log("Built device/COASTLINE.amxd (main patch and three embedded scripts; host test pending).");
