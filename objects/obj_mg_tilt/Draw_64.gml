var _w = display_get_gui_width();
var _h = display_get_gui_height();

draw_box(0, 0, _w, _h, make_color_rgb(30, 14, 12), 1);

draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(make_color_rgb(255, 214, 90));
draw_text(_w / 2, 30, "PHASE 1: ATMOSPHERIC ENTRY");
draw_set_color(c_white);
draw_text(_w / 2, 54, "Keep the tilt inside the glowing zone  [ LEFT / RIGHT ]");

var _bx1 = _w * 0.15;
var _bx2 = _w * 0.85;
var _by  = _h * 0.45;

// Track
draw_box(_bx1, _by - 10, _bx2, _by + 10, make_color_rgb(70, 40, 34), 1);

// Safe zone
var _zx = lerp(_bx1, _bx2, zone);
var _zw = (_bx2 - _bx1) * zone_w * 0.5;
draw_box(_zx - _zw, _by - 14, _zx + _zw, _by + 14, make_color_rgb(120, 255, 160), 0.55);

// Tilt marker
var _mx = lerp(_bx1, _bx2, marker);
draw_box(_mx - 5, _by - 22, _mx + 5, _by + 22, c_white, 1);

// Hold progress
var _p = hold / need;
draw_box(_bx1, _by + 40, _bx1 + (_bx2 - _bx1) * _p, _by + 52, make_color_rgb(120, 220, 140), 1);
draw_set_color(c_white);
draw_text(_w / 2, _by + 58, "TILT HOLD  " + pct(clamp(_p, 0, 1)));

// Heat warning
if (heat > game_fps * 0.5) {
    draw_set_color(c_red);
    draw_text(_w / 2, _by + 90, "HEAT RISING!");
}

if (state != "play") {
    draw_box(0, _h * 0.62, _w, _h * 0.78, c_black, 0.75);
    draw_set_color(state == "win" ? make_color_rgb(120, 220, 140) : c_red);
    draw_text_ext(_w / 2, _h * 0.66, msg, 22, _w * 0.9);
}
draw_set_halign(fa_left);
