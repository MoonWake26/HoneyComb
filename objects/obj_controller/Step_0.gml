// 1) Dialogue typing + advancing
dlg_step();

// 2) Fade transitions
if (global.trans.active) {
    if (global.trans.phase == 1) {
        global.trans.alpha += 0.07;
        if (global.trans.alpha >= 1) {
            global.trans.alpha = 1;
            room_goto(global.trans.target);
            global.trans.phase = 2;
        }
    } else {
        global.trans.alpha -= 0.07;
        if (global.trans.alpha <= 0) {
            global.trans.alpha = 0;
            global.trans.active = false;
        }
    }
}

// 3) Find the nearest hotspot to the player, then act on E
global.hover = noone;
if (instance_exists(obj_player) && !global.dlg.active && !global.trans.active) {
    var _best = 9999;
    with (obj_hotspot) {
        var _d = point_distance(x, y, obj_player.x, obj_player.y);
        if (_d < 46 && _d < _best) {
            _best = _d;
            global.hover = id;
        }
    }

    if (global.hover != noone && keyboard_check_pressed(ord("E"))) {
        var _h = global.hover;

        if (!_h.done) {
            // --- First interaction: examine ---
            dialogue_start(_h.lines);
            note_set(_h.note);
            if (_h.sys != "") global.sys[$ _h.sys] = true;
            _h.done = true;
        } else if (!_h.done2 && array_length(_h.lines2) > 0) {
            // --- Second interaction: use it ---
            dialogue_start(_h.lines2);
            note_set(_h.note2);
            if (_h.sys2 != "") global.sys[$ _h.sys2] = true;
            _h.done2 = true;
        } else if (array_length(_h.repeat_lines) > 0) {
            // --- Third+: flavour text ---
            dialogue_start(_h.repeat_lines);
        }

        // Optional custom code attached to this hotspot
        if (is_callable(_h.on_done)) _h.on_done();
    }
}