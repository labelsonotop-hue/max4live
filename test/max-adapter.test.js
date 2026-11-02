"use strict";
const test = require("node:test");
const assert = require("node:assert/strict");
const vm = require("node:vm");
const fs = require("node:fs");
const path = require("node:path");
const directory = path.resolve(__dirname, "../device");

function maxHarness() {
  let now = 0;
  const tasks = new Set(), events = [];
  const context = vm.createContext({
    outlet: (port, ...args) => events.push({ port, args: JSON.parse(JSON.stringify(args)), time: now }),
    Task: function (callback, owner) {
      this.schedule = delay => { this.at = now + delay; tasks.add(this); };
      this.cancel = () => tasks.delete(this);
      this.fire = () => { tasks.delete(this); callback.call(owner); };
    },
    include: name => vm.runInContext(fs.readFileSync(path.join(directory, name), "utf8"), context)
  });
  vm.runInContext(fs.readFileSync(path.join(directory, "coastline-max.js"), "utf8"), context);
  return {
    context, events, tasks,
    notes: () => events.filter(e => e.port === 0).map(e => e.args[0]),
    advance(to) {
      while (tasks.size) {
        const task = [...tasks].sort((a, b) => a.at - b.at)[0];
        if (task.at > to) break;
        now = task.at; task.fire();
      }
      now = to;
    }
  };
}

test("transport stop cancels ratchets and releases the active note", () => {
  const h = maxHarness(), c = h.context;
  c.param("ratchet", 100); c.param("repeats", 4);
  c.transport(1); c.bang();
  assert.equal(h.notes().filter(n => n[1] > 0).length, 1);
  assert.ok(h.tasks.size > 0);
  c.transport(0); h.advance(10000); c.bang();
  assert.deepEqual(h.notes(), [[48, 120, 1], [48, 0, 1]]);
  assert.equal(h.tasks.size, 0);
});

test("PANIC latches silent until reset, which restarts step one", () => {
  const h = maxHarness(), c = h.context;
  c.param("ratchet", 100); c.transport(1); c.bang();
  c.panic(); h.advance(500);
  for (let i = 0; i < 30; i++) c.bang();
  assert.equal(h.notes().filter(n => n[1] > 0).length, 1);
  assert.equal(h.tasks.size, 0);
  c.reset(); c.bang();
  assert.equal(h.notes().filter(n => n[1] > 0).length, 2);
  assert.equal(c.pulse, 0);
});

test("channel change releases the previous channel before further notes", () => {
  const h = maxHarness(), c = h.context;
  c.transport(1); c.bang(); c.param("channel", 7);
  assert.deepEqual(h.notes().at(-1), [48, 0, 1]);
  c.reset(); c.bang();
  assert.deepEqual(h.notes().at(-1), [48, 120, 7]);
});

test("device bypass and deletion flush pending work", () => {
  const h = maxHarness(), c = h.context;
  c.param("ratchet", 100); c.transport(1); c.bang(); c.deviceactive(0);
  h.advance(1000); c.bang();
  assert.equal(h.notes().filter(n => n[1] > 0).length, 1);
  c.deviceactive(1); c.bang();
  assert.equal(h.notes().filter(n => n[1] > 0).length, 2);
  c.notifydeleted(); h.advance(10000);
  assert.equal(h.tasks.size, 0);
  assert.equal(h.notes().at(-1)[1], 0);
});

test("long performance stays monophonic and ends with every note released", () => {
  const h = maxHarness(), c = h.context;
  c.param("aHits", 16); c.param("bHits", 7);
  c.param("ratchet", 100); c.param("repeats", 4);
  c.param("swing", 45); c.param("gate", 90);
  c.transport(1);
  for (let pulse = 0; pulse < 1200; pulse++) {
    h.advance(pulse * 60000 / 120 / 12); c.bang();
  }
  c.transport(0); h.advance(100000);
  let active = null, noteOns = 0;
  for (const [pitch, velocity, channel] of h.notes()) {
    if (velocity > 0) {
      assert.equal(active, null, "A new note must release the previous voice first");
      active = [pitch, channel]; noteOns++;
    } else {
      assert.deepEqual(active, [pitch, channel], "Note-off must match the current voice");
      active = null;
    }
  }
  assert.ok(noteOns > 1000);
  assert.equal(active, null);
  assert.equal(h.tasks.size, 0);
});

test("patch connections, Live observers, and saved controls cover every engine parameter", () => {
  const { patcher } = JSON.parse(fs.readFileSync(path.join(directory, "COASTLINE.maxpat"), "utf8"));
  const boxes = new Map(patcher.boxes.map(({ box }) => [box.id, box]));
  assert.equal(boxes.size, patcher.boxes.length);
  for (const { patchline: line } of patcher.lines) {
    assert.ok(boxes.has(line.source[0]), line.source[0]);
    assert.ok(boxes.has(line.destination[0]), line.destination[0]);
  }
  assert.equal(boxes.get("clock").text, "metro 40 ticks @quantize 40 ticks");
  assert.equal(boxes.get("midi-output").text, "noteout");
  const expected = [...Object.keys(require("../device/coastline-core.js").defaults), "enabled"].sort();
  const saved = Object.keys(patcher.parameters).map(id => boxes.get(id).varname).sort();
  assert.deepEqual(saved, expected);
  for (const name of ["is_playing", "tempo", "is_active"]) {
    assert.ok(patcher.boxes.some(({ box }) => box.text === `live.observer @property ${name}`));
  }
  for (const { name } of patcher.dependency_cache) assert.ok(fs.existsSync(path.join(directory, name)));
});
