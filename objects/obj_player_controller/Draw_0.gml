var xpos = plyr.pos_x * global.world_scale
var ypos = (plyr.pos_y + plyr.eye_level) * global.world_scale
var zpos = plyr.pos_z * global.world_scale
var xto = xpos + dcos(plyr.rot_pitch)*dsin(plyr.rot_yaw)
var yto = ypos - dsin(plyr.rot_pitch)
var zto = zpos + dcos(plyr.rot_pitch)*dcos(plyr.rot_yaw)
if (obj_game.thirdperson)
{
	xto = xpos
	yto = ypos
	zto = zpos
	xpos = xto - dcos(plyr.rot_pitch)*dsin(plyr.rot_yaw) * 200
	ypos = yto + dsin(plyr.rot_pitch) * 200
	zpos = zto - dcos(plyr.rot_pitch)*dcos(plyr.rot_yaw) * 200
}
var mLookat = matrix_build_lookat(xpos,ypos,zpos,xto,yto,zto,0,-1,0);
camera_set_view_mat(obj_camera.cam, mLookat);
camera_apply(obj_camera.cam)

r_push_matrix()
r_translate(xpos, ypos, zpos)
//r_scale(2, 2, 2)
gpu_set_zwriteenable(false)
gpu_set_cullmode(cull_clockwise);
vertex_submit(skybox, pr_trianglelist, sprite_get_texture(tx_skybox_top, 0))
gpu_set_cullmode(cull_counterclockwise)
gpu_set_zwriteenable(true)
r_pop_matrix()
	
if (block_selected)
{
	r_push_matrix();
	var outline_buf = r_start_drawing(global.vformat_outline);
	br_draw_block_outline(outline_buf, sel_block_x, sel_block_y, sel_block_z);
	r_stop_drawing(outline_buf);
	vertex_submit(outline_buf, pr_linelist, sprite_get_texture(tx_null_block, 0))
	vertex_delete_buffer(outline_buf)
	r_pop_matrix();
}