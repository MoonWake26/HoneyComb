draw_set_font(fnt_game);

var _w = display_get_gui_width();
var _h = display_get_gui_height();

draw_box(0, 0, _w, _h, make_color_rgb(14, 20, 18), 1);

draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(make_color_rgb(255, 214, 90));
draw_text(_w / 2, 26, "GREENHOUSE LIGHTING CONTROLS");

// 24-hour bar
var _bx1 = _w * 0.10;
var _bx2 = _w * 0.90;
var _by  = _h * 0.32;

for (var i = 0; i < 24; i++) {
    var _x1 = lerp(_bx1, _bx2, i / 24.0);
    var _x2 = lerp(_bx1, _bx2, (i + 1) / 24.0);
    var _night = is_night(i + 0.5);
    draw_box(_x1, _by, _x2 - 1, _by + 26, _night ? make_color_rgb(40, 44, 90) : make_color_rgb(240, 220, 140), 1);
    if (i mod 3 == 0) {
        draw_set_color(c_gray);
        draw_text((_x1 + _x2) / 2, _by + 32, string(i));
    }
}

// Dusk marker
var _dx = lerp(_bx1, _bx2, 19 / 24.0);
draw_box(_dx - 2, _by - 10, _dx + 2, _by + 36, make_color_rgb(120, 255, 160), 1);
draw_set_color(make_color_rgb(120, 255, 160));
draw_text(_dx, _by - 30, "dusk 19:00");

// Dials
draw_set_color(sel == 0 ? make_color_rgb(255, 214, 90) : c_white);
draw_text(_w / 2, _h * 0.52, (sel == 0 ? "> " : "  ") + "SUNSET  " + clock_string(sunset));
draw_set_color(sel == 1 ? make_color_rgb(255, 214, 90) : c_white);
draw_text(_w / 2, _h * 0.52 + 26, (sel == 1 ? "> " : "  ") + "SUNRISE " + clock_string(sunrise));

// Live feedback
var _dark = dark_hours();
var _ok_dark = (_dark >= 8.0);
var _ok_dusk = (sunset <= 19.0);
draw_set_color(_ok_dark ? make_color_rgb(120, 220, 140) : c_red);
draw_text(_w / 2, _h * 0.68, "Dark period: " + string_format(_dark, 1, 1) + "h  (need 8h or more)");
draw_set_color(_ok_dusk ? make_color_rgb(120, 220, 140) : c_red);
draw_text(_w / 2, _h * 0.68 + 22, "Lamps off by 19:00?  " + (_ok_dusk ? "YES" : "NO"));
draw_set_color(c_white);
draw_text(_w / 2, _h * 0.68 + 44, "Crops get " + string_format(24 - _dark, 1, 1) + "h of daylight");

draw_set_color(c_gray);
draw_text(_w / 2, _h * 0.88, "[ UP/DOWN ] dial     [ LEFT/RIGHT ] adjust     [ ENTER ] confirm");
draw_set_halign(fa_left);