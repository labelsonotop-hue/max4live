/* Read-only two-lane rhythm display for [jsui]. */
autowatch = 1;
inlets = 1;
outlets = 0;
mgraphics.init();
mgraphics.relative_coords = 0;
mgraphics.autofill = 0;
var lanes = [{ step: -1, pattern: [] }, { step: -1, pattern: [] }];
function lanea() { setlane(0, arrayfromargs(arguments)); }
function laneb() { setlane(1, arrayfromargs(arguments)); }
function setlane(n, args) {
    lanes[n].step = args[0];
    lanes[n].pattern = args.slice(1);
    mgraphics.redraw();
}
function paint() {
    var w = box.rect[2] - box.rect[0], h = box.rect[3] - box.rect[1];
    mgraphics.set_source_rgba(0.055, 0.075, 0.09, 1);
    mgraphics.rectangle(0, 0, w, h); mgraphics.fill();
    for (var n = 0; n < 2; n += 1) {
        var lane = lanes[n], y = 5 + n * (h / 2);
        var cell = (w - 8) / Math.max(1, lane.pattern.length);
        for (var i = 0; i < lane.pattern.length; i += 1) {
            var on = lane.pattern[i], current = i === lane.step;
            if (current) mgraphics.set_source_rgba(0.95, 0.95, 0.86, 1);
            else if (on && n === 0) mgraphics.set_source_rgba(0.98, 0.62, 0.27, 1);
            else if (on) mgraphics.set_source_rgba(0.3, 0.78, 0.76, 1);
            else mgraphics.set_source_rgba(0.18, 0.23, 0.27, 1);
            mgraphics.rectangle(4 + i * cell, y, Math.max(1, cell - 3), h / 2 - 9);
            mgraphics.fill();
            if (on && current) {
                mgraphics.set_source_rgba(0.08, 0.11, 0.13, 1);
                mgraphics.rectangle(6 + i * cell, y + 2, Math.max(1, cell - 7), 2);
                mgraphics.fill();
            }
        }
    }
}
