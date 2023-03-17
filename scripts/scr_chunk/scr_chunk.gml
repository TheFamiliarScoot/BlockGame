function chunk(_x, _y, _z, sizex, sizey, sizez) constructor
{
	self.x = _x
	self.y = _y
	self.z = _z
	self.sizex = sizex
	self.sizey = sizey
	self.sizez = sizez
	
	self.grid_buffer = buffer_create(sizex*sizey*sizez, buffer_fast, 1)
	
	self.batched_buffer = undefined
	
	self.updates_needed = []
	
	self.is_generated = false
	
	static get_block_in_grid = function(xx, yy, zz)
	{
		if ((xx < sizex && xx >= 0) && (yy < sizey && yy >= 0) && (zz < sizez && zz >= 0))
		{
			return buffer_peek(grid_buffer, g_flatten(xx, yy, zz, sizex, sizey, sizez), buffer_u8)
		}
		return -1;
	}
	
	static set_block_in_grid = function(xx, yy, zz, bl)
	{
		if ((xx < sizex && xx >= 0) && (yy < sizey && yy >= 0) && (zz < sizez && zz >= 0))
		{
			buffer_poke(grid_buffer, g_flatten(xx, yy, zz, sizex, sizey, sizez), buffer_u8, bl)
			queue_update(xx, yy, zz)
		}
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
			for (var zz = 0; zz < sizez; zz++)
			{
				// calculate base noise level
				var level = noise.get_noise((xx + x * sizex) / 4, (zz + z * sizez) / 4, 40)
				
				// calculate top block
				var topY = 48 + (level - 20)
				
				// for mountainous areas, add an extra octave
				if (topY > 58)
				{
					topY += noise.get_noise((xx + x * sizex) / 2, (zz + z * sizez) / 2, 8)
				}
				
				var beach = false
				var topblock = global.block_grass.id
				var midblock = global.block_dirt.id
				
				// for beaches, change up the generation a bit
				if (topY < 50)
				{
					topblock = global.block_sand.id
					beach = true
				}
				for (var yy = 0; yy < sizey; yy++)
				{
					var blockid = 0
					
					// fill layer with water
					if (beach && yy < 48)
					{
						blockid = global.block_water.id
					}
					
					// layers of generation
					if (yy == topY)
					{
						blockid = topblock
					}
					else if (yy == 0)
					{
						blockid = global.block_bedrock.id
					}
					else if (yy < 4)
					{
						blockid = (irandom_range(0, 1) * 6) + 1
					}
					else if (yy < topY - 3)
					{
						blockid = global.block_stone.id
					}
					else if (yy < topY)
					{
						blockid = midblock
					}
					
					// set block
					buffer_poke(grid_buffer, g_flatten(xx, yy, zz, sizex, sizey, sizez), buffer_u8, blockid)		
				}
			}
		}
		is_generated = true
	}
	
	static load_compressed_from_buffer = function(buffer, offset, size)
	{
		buffer_copy(buffer, offset, size, grid_buffer, 0)
		buffer_decompress(grid_buffer)
		is_generated = true
	}
	
	static update_vbuffers = function(world)
	{
		if (batched_buffer != undefined) vertex_delete_buffer(batched_buffer)
		batched_buffer = r_start_drawing(global.vformat_block)
		for (var xx = 0; xx < sizex; xx++)
		{
			for (var yy = 0; yy < sizey; yy++)
			{
				for (var zz = 0; zz < sizez; zz++)
				{
					var worldx = xx + x * sizex
					var worldy = yy + y * sizey
					var worldz = zz + z * sizez
					var bl = get_block_in_grid(xx, yy, zz)
					if (bl > 0)
					{
						for (var face = 0; face < 6; face++)
						{
							if (global.blocks[bl].should_render_face(world, worldx, worldy, worldz, face))
							{
								br_draw_face(batched_buffer, global.blocks[bl], xx, yy, zz, face)
							}
						}	
					}
				}
			}
		}
		r_stop_drawing(batched_buffer)
		vertex_freeze(batched_buffer)
	}
	
	static draw_vbuffers = function()
	{
		if (batched_buffer != undefined)
		{
			vertex_submit(batched_buffer, pr_trianglelist, sprite_get_texture(tx_null_block, 0))	
		}
	}
	
	static handle_updates_needed = function(world)
	{
		if (array_length(updates_needed) > 0)
		{
			while (array_length(updates_needed) > 0)
			{
				var update = array_pop(updates_needed)
				var xx = update[0]
				var yy = update[1]
				var zz = update[2]
				array_pop(updates_needed)
			}
			update_vbuffers(world)
		}
	}
	
	static queue_update = function(xx, yy, zz)
	{
		array_push(updates_needed, [ xx, yy, zz ])
	}
	
	static unload = function()
	{
		buffer_delete(grid_buffer)
		vertex_delete_buffer(batched_buffer)
	}
}
	
function g_flatten(xx, yy, zz, sizex, sizey, sizez)
{
	return zz * sizex * sizey + yy * sizex + xx
}