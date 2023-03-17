// world grid
noise = new noisegen(random_get_seed())

chunks = []

for (var xx = 0; xx < 16; xx++)
{
	for (var zz = 0; zz < 16; zz++)
	{
		var c = new chunk(xx, 0, zz, 16, 128, 16)
		chunks[xx, zz] = c
	}
}

get_chunk = function(xx, zz)
{
	if ((xx >= 0 && xx < array_length(chunks)) && (zz >= 0 && zz < array_length(chunks[xx])))
		return chunks[xx, zz]
	return undefined	
}

queue_update = function(xx, yy, zz)
{
	var c = get_chunk(floor(xx / 16), floor(zz / 16))
	if (c != undefined)
	{
		c.queue_update(xx, yy, zz)
	}
}

get_block = function(xx, yy, zz)
{
	var c = get_chunk(floor(xx / 16), floor(zz / 16))
	if (c != undefined)
	{
		return c.get_block_in_grid(xx % c.sizex, yy, zz % c.sizez)
	}
	return 0
}

set_block = function(xx, yy, zz, bl)
{
	var c = get_chunk(floor(xx / 16), floor(zz / 16))
	if (c != undefined)
	{
		c.set_block_in_grid(xx % c.sizex, yy, zz % c.sizez, bl)
		queue_update(xx, yy + 1, zz)
		queue_update(xx, yy - 1, zz)
		queue_update(xx + 1, yy, zz)
		queue_update(xx - 1, yy, zz)
		queue_update(xx, yy, zz + 1)
		queue_update(xx, yy, zz - 1)
	}
}

block_occludes_face = function(xx, yy, zz, face)
{
	var old_id = get_block(xx, yy, zz)
	switch (face)
	{
		case 0: yy += 1; break;
		case 1: yy -= 1; break;
		case 2: zz += 1; break;
		case 3: zz -= 1; break;
		case 4: xx -= 1; break;
		case 5: xx += 1; break;
	}
	var bl = get_block(xx, yy, zz)
	if (bl > 0)
	{
		return global.blocks[old_id].opaque == global.blocks[bl].opaque
	}
	return false
}

get_aabbs_in_range = function(fromx, fromy, fromz, tox, toy, toz)
{
	var aabbs = [];
	for (var xx = fromx; xx < tox; xx++)
	{
		for (var yy = fromy; yy < toy; yy++)
		{
			for (var zz = fromz; zz < toz; zz++)
			{
				if (get_block(xx, yy, zz) > 0 && global.blocks[get_block(xx, yy, zz)].solid)
				{
					array_push(aabbs, new c_aabb(new vec3(xx + 0.5, yy + 0.5, zz + 0.5), new vec3(0.5,0.5,0.5)));
				}
			}
		}
	}
	return aabbs
}

for (var xx = 0; xx < array_length(chunks); xx++)
{
	for (var zz = 0; zz < array_length(chunks[xx]); zz++)
	{
		if (!chunks[xx][zz].is_generated)
		{
			chunks[xx][zz].generate(noise)
		}
	}
}


for (var xx = 0; xx < array_length(chunks); xx++)
{
	for (var zz = 0; zz < array_length(chunks[xx]); zz++)
	{
		if (chunks[xx][zz].is_generated)
		{
			chunks[xx][zz].update_vbuffers(id)
		}
	}
}