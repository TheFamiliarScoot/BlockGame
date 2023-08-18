var _x = 0;
var _z = 0;
repeat (array_length(chunks))
{
	repeat array_length(chunks[_x])
	{
		r_push_matrix();
		var c = chunks[_x, _z]
		var xx = c.x * c.sizex
		var yy = c.y * c.sizey
		var zz = c.z * c.sizez
		r_translate(xx * global.world_scale, yy * global.world_scale, zz * global.world_scale)
		c.handle_updates_needed(id)
		var i = 0;
		repeat(3)
		{
			gpu_set_alphatestenable(false);
			gpu_set_blendenable(false);
			switch (i)
			{
				case 0:
					break;
				case 1:
					gpu_set_alphatestenable(true);
					break;
				case 2:
					gpu_set_blendenable(true);
					break;

			}
			c.draw_vbuffers(i)
			i++;
		}
		r_pop_matrix()
		_z++;
	}
	_x++;
	_z = 0;
}
gpu_set_blendenable(false)
gpu_set_alphatestenable(true)