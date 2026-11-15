// Pick the music for this room
var _track = -1;

switch (room) {
    case rm_title:       _track = mus_title;      break;
    case rm_apiary:      _track = mus_apiary;     break;
    case rm_launch:      _track = mus_launch;     break;
    case rm_cabin:       _track = mus_cabin;      break;
    case rm_map:         _track = mus_map;        break;
    case rm_mg_tilt:     _track = mus_map;   break;
    case rm_mg_chute:    _track = mus_map;   break;
    case rm_mg_thrust:   _track = mus_map;   break;
    case rm_dome:        _track = mus_dome;       break;
    case rm_hypothesis:  _track = mus_ending; break;
    case rm_lighting:    _track = mus_lighting;   break;
    case rm_ending:      _track = mus_ending;     break;
}

// Only change the music if it's a different song (so the 3 minigames keep one song playing)
if (_track != global.music_track) {
    if (global.music_inst != -1) {
        audio_stop_sound(global.music_inst);
        global.music_inst = -1;
    }

    global.music_track = _track;

    if (_track != -1) {
        var _vol = 0.6;   // music loudness, 0.0 to 1.0
        global.music_inst = audio_play_sound(_track, 1, true);   // true = loops
        audio_sound_gain(global.music_inst, 0, 0);
        audio_sound_gain(global.music_inst, _vol, 1000);          // fades in over 1 second
    }
}