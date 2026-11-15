label = "The Radio";
lines = [
    "The radio beside your tools crackles.",
    "RADIO: Good morning. This is NASA Mission Control.",
    "FRANCIS: Oh! Yeah. Speaking!",
    "RADIO: Your preparations are complete. Please make your way to the launch facility."
];
on_done = function() {
    if (done) global.pending_room = rm_launch;
};
