// Short wait after any dialogue so the Enter that closes it isn't read as a new confirm
if (global.dlg.active) {
    wait = 10;
} else if (wait > 0) {
    wait--;
}

if (!solved && !global.dlg.active && !global.trans.active && wait <= 0) {
    if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_down)) sel = 1 - sel;

    var _d = 0;
    if (keyboard_check(vk_right) && !keyboard_check(vk_left))  _d = 1;
    if (keyboard_check(vk_left)  && !keyboard_check(vk_right)) _d = -1;

    if (_d != 0) {
        if (sel == 0) sunset  = clamp(sunset  + _d * 0.5, 0, 23.5);
        else          sunrise = clamp(sunrise + _d * 0.5, 0, 23.5);
    }

    if (keyboard_check_pressed(vk_enter)) {
        if (sunset <= 19.0 && dark_hours() >= 8.0) {
            solved = true;
            global.puzzles.lights = true;
            dialogue_start([
                "The lamps dim. The dome settles into darkness.",
                "THE FOLLOWING EVENING",
                "Small native pollinators drift out from their shelters and move from bloom to bloom.",
                "NOTEBOOK: THE MISSING FRUIT"
            ]);
            // the controller changes room as soon as the dialogue finishes
            global.pending_room = rm_ending;
        } else {
            dialogue_start([
                "The lamps flicker, then stay bright. Something still isn't right.",
                "FRANCIS|suspicious: Sunset by 19:00 and at least 8 dark hours. Try again."
            ]);
        }
    }

    global_light_sunset  = sunset;
    global_light_sunrise = sunrise;
}