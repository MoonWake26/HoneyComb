if (finished) {
    draw_set_font(fnt_game);

    var _w = display_get_gui_width();
    var _h = display_get_gui_height();

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(make_color_rgb(255, 214, 90));
    draw_text(_w * 0.5, _h * 0.82, "HONEYCOMB-01  |  MISSION COMPLETE");
    draw_set_color(c_white);
    draw_text(_w * 0.5, _h * 0.90, "Thank you for helping Tall Harvest bloom.");
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}