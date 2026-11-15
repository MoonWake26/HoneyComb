/// scr_state
/// Create a Script asset called "scr_state" and paste this in.
/// This file holds ALL the "what has the player done so far" data.

/// Call once at the very start of the game (obj_controller Create event).
function game_init() {
    // Field notebook: notes[$ "flower"] = true once collected
    global.notes = {};

    // Pre-flight checklist keys. Must match the "sys" value on each hotspot.
    global.sys = {
        comms:   false,
        crew:    false,
        life:    false,
        power:   false,
        nav:     false,
        payload: false
    };

    // Dialogue box state (filled by dialogue_start)
    global.dlg = { active: false, text: "", shown: 0, queue: [], speaker: "", face: -1 };


    // Fade transition state
    global.trans = { active: false, alpha: 0, phase: 1, target: room_first };
	global.pending_room = noone;
    // Which hotspot the player is standing next to (noone = nothing)
    global.hover = noone;

    // Mini-game progress + how many times we failed (nice stat for the video)
    global.mg = { tilt_done: false, chute_done: false, thrust_done: false, fails: 0 };

    // One-time cutscene lines per room
    global.intro_done = {};

    // Puzzle progress
    global.puzzles = { hypothesis: false, lights: false };
}

/// Mark a notebook note as collected.
function note_set(_id) {
    if (_id != "") global.notes[$ _id] = true;
}

/// Is this note collected?
function note_has(_id) {
    return variable_struct_exists(global.notes, _id) && global.notes[$ _id];
}

/// How many notes do we have?
function note_count() {
    var _keys = variable_struct_get_names(global.notes);
    var _n = 0;
    for (var i = 0; i < array_length(_keys); i++) {
        if (global.notes[$ _keys[i]]) _n++;
    }
    return _n;
}

/// Are all six pre-flight systems verified?
function sys_done() {
    var _keys = variable_struct_get_names(global.sys);
    for (var i = 0; i < array_length(_keys); i++) {
        if (!global.sys[$ _keys[i]]) return false;
    }
    return true;
}

/// Play some lines, but only the first time the player enters this room.
function intro_once(_key, _lines) {
    if (variable_struct_exists(global.intro_done, _key)) return;
    global.intro_done[$ _key] = true;
    dialogue_start(_lines);
}

/// Fade to black, switch room, fade back in.
function goto_room(_rm) {
    if (global.trans.active) return;
    global.trans = { active: true, alpha: 0, phase: 1, target: _rm };
}
