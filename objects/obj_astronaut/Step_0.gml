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

// ---- Animation (frames driven manually, no image_speed) ----
if (!variable_instance_exists(id, "facing"))    facing = "down";
if (!variable_instance_exists(id, "walk_anim")) walk_anim = 0;

image_speed = 0; // we control the frame ourselves

var _moving = (abs(hsp) > 0.2 || abs(vsp) > 0.2);

if (_moving) {
    if (abs(hsp) > abs(vsp)) facing = (hsp > 0) ? "right" : "left";
    else                     facing = (vsp > 0) ? "down"  : "up";

    walk_anim += 0.15;           // lower = slower legs
    if (walk_anim >= 4) walk_anim -= 4;
} else {
    walk_anim = 0;               // standing frame
}

switch (facing) {
    case "up":    sprite_index = spr_astronaut_up;    break;
    case "down":  sprite_index = spr_astronaut_down;  break;
    case "left":  sprite_index = spr_astronaut_left;  break;
    case "right": sprite_index = spr_astronaut_right; break;
}

image_index = floor(walk_anim);

// Sort so the player walks behind things above him
depth = -y;