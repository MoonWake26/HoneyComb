if (state == "play") {
    spd = max(spd - 0.0025, 0);      // thin air slowly slows you down

    if (keyboard_check_pressed(vk_space)) {
        if (spd >= zone_lo && spd <= zone_hi) {
            state = "win";
            msg   = "PARACHUTE DEPLOYED.";
        } else {
            state = "fail";
            msg   = (spd > zone_hi)
                  ? "Too early! The chute tears."
                  : "Too late! Not enough time to slow down.";
            global.mg.fails++;
        }
        state_t = 0;
    }

    if (spd <= 0) {                   // you missed it entirely
        state = "fail";
        msg   = "You fell straight past the safe speed!";
        global.mg.fails++;
        state_t = 0;
    }
} else {
    state_t++;
    if (state_t > game_fps * 2) {
        if (state == "win") {
            global.mg.chute_done = true;
            goto_room(rm_mg_thrust);  // next mini-game
        } else {
            spd = 1.0; state = "play";
        }
    }
}