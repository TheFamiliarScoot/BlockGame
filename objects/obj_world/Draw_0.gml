for (var _x = 0; _x < array_length(chunks); _x++)
{
	for (var _z = 0; _z < array_length(chunks[_x]); _z++)
	{
		r_push_matrix();
		var c = chunks[_x, _z]
		var xx = c.x * c.sizex
		var yy = c.y * c.sizey
		var zz = c.z * c.sizez
		r_translate(xx * global.world_scale, yy * global.world_scale, zz * global.world_scale)
		c.handle_updates_needed()
		c.draw_vbuffers()
		r_pop_matrix()	
	}
}