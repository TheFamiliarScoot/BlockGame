global.blocks = []

function block(i, n, s, o, face_func) constructor
{
	id = i;
	name = n;
	solid = s;
	opaque = o;
	get_face = face_func;
	should_render_face = function(world, xx, yy, zz, face)
	{
		return !world.block_occludes_face(xx, yy, zz, face)
	}
	global.blocks[i] = self
}

function add_block(bl)
{
	global.blocks[bl.id] = bl
	return bl
}

global.block_air = undefined
global.block_stone = add_block(new block(1, "Stone", true, true,
	// get_face
	function(face)
	{
		return tx_stone
	}
));
global.block_grass = add_block(new block(2, "Grass", true, true,
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
global.block_dirt = add_block(new block(3, "Dirt", true, true,
	// get_face
	function(face)
	{
		return tx_dirt
	}
));
global.block_cobblestone = add_block(new block(4, "Cobblestone", true, true,
	// get_face
	function(face)
	{
		return tx_cobblestone
	}
));
global.block_planks = add_block(new block(5, "Planks", true, true,
	// get_face
	function(face)
	{
		return tx_planks
	}
));

// RESERVED FOR SAPLING

global.block_bedrock = add_block(new block(7, "Bedrock", true, true,
	// get_face
	function(face)
	{
		return tx_bedrock
	}
));

global.block_water = add_block(new block(8, "Water", false, false,
	// get_face
	function(face)
	{
		return tx_null_block
	}
));

// RESERVED FOR OTHER FLUIDS

global.block_sand = add_block(new block(12, "Sand", true, true,
	// get_face
	function(face)
	{
		return tx_sand
	}
));