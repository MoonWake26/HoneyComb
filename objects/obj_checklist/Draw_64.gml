var _w = display_get_gui_width();
var _x = _w - 210;
var _y = 20;

draw_box(_x - 12, _y - 10, _w - 12, _y + 130, c_black, 0.65);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(make_color_rgb(255, 214, 90));
draw_text(_x, _y - 2, "PRE-FLIGHT INSPECTION");
draw_set_color(c_white);

for (var i = 0; i < array_length(labels); i++) {
    var _done = global.sys[$ keys[i]];
    draw_tick(_x, _y + 18 + i * 18, labels[i], _done,
              _done ? make_color_rgb(120, 220, 140) : c_yellow);
}
