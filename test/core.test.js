"use strict";
const test = require("node:test");
const assert = require("node:assert/strict");
const { Engine, Voice, pattern } = require("../device/coastline-core.js");

test("all Euclidean lengths 1–32 preserve hit count and distribute cyclic gaps evenly", () => {
  for (let n = 1; n <= 32; n++) {
    for (let hits = 0; hits <= n; hits++) {
      const p = pattern(n, hits, 0);
      assert.equal(p.length, n);
      assert.equal(p.reduce((a, b) => a + b, 0), hits);
      const positions = p.flatMap((hit, i) => hit ? [i] : []);
      if (hits > 0) {
        const gaps = positions.map((pos, i) => (positions[(i + 1) % hits] - pos + n) % n || n);
        assert.ok(Math.max(...gaps) - Math.min(...gaps) <= 1, `${hits}/${n}`);
      }
      for (let r = 0; r < n; r++) {
        assert.deepEqual(pattern(n, hits, r), p.map((_, i) => p[(i - r + n) % n]));
      }
    }
  }
});

test("4:3 grid has four A steps and three B steps in one quarter; collisions emit one note", () => {
  const e = new Engine({ aLength: 4, aHits: 4, bLength: 3, bHits: 3, bRate: 1, ratchet: 0 });
  const hits = Array.from({ length: 12 }, (_, pulse) => [pulse, e.frame(pulse, 120).notes]);
  assert.deepEqual(hits.filter(([, n]) => n.length).map(([p, n]) => [p, n[0].source]),
    [[0, "AB"], [3, "A"], [4, "B"], [6, "A"], [8, "B"], [9, "A"]]);
  assert.ok(hits.every(([, notes]) => notes.length <= 1));
  assert.equal(hits[0][1][0].velocity, 120);
});

test("MERGE, XOR and MEET have distinct collision behavior", () => {
  const e = new Engine({ aLength: 1, aHits: 1, bLength: 1, bHits: 1, ratchet: 0 });
  assert.equal(e.frame(0, 120).notes.length, 1);
  e.set("blend", 1);
  assert.equal(e.frame(0, 120).notes.length, 0);
  assert.equal(e.frame(3, 120).notes.length, 1);
  e.set("blend", 2);
  assert.equal(e.frame(0, 120).notes.length, 1);
  assert.equal(e.frame(3, 120).notes.length, 0);
});

test("straight B grid aligns with A while its cycle length remains independent", () => {
  const e = new Engine({ bRate: 0, aLength: 16, bLength: 7 });
  assert.equal(e.frame(21, 120).aStep, 7);
  assert.equal(e.frame(21, 120).bStep, 0);
  for (let i = 1; i < 48; i++) {
    if (i % 3 !== 0) assert.equal(e.frame(i, 120).notes.length, 0);
  }
});

test("pitch cycle advances through rests independently of triggered notes", () => {
  const e = new Engine({ aLength: 4, aHits: 1, bHits: 0, pitchLength: 5, ratchet: 0 });
  assert.equal(e.frame(0, 120).notes[0].pitch, 48);
  assert.equal(e.frame(3, 120).notes.length, 0);
  assert.equal(e.frame(12, 120).notes[0].pitch, 58); // pitch step 5, not step 2
});

test("chance boundaries, zero-hit lanes, and seeded performance reproduction", () => {
  const a = new Engine({ chance: 0 });
  for (let i = 0; i < 1000; i++) assert.equal(a.frame(i, 123).notes.length, 0);
  a.set("chance", 100); a.set("aHits", 0); a.set("bHits", 0);
  for (let i = 0; i < 100; i++) assert.equal(a.frame(i, 123).notes.length, 0);
  const b = new Engine({ chance: 64, ratchet: 50, seed: 981 });
  const c = new Engine({ chance: 64, ratchet: 50, seed: 981 });
  const performance = engine => Array.from({ length: 900 }, (_, i) => engine.frame(i, 123).notes);
  assert.deepEqual(performance(b), performance(c));
  c.set("seed", 982);
  assert.notDeepEqual(performance(b), performance(c));
});

test("ratchets and swing leave a note-off gap before the next combined grid point", () => {
  const e = new Engine({ aHits: 32, bHits: 32, ratchet: 100, repeats: 4, gate: 90, swing: 45 });
  for (const bpm of [20, 80, 120, 300, 999]) {
    for (const bRate of [0, 1]) {
      e.set("bRate", bRate);
      for (let pulse = 0; pulse < 96; pulse++) {
        const notes = e.frame(pulse, bpm).notes;
        const stride = bRate ? 4 : 3;
        const window = Math.min(3 - pulse % 3, stride - pulse % stride) * 60000 / bpm / 12;
        for (let i = 0; i < notes.length; i++) {
          assert.ok(notes[i].duration > 0);
          assert.ok(notes[i].delay + notes[i].duration < window);
          if (i) assert.ok(notes[i - 1].delay + notes[i - 1].duration < notes[i].delay);
        }
      }
    }
  }
});

test("parameters reject malformed values and all emitted MIDI data stays in range", () => {
  const e = new Engine();
  assert.equal(e.set("root", "no"), false);
  assert.equal(e.set("unknown", 1), false);
  assert.equal(e.set("pitch99", 1), false);
  assert.equal(e.set("gate", Infinity), false);
  e.set("root", 999); e.set("pitch0", 999); e.set("pitchLength", 1); e.set("channel", 99);
  assert.equal(e.frame(0, 120).notes[0].pitch, 127);
  assert.equal(e.frame(0, 120).notes[0].channel, 16);
  e.set("root", -99); e.set("pitch0", -99); e.set("channel", -99);
  const n = e.frame(0, 120).notes[0];
  assert.equal(n.pitch, 0); assert.equal(n.channel, 1);
});

test("voice retriggers monophonically, preserves original channel, and ignores stale note-offs", () => {
  const events = [], voice = new Voice((...a) => events.push(a));
  const old = voice.on(48, 100, 1);
  const next = voice.on(48, 90, 2);
  voice.release(old);
  assert.deepEqual(events, [[48, 100, 1], [48, 0, 1], [48, 90, 2]]);
  voice.release(next);
  voice.panic(); voice.panic();
  assert.deepEqual(events.at(-1), [48, 0, 2]);
  assert.equal(events.length, 4);
  assert.equal(voice.active, null);
});
