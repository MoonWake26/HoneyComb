if (state == "play") {
    t++;
    // The safe zone drifts back and forth
    zone = 0.5 + sin(t / 80) * 0.24;

    // Player tilts the ship. It has momentum, so it feels like a real craft.
    var _dir = keyboard_check(vk_right) - keyboard_check(vk_left);
    vel += _dir * 0.00045;
    vel *= 0.97;
    marker = clamp(marker + vel, 0, 1);

    var _inside = abs(marker - zone) < zone_w * 0.5;
    if (_inside) {
        hold++;
        heat = max(heat - 2, 0);
    } else {
        hold = max(hold - 2, 0);
        heat++;
    }

    if (heat > game_fps * 1.5) {
        state   = "fail";
        state_t = 0;
        msg     = "The cabin gets toasty. A bee fans herself with a wing.";
        global.mg.fails++;
    } else if (hold >= need) {
        state   = "win";
        state_t = 0;
        msg     = "HEAT SHIELD HOLDING.";
    }
} else {
    state_t++;
    if (state_t > game_fps * 2) {
        if (state == "win") {
            global.mg.tilt_done = true;
            goto_room(rm_mg_chute);            // next mini-game
        } else {
            state = "play"; hold = 0; heat = 0; marker = 0.5; vel = 0;
        }
    }
}
