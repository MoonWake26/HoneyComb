var _w = display_get_gui_width();
var _h = display_get_gui_height();

draw_box(0, 0, _w, _h, make_color_rgb(20, 18, 34), 1);

draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(make_color_rgb(255, 214, 90));
draw_text(_w / 2, 30, "PHASE 2: PARACHUTE");
draw_set_color(c_white);
draw_text(_w / 2, 54, "Press SPACE when the speed enters the green zone");

var _bx1 = _w * 0.15;
var _bx2 = _w * 0.85;
var _by  = _h * 0.45;

draw_box(_bx1, _by - 12, _bx2, _by + 12, make_color_rgb(40, 40, 60), 1);

// Green zone
draw_box(lerp(_bx1, _bx2, zone_lo), _by - 16, lerp(_bx1, _bx2, zone_hi), _by + 16,
         make_color_rgb(120, 255, 160), 0.55);

// Needle
var _nx = lerp(_bx1, _bx2, spd);
draw_box(_nx - 4, _by - 24, _nx + 4, _by + 24, c_white, 1);

draw_set_color(c_white);
draw_text(_w / 2, _by + 40, "DESCENT SPEED  " + pct(spd));

if (state != "play") {
    draw_box(0, _h * 0.62, _w, _h * 0.78, c_black, 0.75);
    draw_set_color(state == "win" ? make_color_rgb(120, 220, 140) : c_red);
    draw_text_ext(_w / 2, _h * 0.66, msg, 22, _w * 0.9);
}
draw_set_halign(fa_left);
