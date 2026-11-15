/// scr_dialogue
/// Create a Script asset called "scr_dialogue" and paste this in.
/// A queue of text lines with a typewriter effect. Space/Enter/Click advances.

/// Start a conversation. _lines is an array of strings.
/// dialogue_start(["RADIO: Good morning.", "FRANCIS: Oh! Yeah. Speaking!"]);
function dialogue_start(_lines) {
    if (!is_array(_lines) || array_length(_lines) == 0) return;
    global.dlg.queue = array_create(0);
    for (var i = 0; i < array_length(_lines); i++) {
        array_push(global.dlg.queue, _lines[i]);
    }
    global.dlg.active = true;
    dlg_next();
}

/// Pull the next line out of the queue.
function dlg_next() {
    if (array_length(global.dlg.queue) == 0) {
        global.dlg.active = false;
        global.dlg.text = "";
        return;
    }
    global.dlg.text = global.dlg.queue[0];
    array_delete(global.dlg.queue, 0, 1);
    global.dlg.shown = 0;
}

/// Call every Step (obj_controller does this for you).
function dlg_step() {
    if (!global.dlg.active) return;

    var _len = string_length(global.dlg.text);
    global.dlg.shown += 1.5;                 // typing speed (chars per frame)
    if (global.dlg.shown > _len) global.dlg.shown = _len;

    var _advance = keyboard_check_pressed(vk_space)
                || keyboard_check_pressed(vk_enter)
                || mouse_check_button_pressed(mb_left);

    if (_advance) {
        if (global.dlg.shown < _len) {
            global.dlg.shown = _len;         // first press = finish typing
        } else {
            dlg_next();                      // second press = next line
        }
    }
}

/// Draw the box. Call from obj_controller's Draw GUI event.
function dlg_draw() {
    if (!global.dlg.active) return;

    var _w = display_get_gui_width();
    var _h = display_get_gui_height();

    draw_box(_w * 0.04, _h * 0.70, _w * 0.96, _h * 0.96, c_black, 0.88);
    draw_set_color(make_color_rgb(255, 214, 90));
    draw_rectangle(_w * 0.04, _h * 0.70, _w * 0.96, _h * 0.96, true);

    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    var _vis = string_copy(global.dlg.text, 1, floor(global.dlg.shown));
    draw_text_ext(_w * 0.06, _h * 0.73, _vis, 20, _w * 0.88);

    // Blinking "continue" arrow
    if (global.dlg.shown >= string_length(global.dlg.text)) {
        if ((current_time div 400) mod 2 == 0) {
            draw_set_halign(fa_right);
            draw_text(_w * 0.93, _h * 0.92, "SPACE >");
        }
    }
    draw_set_halign(fa_left);
}
