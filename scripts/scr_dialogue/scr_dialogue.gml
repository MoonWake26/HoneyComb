/// scr_dialogue
/// Dialogue strings can use "FRANCIS|nervous: text" or "TAVI|sad: text".
/// Francis emotions: nervous, shocked, suspicious, relieved
/// Tavi emotions: sad, excited, suspicious, relieved
/// Plain "FRANCIS: text" and "TAVI: text" use the relieved portrait.

/// Start a conversation. _lines is an array of strings.
function dialogue_start(_lines) {
    if (!is_array(_lines) || array_length(_lines) == 0) return;
    global.dlg.queue = array_create(0);
    for (var i = 0; i < array_length(_lines); i++) {
        array_push(global.dlg.queue, _lines[i]);
    }
    global.dlg.active = true;
    dlg_next();
}

/// Pull the next line out of the queue and parse its speaker/emotion prefix.
function dlg_next() {
    if (array_length(global.dlg.queue) == 0) {
        global.dlg.active = false;
        global.dlg.text = "";
        global.dlg.speaker = "";
        global.dlg.face = -1;
        return;
    }

    var _line = global.dlg.queue[0];
    array_delete(global.dlg.queue, 0, 1);
    global.dlg.shown = 0;
    global.dlg.speaker = "";
    global.dlg.face = -1;
    global.dlg.text = _line;

    // A prefix ends at the first colon-space, e.g. "FRANCIS|nervous: Hello".
    var _colon = string_pos(": ", _line);
    if (_colon > 0) {
        var _tag = string_copy(_line, 1, _colon - 1);
        var _bar = string_pos("|", _tag);
        var _emotion = "";

        if (_bar > 0) {
            global.dlg.speaker = string_copy(_tag, 1, _bar - 1);
            _emotion = string_delete(_tag, 1, _bar);
        } else {
            global.dlg.speaker = _tag;
        }

        global.dlg.text = string_delete(_line, 1, _colon + 1);

        // ---------- FRANCIS portraits ----------
        if (global.dlg.speaker == "FRANCIS") {
            switch (_emotion) {
                case "nervous":     global.dlg.face = spr_francis_nervous; break;
                case "shocked":     global.dlg.face = spr_francis_shocked; break;
                case "suspicious":  global.dlg.face = spr_francis_suspicious; break;
                case "suspicous":   global.dlg.face = spr_francis_suspicious; break;
                case "relieved":    global.dlg.face = spr_francis_relieved; break;
                default:            global.dlg.face = spr_francis_relieved; break;
            }
        }

        // ---------- TAVI portraits ----------
        if (global.dlg.speaker == "TAVI") {
            switch (_emotion) {
                case "sad":         global.dlg.face = spr_tavi_sad; break;
                case "excited":     global.dlg.face = spr_tavi_excited; break;
                case "happy":       global.dlg.face = spr_tavi_excited; break;
                case "suspicious":  global.dlg.face = spr_tavi_suspicious; break;
                case "suspicous":   global.dlg.face = spr_tavi_suspicious; break;
                case "relieved":    global.dlg.face = spr_tavi_relieved; break;
                default:            global.dlg.face = spr_tavi_relieved; break;
            }
        }
    }
}

/// Call every Step (obj_controller does this for you).
function dlg_step() {
    if (!global.dlg.active) return;

    var _len = string_length(global.dlg.text);
    global.dlg.shown += 1.5;
    if (global.dlg.shown > _len) global.dlg.shown = _len;

    var _advance = keyboard_check_pressed(vk_space)
                || keyboard_check_pressed(vk_enter)
                || mouse_check_button_pressed(mb_left);

    if (_advance) {
        if (global.dlg.shown < _len) {
            global.dlg.shown = _len;
        } else {
            dlg_next();
        }
    }
}

/// Draw the chatbox, speaker portrait, name and typewriter text in GUI coordinates.
function dlg_draw() {
    if (!global.dlg.active) return;

    draw_set_font(fnt_game);

    var _text_scale = 1.5;   // dialogue text size. Try 1.3 (smaller) or 1.8 (bigger)

    var _w = display_get_gui_width();
    var _h = display_get_gui_height();
    var _x = _w * 0.04;
    var _y = _h * 0.69;
    var _bw = _w * 0.92;
    var _bh = _h * 0.27;

    var _box = spr_chatbox;
    if (_box != -1) {
        draw_sprite_stretched(_box, 0, _x, _y, _bw, _bh);
    } else {
        draw_box(_x, _y, _x + _bw, _y + _bh, c_black, 0.9);
    }

    // Portrait sprites should have Middle Centre origin for this placement.
    if (global.dlg.face != -1) {
        var _sw = sprite_get_width(global.dlg.face);
        var _sh = sprite_get_height(global.dlg.face);
        var _scale = min(104 / _sw, 116 / _sh);
        draw_sprite_ext(global.dlg.face, 0, _x + 82, _y + _bh * 0.52,
                        _scale, _scale, 0, c_white, 1);
    }

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

    // Speaker name
    draw_set_color(make_color_rgb(255, 214, 90));
    draw_text_transformed(_x + 160, _y + 18, global.dlg.speaker, _text_scale, _text_scale, 0);

    // Dialogue text (typewriter)
    draw_set_color(c_white);
    var _vis = string_copy(global.dlg.text, 1, floor(global.dlg.shown));
    draw_text_ext_transformed(_x + 160, _y + 56, _vis,
                              20, (_bw - 190) / _text_scale,
                              _text_scale, _text_scale, 0);

    if (global.dlg.shown >= string_length(global.dlg.text)) {
        if ((current_time div 400) mod 2 == 0) {
            draw_set_halign(fa_right);
            draw_text_transformed(_x + _bw - 34, _y + _bh - 34, "SPACE >", 1.2, 1.2, 0);
        }
    }
    draw_set_halign(fa_left);
}