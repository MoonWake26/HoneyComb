var _w = display_get_gui_width();
var _h = display_get_gui_height();

draw_box(0, 0, _w, _h, make_color_rgb(24, 16, 14), 1);

draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(make_color_rgb(255, 214, 90));
draw_text(_w / 2, 30, "PHASE 3: RETRO-THRUSTERS");
draw_set_color(c_white);
draw_text(_w / 2, 54, "Hold SPACE to slow down. Land gently, don't waste fuel.");

// Altitude column
var _cx = _w * 0.5;
var _top = _h * 0.18;
var _bot = _h * 0.80;
draw_box(_cx - 60, _top, _cx + 60, _bot, make_color_rgb(40, 30, 28), 1);
draw_box(_cx - 60, _bot - 6, _cx + 60, _bot, make_color_rgb(180, 70, 60), 1);  // ground

// Ship marker
var _sy = lerp(_bot, _top, alt);
draw_box(_cx - 14, _sy - 10, _cx + 14, _sy + 10,
         keyboard_check(vk_space) ? make_color_rgb(255, 160, 60) : c_white, 1);

// Speed gauge
var _gx1 = _w * 0.72;
var _gx2 = _w * 0.92;
var _gy  = _h * 0.35;
draw_box(_gx1, _gy - 10, _gx2, _gy + 10, make_color_rgb(40, 40, 60), 1);
draw_box(_gx1, _gy - 12, lerp(_gx1, _gx2, safe_spd / 1.2), _gy + 12,
         make_color_rgb(120, 255, 160), 0.5);
var _nx = lerp(_gx1, _gx2, clamp(spd / 1.2, 0, 1));
draw_box(_nx - 3, _gy - 18, _nx + 3, _gy + 18, c_white, 1);
draw_set_color(c_white);
draw_text((_gx1 + _gx2) / 2, _gy + 26, "SPEED");
draw_text((_gx1 + _gx2) / 2, _gy + 44, "land below green");

// Fuel gauge
var _fy = _h * 0.62;
draw_box(_gx1, _fy - 10, _gx2, _fy + 10, make_color_rgb(40, 40, 60), 1);
draw_box(_gx1, _fy - 10, lerp(_gx1, _gx2, fuel), _fy + 10,
         fuel > 0.25 ? make_color_rgb(120, 220, 140) : c_red, 1);
draw_set_color(c_white);
draw_text((_gx1 + _gx2) / 2, _fy + 20, "FUEL  " + pct(fuel));

// Altitude readout
draw_text(_cx, _bot + 14, "ALTITUDE  " + pct(alt));

if (state != "play") {
    draw_box(0, _h * 0.60, _w, _h * 0.76, c_black, 0.75);
    draw_set_color(state == "win" ? make_color_rgb(120, 220, 140) : c_red);
    draw_text_ext(_w / 2, _h * 0.64, msg, 22, _w * 0.9);
}
draw_set_halign(fa_left);