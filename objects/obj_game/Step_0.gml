try
{
	if (window_get_width() != game_width || window_get_height() && window_has_focus())
	{
		game_width = window_get_width()
		game_height = window_get_height()
		with (obj_camera)
		{
			projMat = matrix_build_projection_perspective_fov(70, other.game_width/other.game_height, 1, 32000)
			camera_set_proj_mat(cam, projMat)
		}
		surface_resize(application_surface, game_width, game_height)
	}		
}
catch (e) {}

if (keyboard_check_pressed(vk_escape) || gamepad_button_check_pressed(0, gp_start))
{
	paused = !paused
	if (paused)
	{
		instance_deactivate_object(obj_spatial)
	}
	else
	{
		instance_activate_object(obj_spatial)
	}
	window_set_cursor(cr_default);
}

if (keyboard_check_pressed(vk_f5) || gamepad_button_check_pressed(0, gp_stickl))
{
	thirdperson = !thirdperson
}