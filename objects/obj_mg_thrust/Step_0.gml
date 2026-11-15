if (state == "play") {
    var _burning = keyboard_check(vk_space);
    if (_burning && fuel > 0) {
        spd  = max(spd - 0.0045, 0);      // engine slows you
        fuel = max(fuel - 0.0012, 0);     // but burns fuel
    } else {
        spd = min(spd + 0.0010, 1.2);     // gravity wins if you let go
    }

    alt = max(alt - spd * 0.0028, 0);

    if (alt <= 0) {
        if (spd <= safe_spd) {
            state = "win";
            msg   = "TOUCHDOWN CONFIRMED.";
        } else {
            state = "fail";
            msg   = "Too fast! A bumpy landing. The potted plant slides off its shelf.";
            global.mg.fails++;
        }
        state_t = 0;
    } else if (fuel <= 0 && spd > safe_spd) {
        state = "fail";
        msg   = "Out of fuel and still falling!";
        global.mg.fails++;
        state_t = 0;
    }
} else {
    state_t++;
    if (state_t > game_fps * 2) {
        if (state == "win") {
            global.mg.thrust_done = true;
            goto_room(rm_dome);            // landed! on to Tall Harvest
        } else {
            alt = 1.0; spd = 0.90; fuel = 1.0; state = "play";
        }
    }
}