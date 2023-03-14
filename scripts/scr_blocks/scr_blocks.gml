global.blocks = []

function block(i, n, s, face_func) constructor
{
	id = i;
	name = n;
	solid = s;
	get_face = face_func;
	global.blocks[i] = self
}

function add_block(bl)
{
	global.blocks[bl.id] = bl
	return bl.id
}

global.block_air = 0
global.block_stone = add_block(new block(1, "Stone", true,
	// get_face
	function(face)
	{
		return tx_stone
	}
));
global.block_grass = add_block(new block(2, "Grass", true,
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
global.block_dirt = add_block(new block(3, "Dirt", true,
	// get_face
	function(face)
	{
		return tx_dirt
	}
));