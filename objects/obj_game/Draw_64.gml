/// @description Insert description here

show_debug_overlay(true);
draw_set_halign(fa_left)
draw_set_valign(fa_top)
var txt = "\nFPS: " + string(fps) + "\n"
		+ "Selected block: " + 
			(controller.block_selected
				? 
				(string(controller.sel_block_x) + " " + string(controller.sel_block_y) + " " + string(controller.sel_block_z))
				:
				"None")
			;
				
draw_text(0, 0, txt)

if (paused)
{
	draw_set_halign(fa_center);
	draw_set_valign(fa_center);
	draw_text(game_width/2, game_height/2, "PAUSED");
}

