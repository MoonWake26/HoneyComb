/// scr_util
/// Create a Script asset called "scr_util" and paste this whole file in.
/// Small helpers you will use all over the game.

/// Moves _val towards _target by at most _step. Use it for smooth bars/needles.
function approach(_val, _target, _step) {
    if (_val < _target) return min(_val + _step, _target);
    return max(_val - _step, _target);
}

/// Filled rectangle in GUI coordinates, then restores alpha.
function draw_box(_x1, _y1, _x2, _y2, _col, _alpha) {
    draw_set_alpha(_alpha);
    draw_set_color(_col);
    draw_rectangle(_x1, _y1, _x2, _y2, false);
    draw_set_alpha(1);
}

/// A tick box + label. _done = tick it.
function draw_tick(_x, _y, _label, _done, _col) {
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
    draw_rectangle(_x, _y, _x + 14, _y + 14, true);
    if (_done) {
        draw_set_color(_col);
        draw_rectangle(_x + 3, _y + 3, _x + 11, _y + 11, false);
    }
    draw_set_color(_done ? c_white : c_gray);
    draw_text(_x + 22, _y, _label);
    draw_set_color(c_white);
}

/// Formats a 0..1 number as "72%"
function pct(_v) {
    return string(round(_v * 100)) + "%";
}

// ---------- Lighting puzzle helpers (used by obj_lighting) ----------

/// Hours of darkness between sunset and sunrise (wraps past midnight).
function dark_hours() {
    var _d = global_light_sunrise - global_light_sunset;
    if (_d < 0) _d += 24;
    return _d;
}

/// Is hour h (0-24) inside the dark period? Uses the two globals below.
function is_night(_h) {
    var _s = global_light_sunset;
    var _r = global_light_sunrise;
    if (_s < _r) return (_h < _s || _h >= _r);
    return (_h >= _s || _h < _r);
}

/// 19.5 -> "19:30"
function clock_string(_h) {
    var _hh = floor(_h);
    var _mm = (_h - _hh) * 60;
    return string(_hh) + ":" + ((_mm < 10) ? "0" : "") + string(round(_mm));
}
