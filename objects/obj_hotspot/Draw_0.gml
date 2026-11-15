draw_self();

if (global.hover == id) {
    draw_set_font(fnt_game);

    var _s = 0.4;   // text size. Try 0.3 to 0.6

    var _tx = clamp(x, 40, room_width - 40);
    var _ty = max(y, 40);

    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);

    draw_set_color(c_black);
    draw_text_transformed(_tx + 1, _ty - 9, label, _s, _s, 0);

    draw_set_color(make_color_rgb(255, 214, 90));
    draw_text_transformed(_tx, _ty - 10, label, _s, _s, 0);
    draw_text_transformed(_tx, _ty - 20, "[E]", _s, _s, 0);

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
}