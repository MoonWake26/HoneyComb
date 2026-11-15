dlg_draw();

if (global.trans.active) {
    draw_box(0, 0, display_get_gui_width(), display_get_gui_height(), c_black, global.trans.alpha);
}