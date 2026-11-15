var _w = display_get_gui_width();
var _h = display_get_gui_height();

draw_box(0, 0, _w, _h, make_color_rgb(18, 20, 34), 1);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_color(make_color_rgb(255, 214, 90));
draw_text_transformed(_w / 2, _h * 0.36, "HONEYCOMB-01", 3, 3, 0);

draw_set_color(c_white);
draw_text_transformed(_w / 2, _h * 0.48, "Interplanetary Botanical Research Vessel", 1.2, 1.2, 0);

draw_set_color(make_color_rgb(180, 200, 255));
draw_text(_w / 2, _h * 0.62, "A junior astronaut mission trainer");

if ((t div 40) mod 2 == 0) {
    draw_set_color(c_white);
    draw_text(_w / 2, _h * 0.80, "PRESS ENTER");
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);