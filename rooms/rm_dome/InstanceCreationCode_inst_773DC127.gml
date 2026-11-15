label = "Check Field Notebook";
lines = ["FRANCIS: Let's check what I've found."];
on_done = function() {
    if (done) {
        if (note_has("flower") && note_has("monitor") && note_has("lights")) {
            global.pending_room = rm_hypothesis;
        } else {
            dialogue_start([
                "FIELD NOTEBOOK: The required clues are still missing.",
                "Find the flower, pollinator monitor, and lighting controls first."
            ]);
        }
    }
};