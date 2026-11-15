if (!announced && sys_done()) {
    announced = true;
    launch_t = 0;
    dialogue_start([
        "RADIO: All pre-flight inspections are confirmed. Please return to your pilot's seat.",
        "ALL SYSTEMS GO. FLIGHT STATUS: READY FOR DEPARTURE."
    ]);
}

if (launch_t >= 0) {
    launch_t++;
    if (launch_t > game_fps * 5 && !global.dlg.active) {
        goto_room(rm_map);
    }
}
