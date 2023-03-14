function chunk(_x, _y, _z, sizex, sizey, sizez) constructor
{
	self.x = _x
	self.y = _y
	self.z = _z
	self.sizex = sizex
	self.sizey = sizey
	self.sizez = sizez
	
	self.grid = []
	self.vbuffers = []
	
	self.batched_buffer = undefined
	
	self.updates_needed = []
	
	for (var xx = 0; xx < sizex; xx++)
	{
		for (var yy = 0; yy < sizey; yy++)
		{
			for (var zz = 0; zz < sizez; zz++)
			{
				grid[xx][yy][zz] = 0
				vbuffers[xx][yy][zz] = undefined
			}
		}
	}
	
	static get_block_in_grid = function(xx, yy, zz)
	{
		if (xx < sizex && xx >= 0)
		{
			if (yy < sizey && yy >= 0)
			{
				if (zz < sizez && zz >= 0)
				{
					return grid[xx][yy][zz];	
				}
			}
		}
		return -1;
	}
	
	static set_block_in_grid = function(xx, yy, zz, bl)
	{
		if (xx < sizex && xx >= 0)
		{
			if (yy < sizey && yy >= 0)
			{
				if (zz < sizez && zz >= 0)
				{
					grid[xx][yy][zz] = bl;
					queue_update(xx, yy, zz)
				}
			}
		}
	}
	
	static block_occludes_face = function(xx, yy, zz, face)
	{
		switch (face)
		{
			case 0: return get_block_in_grid(xx, yy + 1, zz) > 0;
			case 1: return get_block_in_grid(xx, yy - 1, zz) > 0;
			case 2: return get_block_in_grid(xx, yy, zz + 1) > 0;
			case 3: return get_block_in_grid(xx, yy, zz - 1) > 0;
			case 4: return get_block_in_grid(xx - 1, yy, zz) > 0;
			case 5: return get_block_in_grid(xx + 1, yy, zz) > 0;
		}
		return false
	}
	
	static get_aabbs_in_range = function(fromx, fromy, fromz, tox, toy, toz)
	{
		var aabbs = [];
		for (var xx = fromx; xx < tox; xx++)
		{
			for (var yy = fromy; yy < toy; yy++)
			{
				for (var zz = fromz; zz < toz; zz++)
				{
					if (get_block_in_grid(xx, yy, zz) > 0)
					{
						array_push(aabbs, new c_aabb(new vec3(xx + 0.5, yy + 0.5, zz + 0.5), new vec3(0.5,0.5,0.5)));
					}
				}
			}
		}
		return aabbs
	}
	
	static generate = function(noise)
	{
		for (var xx = 0; xx < sizex; xx++)
		{
			for (var yy = 0; yy < sizey; yy++)
			{
				for (var zz = 0; zz < sizez; zz++)
				{
					var level = noise.get_noise(xx + x * sizex, 0, zz + z * sizez)
					var topY = floor((sizey / 2) + level * 0.2);
					grid[xx][yy][zz] = yy < topY ? global.block_stone : 0 
				}
			}
		}
	}
	
	static update_vbuffer = function(xx, yy, zz)
	{
		var bl = get_block_in_grid(xx, yy, zz)
		if (bl > -1)
		{
			if (!is_undefined(vbuffers[xx][yy][zz]))
			{
				vertex_delete_buffer(vbuffers[xx][yy][zz])
			}
			if (bl > 0)
			{
				var drew_one_face = false
				for (var face = 0; face < 6; face++)
				{
					if (!block_occludes_face(xx, yy, zz, face))
					{
						if (!drew_one_face)
						{
							vbuffers[xx][yy][zz] = r_start_drawing(global.vformat_block)
							drew_one_face = true	
						}
						br_draw_face(vbuffers[xx][yy][zz], global.blocks[bl].get_face(face), xx, yy, zz, face)
					}
				}
				if (drew_one_face)
				{
					r_stop_drawing(vbuffers[xx][yy][zz])
				}
				else
				{
					vbuffers[xx][yy][zz] = undefined
				}
			}
			else
			{
				vbuffers[xx][yy][zz] = undefined;
			}	
		}
	}
	
	static update_vbuffers = function()
	{
		for (var xx = 0; xx < sizex; xx++)
		{
			for (var yy = 0; yy < sizey; yy++)
			{
				for (var zz = 0; zz < sizez; zz++)
				{
					update_vbuffer(xx, yy, zz)
				}
			}
		}
		batch_buffer()
	}
	
	static draw_vbuffers = function()
	{
		vertex_submit(batched_buffer, pr_trianglelist, sprite_get_texture(tx_null_block, 0))
	}
	
	static batch_buffer = function()
	{
		if (batched_buffer != undefined)
		{
			vertex_delete_buffer(batched_buffer)
		}
		batched_buffer = r_start_drawing(global.vformat_block)
		for (var xx = 0; xx < sizex; xx++)
		{
			for (var yy = 0; yy < sizey; yy++)
			{
				for (var zz = 0; zz < sizez; zz++)
				{
					if (vbuffers[xx][yy][zz] != undefined)
					{
						br_add_vertex_buffer(batched_buffer, vbuffers[xx][yy][zz], matrix_build_identity())
					}
				}
			}
		}
		r_stop_drawing(batched_buffer)
		vertex_freeze(batched_buffer)
	}
	
	static handle_updates_needed = function()
	{
		if (array_length(updates_needed) > 0)
		{
			while (array_length(updates_needed) > 0)
			{
				var update = array_pop(updates_needed)
				var xx = update[0]
				var yy = update[1]
				var zz = update[2]
				update_vbuffer(xx, yy, zz)
				array_pop(updates_needed)
			}
			batch_buffer()
		}
	}
	
	static queue_update = function(xx, yy, zz)
	{
		array_push(updates_needed, [ xx, yy, zz ])
	}
}