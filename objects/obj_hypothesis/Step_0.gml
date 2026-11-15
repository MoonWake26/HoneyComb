// Short wait after any dialogue so the Enter that closes it isn't read as a new answer
if (!variable_instance_exists(id, "wait")) wait = 0;
if (global.dlg.active) {
    wait = 10;
} else if (wait > 0) {
    wait--;
}

if (!solved && !global.dlg.active && !global.trans.active && wait <= 0) {
    if (keyboard_check_pressed(vk_up)) {
        cursor = (cursor + array_length(options) - 1) mod array_length(options);
    }
    if (keyboard_check_pressed(vk_down)) {
        cursor = (cursor + 1) mod array_length(options);
    }

    if (keyboard_check_pressed(vk_enter)) {
        if (cursor == correct) {
            solved = true;
            global.puzzles.hypothesis = true;
            dialogue_start([
                "TAVI|sad: Oh! We've been keeping the whole dome bright!",
                "FRANCIS|relieved: Let's restore the dark hours and see if they come back.",
                "TAVI|suspicious: But the crops need light too. How long should we dim them?",
                "FRANCIS|relieved: I'll handle that."
            ]);
            // the controller changes room as soon as the dialogue finishes
            global.pending_room = rm_lighting;
        } else {
            var _j = (cursor == 0) ? jokes[0] : jokes[1];
            dialogue_start([
                _j,
                "TAVI|suspicious: Hmm, that doesn't explain it. Try again!"
            ]);
        }
    }
}