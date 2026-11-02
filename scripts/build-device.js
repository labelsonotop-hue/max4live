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
label("subtitle", "MONO / POLYRHYTHMIC MIDI / 0.4", 14, 33, 205, 10);
box("rhythm-view", "jsui", [14, 59, 190, 60], {
  filename: "coastline-view.js", jsarguments: [],
  presentation: 1, presentation_rect: [14, 59, 190, 60], parameter_enable: 0
});
label("key", "A: 1/16 / B: 1/16 or 1/8T", 14, 119, 130, 9);
box("ui-test", "button", [148, 123, 14, 14], {
  presentation: 1, presentation_rect: [148, 123, 14, 14]
});
label("test-label", "TEST", 166, 120, 42, 9);
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
function indicator(name, title, x, valueX, width) {
  label(`${name}-label`, title, x, 144, valueX - x, 9);
  box(name, "number", [valueX, 144, width, 17], {
    presentation: 1, presentation_rect: [valueX, 144, width, 17],
    minimum: 0, maximum: name === "live-state" ? 1 : 9999, ignoreclick: 1,
    fontsize: 9, parameter_enable: 0
  });
}
indicator("live-state", "LIVE", 853, 881, 25);
indicator("clock-count", "CLK", 918, 943, 43);
indicator("midi-count", "MIDI", 994, 1025, 60);

object("engine", "js coastline-max.js", 610, 420, 200, { numinlets: 1, numoutlets: 5 });
object("midi-events", "t l b", 610, 460, 100);
object("midi-bytes", "iter", 610, 500, 100);
object("midi-output", "midiout", 610, 540, 100);
object("midi-counter", "counter 0 9999", 790, 500, 130);
connect("engine", 0, "midi-events");
connect("midi-events", 0, "midi-bytes");
connect("midi-events", 1, "midi-counter");
connect("midi-counter", 0, "midi-count");
connect("midi-bytes", 0, "midi-output");
connect("engine", 1, "rhythm-view");
object("clock", "metro 41.666667", 610, 350, 160, { numinlets: 2, numoutlets: 1 });
object("clock-counter", "counter 0 9999", 900, 350, 130);
connect("engine", 2, "clock");
connect("engine", 3, "live-state");
connect("engine", 4, "clock", 1);
connect("clock", 0, "engine", 0, 0);
connect("clock", 0, "clock-counter", 0, 1);
connect("clock-counter", 0, "clock-count");

object("ready", "live.thisdevice", 14, 300, 120, { numinlets: 1, numoutlets: 3 });
object("init-defer", "deferlow", 14, 330, 100);
object("init-trigger", "t b b b", 14, 365, 100);
connect("ready", 0, "init-defer");
connect("init-defer", 0, "init-trigger");
// Fallback boot even if the device-ready notification was missed.
object("boot", "loadbang", 165, 270, 100);
object("boot-delay", "delay 100", 165, 300, 100);
object("boot-defer", "deferlow", 165, 330, 100);
connect("boot", 0, "boot-delay");
connect("boot-delay", 0, "boot-defer");
// Native device on/off outlet avoids a second API ID/observer dependency.
object("active", "prepend deviceactive", 300, 300, 190);
connect("ready", 1, "active");
connect("active", 0, "engine");
// Apply restored Live parameters, then initialize JS's Live API in low priority.
controls.forEach((id, i) => connect("init-trigger", 2, id, 0, i));
box("init-message", "message", [14, 570, 45, 22], { text: "init" });
connect("init-trigger", 0, "init-message");
connect("boot-defer", 0, "init-message");
connect("init-message", 0, "engine");
object("close", "closebang", 300, 790, 100);
box("closing-panic", "message", [300, 825, 65, 22], { text: "panic" });
connect("close", 0, "closing-panic");
connect("closing-panic", 0, "engine");

// Native test note uses the same raw MIDI outlet without JS, API or a clock.
// Panic first stops the sequencer; RESET resumes it after this diagnostic.
object("test-trigger", "t b b b b", 900, 650, 100);
box("test-stop", "message", [1040, 650, 55, 22], { text: "panic" });
box("test-on", "message", [900, 690, 110, 22], { text: "144 48 100" });
object("test-delay", "delay 1000", 1040, 690, 100);
box("test-off", "message", [1040, 730, 110, 22], { text: "128 48 0" });
connect("ui-test", 0, "test-trigger");
connect("test-trigger", 2, "test-stop");
connect("test-stop", 0, "engine");
connect("test-trigger", 1, "test-on");
connect("test-on", 0, "midi-events");
connect("test-trigger", 0, "test-delay");
connect("test-delay", 0, "test-off");
connect("test-off", 0, "midi-events");
// End/cancel the native test before resets, bypass, stop or another TEST.
object("test-cancel", "t b b", 1180, 650, 80);
box("test-stop-delay", "message", [1180, 690, 55, 22], { text: "stop" });
connect("test-cancel", 1, "test-stop-delay");
connect("test-stop-delay", 0, "test-delay");
connect("test-cancel", 0, "test-off");
connect("test-trigger", 3, "test-cancel");
for (const source of ["do-reset", "do-panic", "set-enabled", "closing-panic"]) {
  for (const { patchline: line } of lines) {
    if (line.source[0] === source) line.order = 1;
  }
  connect(source, 0, "test-cancel", 0, 0);
}
object("test-on-stop", "sel 0", 1180, 735, 80);
object("test-on-bypass", "sel 0", 1180, 775, 80);
connect("engine", 3, "test-on-stop");
connect("test-on-stop", 0, "test-cancel");
connect("ready", 1, "test-on-bypass");
connect("test-on-bypass", 0, "test-cancel");

box("clock-note", "comment", [610, 570, 520, 60], {
  text: "Clock: 60000 / Live BPM / 12 milliseconds, gated by Live play state via JS LiveAPI. No global Max transport required. Start is relative to the Live API notification, not sample-accurate song phase. TEST holds the sequencer until RESET.",
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
