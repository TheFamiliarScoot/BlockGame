global.blocks = []

function block(i, n, s, o, sel, face_func) constructor
{
	id = i;
	name = n;
	solid = s;
	opaque = o;
	get_face = face_func;
	selectable = sel;
	should_render_face = function(world, xx, yy, zz, face)
	{
		return !world.block_occludes_face(xx, yy, zz, face)
	}
	pos_min = new vec3(0, 0, 0)
	pos_max = new vec3(1, 1, 1)
	render_layer = 0
	render_type = 0
	get_aabb = function(xx, yy, zz)
	{
		var center_position = pos_min.add(pos_max).divd(2);
		var half_size = pos_max.sub(pos_min).divd(2)._abs();
		return new c_aabb(center_position.add(new vec3(xx, yy, zz)), half_size)
	}
	global.blocks[i] = self
}

function add_block(bl)
{
	global.blocks[bl.id] = bl
	return bl
}

global.block_air = undefined
global.block_stone = add_block(new block(1, "Stone", true, true, true,
	// get_face
	function(face)
	{
		return tx_stone
	}
));
global.block_grass = add_block(new block(2, "Grass", true, true, true,
	// get_face
	function(face)
	{
		if (face > 1)
			return tx_grass_side
		else if (face == 1)
			return tx_dirt
		else
			return tx_grass_top
	}
));
global.block_dirt = add_block(new block(3, "Dirt", true, true, true,
	// get_face
	function(face)
	{
		return tx_dirt
	}
));
global.block_cobblestone = add_block(new block(4, "Cobblestone", true, true, true,
	// get_face
	function(face)
	{
		return tx_cobblestone
	}
));
global.block_planks = add_block(new block(5, "Planks", true, true, true,
	// get_face
	function(face)
	{
		return tx_planks
	}
));
global.block_sapling = add_block(new block(6, "Sapling", false, false, true,
	// get_face
	function(face)
	{
		return tx_grass_top
	}
));
global.block_sapling.pos_min = new vec3(3/16, 0, 3/16)
global.block_sapling.pos_max = new vec3(13/16, 13/16, 13/16)
global.block_sapling.render_type = 1
global.block_sapling.render_layer = 1

global.block_bedrock = add_block(new block(7, "Bedrock", true, true, true,
	// get_face
	function(face)
	{
		return tx_bedrock
	}
));

global.block_water = add_block(new block(8, "Water", false, false, false,
	// get_face
	function(face)
	{
		return tx_water
	}
));
global.block_water.pos_max.y = 15/16
global.block_water.pos_min.y = -1/16
global.block_water.render_layer = 2

// RESERVED FOR OTHER FLUIDS

global.block_sand = add_block(new block(12, "Sand", true, true, true,
	// get_face
	function(face)
	{
		return tx_sand
	}
));