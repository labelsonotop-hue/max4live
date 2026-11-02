/* ES5 on purpose: shared by Max's classic [js] and Node's test runner. */
var Coastline = (function () {
    "use strict";
    var DEFAULTS = {
        aLength: 16, aHits: 5, aRotate: 0,
        bLength: 7, bHits: 3, bRotate: 0, bRate: 1,
        blend: 0, chance: 100, ratchet: 20, repeats: 2,
        gate: 30, root: 48, pitchLength: 5, channel: 1,
        seed: 17, swing: 0,
        pitch0: 0, pitch1: 7, pitch2: 0, pitch3: 3,
        pitch4: 10, pitch5: 0, pitch6: 12, pitch7: 7
    };
    var RANGES = {
        aLength: [1, 32], aHits: [0, 32], aRotate: [0, 31],
        bLength: [1, 32], bHits: [0, 32], bRotate: [0, 31],
        bRate: [0, 1], blend: [0, 2], chance: [0, 100],
        ratchet: [0, 100], repeats: [2, 4], gate: [5, 90],
        root: [0, 127], pitchLength: [1, 8], channel: [1, 16],
        seed: [1, 9999], swing: [0, 45]
    };
    function clamp(n, lo, hi) { return Math.max(lo, Math.min(hi, n)); }
    function mod(n, m) { return ((n % m) + m) % m; }
    function pattern(length, hits, rotate) {
        var a = [], i;
        hits = clamp(Math.round(hits), 0, length);
        for (i = 0; i < length; i += 1) {
            // Evenly distributed onsets, with step one anchored before rotation.
            a.push(mod(mod(i - rotate, length) * hits, length) < hits ? 1 : 0);
        }
        return a;
    }
    function randomAt(seed, pulse, salt) {
        // Stateless 32-bit hash: identical settings and position repeat exactly.
        var n = (seed ^ ((pulse + 1) * 374761393) ^ (salt * 668265263)) | 0;
        n = ((n ^ (n >>> 13)) * 1274126177) | 0;
        return ((n ^ (n >>> 16)) >>> 0) / 4294967296;
    }
    function Engine(initial) {
        var k;
        initial = initial || {};
        this.params = {};
        for (k in DEFAULTS) {
            if (Object.prototype.hasOwnProperty.call(DEFAULTS, k)) this.params[k] = DEFAULTS[k];
        }
        for (k in initial) {
            if (Object.prototype.hasOwnProperty.call(initial, k)) this.set(k, initial[k]);
        }
    }
    Engine.prototype.set = function (name, value) {
        var r = RANGES[name];
        if (/^pitch[0-7]$/.test(name)) r = [-24, 24];
        if (!r || !isFinite(Number(value))) return false;
        this.params[name] = clamp(Math.round(Number(value)), r[0], r[1]);
        return true;
    };
    Engine.prototype.lane = function (which) {
        var p = this.params;
        return pattern(p[which + "Length"], p[which + "Hits"], p[which + "Rotate"]);
    };
    Engine.prototype.frame = function (pulse, bpm) {
        var p = this.params, a = this.lane("a"), b = this.lane("b");
        var bStride = p.bRate === 1 ? 4 : 3;
        var aStep = Math.floor(pulse / 3) % p.aLength;
        var bStep = Math.floor(pulse / bStride) % p.bLength;
        var hitA = pulse % 3 === 0 && a[aStep] === 1;
        var hitB = pulse % bStride === 0 && b[bStep] === 1;
        var collision = hitA && hitB;
        var hit = p.blend === 1 ? hitA !== hitB : (p.blend === 2 ? collision : hitA || hitB);
        var frame = { a: a, b: b, aStep: aStep, bStep: bStep, notes: [] };
        if (!hit || randomAt(p.seed, pulse, 1) * 100 >= p.chance) return frame;
        var pitchStep = Math.floor(pulse / 3) % p.pitchLength;
        var pitch = clamp(p.root + p["pitch" + pitchStep], 0, 127);
        var velocity = collision ? 120 : (hitA ? 101 : 77);
        var pulseMs = 60000 / clamp(Number(bpm) || 120, 20, 999) / 12;
        // Never schedule beyond the next possible onset on the combined lattice.
        // This leaves room for B's triplets even inside an A ratchet.
        var nextA = 3 - (pulse % 3), nextB = bStride - (pulse % bStride);
        var windowMs = Math.min(nextA, nextB) * pulseMs;
        var count = randomAt(p.seed, pulse, 2) * 100 < p.ratchet ? p.repeats : 1;
        var swingMs = (Math.floor(pulse / 3) % 2 === 1 && pulse % 3 === 0)
            ? pulseMs * 3 * p.swing / 100 : 0;
        // Swing is bounded by the next combined grid point as well.
        swingMs = Math.min(swingMs, windowMs * 0.45);
        var spacing = (windowMs - swingMs) / count;
        for (var i = 0; i < count; i += 1) {
            frame.notes.push({
                delay: swingMs + spacing * i,
                duration: spacing * p.gate / 100,
                pitch: pitch, velocity: clamp(velocity - i * 10, 1, 127),
                channel: p.channel, source: collision ? "AB" : (hitA ? "A" : "B")
            });
        }
        return frame;
    };
    // The adapter provides scheduling. This guard owns MIDI voice state.
    function Voice(send) { this.send = send; this.active = null; this.serial = 0; }
    Voice.prototype.off = function () {
        if (this.active) {
            this.send(this.active.pitch, 0, this.active.channel);
            this.active = null;
        }
    };
    Voice.prototype.on = function (pitch, velocity, channel) {
        this.off();
        this.serial += 1;
        this.active = { pitch: pitch, channel: channel, token: this.serial };
        this.send(pitch, velocity, channel);
        return this.serial;
    };
    Voice.prototype.release = function (token) {
        if (this.active && this.active.token === token) this.off();
    };
    Voice.prototype.panic = function () { this.off(); this.serial += 1; };
    return { Engine: Engine, Voice: Voice, pattern: pattern, defaults: DEFAULTS };
}());
if (typeof module !== "undefined" && module.exports) module.exports = Coastline;
