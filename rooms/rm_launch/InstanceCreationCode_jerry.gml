label = "Talk to Jerry / Enter Ship";
lines = [
    "JERRY: Here she is. Your home away from home.",
    "JERRY: We just need you to complete the final onboard checks before we can authorize departure.",
    "JERRY: After you."
];
lines2 = [
    "Francis climbs aboard.",
    "A pilot's seat sits before a large control console.",
    "The pre-flight checklist lights up on the central monitor."
];
on_done = function() {
    if (done2) global.pending_room = rm_cabin;
};