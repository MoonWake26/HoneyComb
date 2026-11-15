label = "Begin Descent Training";
lines = [
    "MISSION CONTROL: Mars approach confirmed. Beginning atmospheric entry training.",
    "FRANCIS|nervous: Heat shield first. Keep the ship inside the safe zone.",
    "MISSION CONTROL: Use LEFT and RIGHT to control the tilt."
];
on_done = function() {
    if (done) global.pending_room = rm_mg_tilt;
};