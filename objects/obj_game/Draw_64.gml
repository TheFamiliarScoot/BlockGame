/// @description Insert description here

//show_debug_overlay(true);
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
				
t_draw_text_shadowed(txt, 0, -16);

if (paused)
{
	draw_sprite_tiled_ext(tx_dirt, 0, 0, 0, 4, 4, make_color_rgb(128, 128, 128), 1)
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	t_draw_text_shadowed("PAUSED", game_width/2, game_height/2, true);
}
else
{
	var b = r_start_drawing(global.vformat_block)
	var i = 0;
	repeat (6)
	{
		br_draw_face(b, global.blocks[controller.hotbar_blocks[controller.selected_block]], 0, 0, 0, i)
		i++;
	}
	r_stop_drawing(b)
	r_push_matrix()
	r_scale(64, 64, 64)
	r_rotate(90, 0, 45)
	r_rotate(60, 0, 0)
	r_translate(game_width - 100, game_height - 30, 0)
	vertex_submit(b, pr_trianglelist, sprite_get_texture(tx_stone, 0))
	r_pop_matrix()
	vertex_delete_buffer(b)	
}

