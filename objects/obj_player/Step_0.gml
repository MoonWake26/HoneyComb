// No walking while someone is talking
if (global.dlg.active || global.trans.active) {
    hsp = approach(hsp, 0, 0.5);
    vsp = approach(vsp, 0, 0.5);
} else {
    var _ix = (keyboard_check(vk_right) || keyboard_check(ord("D")))
            - (keyboard_check(vk_left)  || keyboard_check(ord("A")));
    var _iy = (keyboard_check(vk_down)  || keyboard_check(ord("S")))
            - (keyboard_check(vk_up)    || keyboard_check(ord("W")));

    // Normalise so diagonal isn't faster
    if (_ix != 0 && _iy != 0) {
        _ix *= 0.7071;
        _iy *= 0.7071;
    }

    hsp = approach(hsp, _ix * spd, 0.4);
    vsp = approach(vsp, _iy * spd, 0.4);
}

// Move with collision against obj_solid
x += hsp;
if (place_meeting(x, y, obj_solid)) x -= hsp;

y += vsp;
if (place_meeting(x, y, obj_solid)) y -= vsp;

// Sort so the player walks behind things above him
depth = -y;