with (plyr)
{
	var _dt = delta_time / 1000000;
	other.move_vec.x = 0;
	other.move_vec.y = 0;
	other.look_vec.x = 0;
	other.look_vec.y = 0;
	if (!gamepad_is_connected(0))
	{
		var mouse_in_x = window_mouse_get_x() >= 0 && window_mouse_get_x() < window_get_width();
		var mouse_in_y = window_mouse_get_y() >= 0 && window_mouse_get_y() < window_get_height();
		if (window_has_focus() && mouse_in_x && mouse_in_y)
		{
			var md = other.mouse_deadzone
			var xx = ((window_mouse_get_x() - window_get_width() / 2) * _dt)
			var yy = ((window_mouse_get_y() - window_get_height() / 2) * _dt)
			other.look_vec.x = xx < md && xx > -md ? 0 : xx * other.sensitivity
			other.look_vec.y = yy < md && yy > -md ? 0 : yy * other.sensitivity
			window_set_cursor(cr_none);	
			window_mouse_set(window_get_width() / 2, window_get_height() / 2);
		}
		other.move_vec.x = keyboard_check(ord("D")) - keyboard_check(ord("A"));
		other.move_vec.y = keyboard_check(ord("S")) - keyboard_check(ord("W"));
	}
	else
	{
		other.look_vec.x = (gamepad_axis_value(0, gp_axisrh) * _dt) * other.sensitivity * 20;
		other.look_vec.y = (gamepad_axis_value(0, gp_axisrv) * _dt) * other.sensitivity * 20;
		other.move_vec.x = gamepad_axis_value(0, gp_axislh);
		other.move_vec.y = gamepad_axis_value(0, gp_axislv);
	}
	
	var forward = new vec2(dsin(rot_yaw),dcos(rot_yaw));
	var right = new vec2(dcos(rot_yaw),-dsin(rot_yaw));
	
	var move_dir = forward.mul(-other.move_vec.y).add(right.mul(-other.move_vec.x));
	
	rot_yaw -= other.look_vec.x;
	rot_pitch += other.look_vec.y;
	vel_x += move_dir.x * other.spd;
	vel_z += move_dir.y * other.spd;
	
	rot_pitch = clamp(rot_pitch, -88, 88)
		
	if (gamepad_button_check(0, gp_face1) || keyboard_check(vk_space)) && on_ground
	{
		vel_y = 6 * other.spd;
	}
	
	other.ray.pos.x = pos_x;
	other.ray.pos.y = pos_y + eye_level;
	other.ray.pos.z = pos_z;
	other.ray.dir.x = dcos(rot_pitch)*dsin(rot_yaw);
	other.ray.dir.y = -dsin(rot_pitch);
	other.ray.dir.z = dcos(rot_pitch)*dcos(rot_yaw);
	
	other.block_selected = false
	var lastdist = infinity
	for (var i = 0; i < array_length(block_pool); i++)
	{
		var pool_entry = block_pool[i]
		var block_aabb = global.blocks[pool_entry[0]].get_aabb(pool_entry[1], pool_entry[2], pool_entry[3])
		if (block_aabb.check_ray(other.ray, other.hit))
		{
			if (other.hit.distance < lastdist)
			{
				other.block_selected = true
				other.sel_block_x = floor(pool_entry[1])
				other.sel_block_y = floor(pool_entry[2])
				other.sel_block_z = floor(pool_entry[3])
				other.sel_norm_x = floor(other.hit.normal.x)
				other.sel_norm_y = floor(other.hit.normal.y)
				other.sel_norm_z = floor(other.hit.normal.z)
				lastdist = other.hit.distance
			}
		}
		delete block_aabb
	}
}

if (block_selected && (mouse_check_button_pressed(mb_left) || gamepad_button_check_pressed(0, gp_shoulderrb)))
{
	obj_world.set_block(sel_block_x, sel_block_y, sel_block_z, 0);
}
if (block_selected && (mouse_check_button_pressed(mb_right) || gamepad_button_check_pressed(0, gp_shoulderlb)))
{
	var xx = sel_block_x + sel_norm_x
	var yy = sel_block_y + sel_norm_y
	var zz = sel_block_z + sel_norm_z
	
	if (obj_world.get_block(xx, yy, zz) == 0 || !global.blocks[obj_world.get_block(xx, yy, zz)].solid)
	{
		obj_world.set_block(xx, yy, zz, hotbar_blocks[selected_block])
	}
}

if (gamepad_button_check_pressed(0, gp_select) || keyboard_check_pressed(ord("R")))
{
	instance_destroy(plyr);
	plyr = instance_create_depth(0, 0, 0, obj_player)
	plyr.pos_x = 64
	plyr.pos_y = 128
	plyr.pos_z = 64
	obj_game.player = plyr
}

if (mouse_wheel_down() || gamepad_button_check_pressed(0, gp_shoulderr))
{
	selected_block = clamp(selected_block + 1, 0, array_length(hotbar_blocks) - 1)
}

if (mouse_wheel_up() || gamepad_button_check_pressed(0, gp_shoulderl))
{
	selected_block = clamp(selected_block - 1, 0, array_length(hotbar_blocks) - 1)
}
	
hit.clear();