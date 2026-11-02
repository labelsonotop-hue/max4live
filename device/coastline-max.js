/* Classic Max [js] adapter. No Node for Max or external packages required. */
autowatch = 1;
inlets = 1;
outlets = 5; // raw MIDI; display; clock enable; Live play state; clock interval (ms)
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
var clockState = -1;
var playingAPI = null;
var tempoAPI = null;
var pollTask = null;
var deleted = 0;
var apiWarning = 0;

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
function refreshclock() {
    // Send the tempo before enabling a plain millisecond metro.
    outlet(4, 60000 / bpm / 12);
    outlet(3, playing);
    var next = enabled && playing && deviceActive && !suspended ? 1 : 0;
    if (next !== clockState) {
        clockState = next;
        outlet(2, next);
    }
}
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
        bpm = Math.max(20, Math.min(999, Number(value)));
        clearqueue();
        refreshclock();
    }
}
function bang() {
    if (deleted || !(enabled && playing && deviceActive && !suspended)) return;
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
function livechange(args) {
    if (deleted || !args || args.length < 2) return;
    if (args[0] === "tempo") tempo(args[1]);
    if (args[0] === "is_playing") transport(args[1]);
}
function apivalue(api, property) {
    var value = api.get(property);
    var list = value !== null && typeof value === "object" && typeof value.length === "number";
    var number = Number(list ? value[value.length - 1] : value);
    if (!isFinite(number)) throw new Error("Invalid Live property: " + property);
    return number;
}
function readlive() {
    if (deleted) return;
    try {
        // Bind tempo before play, so the first clock uses the current BPM.
        if (!tempoAPI || Number(tempoAPI.id) === 0) {
            tempoAPI = new LiveAPI(livechange, "live_set");
            if (Number(tempoAPI.id) === 0) throw new Error("Live API is not ready");
            tempoAPI.property = "tempo";
        }
        tempo(apivalue(tempoAPI, "tempo"));
        if (!playingAPI || Number(playingAPI.id) === 0) {
            playingAPI = new LiveAPI(livechange, "live_set");
            if (Number(playingAPI.id) === 0) throw new Error("Live API is not ready");
            playingAPI.property = "is_playing";
        }
        transport(apivalue(playingAPI, "is_playing"));
        if (apiWarning) post("COASTLINE Live connection restored\n");
        apiWarning = 0;
    } catch (error) {
        transport(0);
        if (!apiWarning) post("COASTLINE Live connection: " + error + "; retrying\n");
        apiWarning = 1;
    }
}
function poll() {
    if (deleted) return;
    readlive();
    pollTask.schedule(100);
}
function init() {
    if (deleted) return;
    if (!pollTask) {
        post("COASTLINE 0.4 ready\n");
        pollTask = new Task(poll, this);
    }
    pollTask.cancel();
    redraw();
    readlive();
    refreshclock();
    pollTask.schedule(100);
}
function notifydeleted() {
    deleted = 1;
    if (pollTask) pollTask.cancel();
    clearqueue();
    outlet(2, 0);
    for (var i = 0; i < 2; i += 1) {
        var api = i === 0 ? playingAPI : tempoAPI;
        if (api) {
            try { api.property = ""; api.id = 0; } catch (error) { /* Device already gone. */ }
        }
    }
}
