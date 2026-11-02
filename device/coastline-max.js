/* Classic Max [js] adapter. No Node for Max or external packages required. */
autowatch = 1;
inlets = 1;
outlets = 3; // raw MIDI packets; pattern display; metro enable
include("coastline-core.js");

var engine = new Coastline.Engine({});
var voice = new Coastline.Voice(function (pitch, velocity, channel) {
    // Explicit MIDI status: note-on 0x90 / note-off 0x80, channels 1–16.
    outlet(0, [(velocity > 0 ? 143 : 127) + channel, pitch, velocity]);
});
var pulse = -1;
var bpm = 120;
var enabled = 1;
var playing = 0;
var deviceActive = 1;
var suspended = 0;
var pending = [];
var generation = 0;

function later(fn, delay) {
    var epoch = generation;
    var task = new Task(function () {
        var i = pending.indexOf(task);
        if (i >= 0) pending.splice(i, 1);
        if (epoch === generation) fn();
    }, this);
    pending.push(task);
    task.schedule(Math.max(0, delay));
}
function clearqueue() {
    generation += 1;
    for (var i = 0; i < pending.length; i += 1) pending[i].cancel();
    pending = [];
    voice.panic();
}
function display(frame) {
    outlet(1, ["lanea", frame.aStep].concat(frame.a));
    outlet(1, ["laneb", frame.bStep].concat(frame.b));
}
function redraw() { display(engine.frame(Math.max(0, pulse), bpm)); }
function refreshclock() { outlet(2, enabled && playing && deviceActive && !suspended ? 1 : 0); }
function param(name, value) {
    if (name === "enabled") {
        enabled = Number(value) ? 1 : 0;
        suspended = 0;
        clearqueue();
        pulse = -1;
        refreshclock();
        return;
    }
    if (engine.set(name, value)) {
        clearqueue();
        redraw();
    }
}
function deviceactive(value) {
    deviceActive = Number(value) ? 1 : 0;
    clearqueue();
    pulse = -1;
    refreshclock();
}
function transport(value) {
    var next = Number(value) ? 1 : 0;
    if (next !== playing) {
        clearqueue();
        pulse = -1;
        playing = next;
        suspended = 0;
        post("COASTLINE transport " + playing + "\n");
        redraw();
        refreshclock();
    }
}
function tempo(value) {
    if (isFinite(Number(value)) && Number(value) > 0 && Number(value) !== bpm) {
        bpm = Number(value);
        clearqueue();
    }
}
function bang() {
    if (!(enabled && playing && deviceActive && !suspended)) return;
    pulse += 1;
    var frame = engine.frame(pulse, bpm);
    display(frame);
    for (var i = 0; i < frame.notes.length; i += 1) {
        scheduleNote(frame.notes[i]);
    }
}
function scheduleNote(note) {
    var start = function () {
        var token = voice.on(note.pitch, note.velocity, note.channel);
        later(function () { voice.release(token); }, note.duration);
    };
    if (note.delay <= 0) start();
    else later(start, note.delay);
}
function reset() {
    clearqueue();
    pulse = -1;
    suspended = 0;
    redraw();
    refreshclock();
}
function panic() {
    clearqueue();
    // Latch silent until RESET, an enable change, or the next transport start.
    suspended = 1;
    refreshclock();
}
function init() { post("COASTLINE 0.3 ready\n"); redraw(); refreshclock(); }
function notifydeleted() { clearqueue(); }
