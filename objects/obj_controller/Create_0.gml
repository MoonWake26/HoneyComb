persistent = true;
display_set_gui_size(960, 720);
window_set_caption("HONEYCOMB-01");
game_init();
draw_set_font(fnt_game);

// Music memory (which song is playing now)
global.music_track = -1;
global.music_inst  = -1;

dialogue_start(["FRANCIS|nervous: This is a portrait test."]);