t++;
if (keyboard_check_pressed(vk_enter) && !global.trans.active) {
    game_init();                       // fresh run
    goto_room(rm_apiary);              // change to your first gameplay room
}