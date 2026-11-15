draw_self();

if (global.hover == id) {
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    draw_set_color(c_black);
    draw_text(x + 1, y - 15, label);
    draw_set_color(make_color_rgb(255, 214, 90));
    draw_text(x, y - 16, label);
    draw_text(x, y - 32, "[E]");
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
