draw_set_font(fnt_game);

var _w = display_get_gui_width();
var _h = display_get_gui_height();

draw_box(0, 0, _w, _h, make_color_rgb(18, 26, 20), 1);

draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(make_color_rgb(255, 214, 90));
draw_text(_w / 2, _h * 0.16, "NOTEBOOK: HYPOTHESIS READY");
draw_set_color(c_white);
draw_text(_w / 2, _h * 0.24, "FRANCIS: I think I've got it. Here's what I'd say is going on...");

for (var i = 0; i < array_length(options); i++) {
    var _y = _h * 0.40 + i * 46;
    var _sel = (i == cursor);
    if (_sel) {
        draw_box(_w * 0.12, _y - 6, _w * 0.88, _y + 30, make_color_rgb(70, 90, 60), 0.8);
    }
    draw_set_color(_sel ? make_color_rgb(255, 214, 90) : c_white);
    draw_text(_w / 2, _y, (_sel ? "> " : "  ") + options[i]);
}

draw_set_color(c_gray);
draw_text(_w / 2, _h * 0.85, "[ UP / DOWN ] choose     [ ENTER ] confirm");
draw_set_halign(fa_left);