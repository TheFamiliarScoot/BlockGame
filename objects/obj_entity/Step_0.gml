var _dt = delta_time / 1000000;

on_ground = false

box.center.x = pos_x;
box.center.y = pos_y + box.ext.y;
box.center.z = pos_z;
var edge_offset = ceil(box_radius)
var range = 1
col_pool = obj_world.get_aabbs_in_range(
	floor(pos_x) - edge_offset - range,
	floor(pos_y) - edge_offset - range,
	floor(pos_z) - edge_offset - range,
	floor(pos_x) + edge_offset + range,
	floor(pos_y) + ceil(box_height) + edge_offset + range,
	floor(pos_z) + edge_offset + range
);

var dx = vel_x * _dt;
var dy = vel_y * _dt;
var dz = vel_z * _dt;

//show_debug_message("aabbs: " + string(array_length(aabbs)))

box.center.y = pos_y + box.ext.y + dy;
var i = 0;
repeat (array_length(col_pool))
{
	var aabb = col_pool[i]
	if (aabb.center.dist(box.center) < 4)
	{
		if (box.check_aabb(aabb))
		{
			//dy = dy > 0 ? box.get_max().y - aabbs[i].get_min().y : (aabbs[i].get_max().y - box.get_min().y) / 64;
			dy = 0;
			box.center.y = pos_y + box.ext.y;
			vel_y = 0;
			on_ground = true
			break;
		}		
	}
	i++;
}
pos_y += dy;

box.center.y += 0.01;

box.center.x = pos_x + dx;
i = 0;
repeat (array_length(col_pool))
{
	var aabb = col_pool[i]
	if (aabb.center.dist(box.center) < 2)
	{
		if (box.check_aabb(aabb))
		{
			//dx = dx > 0 ? box.get_max().x - aabbs[i].get_min().x : aabbs[i].get_max().x - box.get_min().x;
			dx = 0;
			box.center.x = pos_x;
			vel_x = 0;
			break;
		}
	}
	i++;
}
pos_x += dx;

box.center.z = pos_z + dz;
i = 0;
repeat (array_length(col_pool))
{
	var aabb = col_pool[i]
	if (aabb.center.dist(box.center) < 2)
	{
		if (box.check_aabb(aabb))
		{
			//dz = dz > 0 ? box.get_max().z - aabbs[i].get_min().z : aabbs[i].get_max().z - box.get_min().z;
			dz = 0;
			box.center.z = pos_z;
			vel_z = 0;
			break;
		}
	}
	i++;
}
pos_z += dz;

box.center.y -= 0.01;

vel_x /= frict
vel_z /= frict

vel_y -= 0.3;

// dereference collision pool (prevents a memory leak)
i = 0;
repeat (array_length(col_pool))
{
	delete col_pool[i]
	i++;
}

block_pool = obj_world.get_selectable_blocks_in_range(
	floor(pos_x) - 4,
	floor(pos_y) - 4,
	floor(pos_z) - 4,
	floor(pos_x) + 4,
	floor(pos_y) + 4,
	floor(pos_z) + 4
);