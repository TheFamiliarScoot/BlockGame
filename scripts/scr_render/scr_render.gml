function r_start_drawing(format)
{
	var buffer = vertex_create_buffer();
	vertex_begin(buffer, format);
	return buffer
}

function r_stop_drawing(buffer)
{
	vertex_end(buffer);
}

function r_apply_matrix()
{
	matrix_set(matrix_world, matrix_stack_top());
}

function r_push_matrix()
{
	matrix_stack_push(matrix_build_identity());
	r_apply_matrix();
}

function r_pop_matrix()
{
	matrix_stack_pop();
	r_apply_matrix();
}

function r_translate(xx, yy, zz)
{
	var m = matrix_build(xx, yy, zz, 0, 0, 0, 1, 1, 1);
	matrix_stack_set(matrix_multiply(matrix_stack_top(), m));
	r_apply_matrix();
}

function r_rotate(xx, yy, zz)
{
	var m = matrix_build(0, 0, 0, xx, yy, zz, 1, 1, 1);
	matrix_stack_set(matrix_multiply(matrix_stack_top(), m));
	r_apply_matrix();
}

function r_scale(xx, yy, zz)
{
	var m = matrix_build(0, 0, 0, 0, 0, 0, xx, yy, zz);
	matrix_stack_set(matrix_multiply(matrix_stack_top(), m));
	r_apply_matrix();
}

function r_render_skybox(buffer, color)
{
	var t = sprite_get_uvs(tx_skybox_top, 0)
	var s = 0.5
	var uv1 = new vec2(t[2], t[1])
	var uv2 = new vec2(t[0], t[3])
	var _x = 0
	var _y = 0
	var _z = 0

	// triangle 1 (tl, br, bl)

	vertex_position_3d(buffer, _x - s, _y + s, _z - s)
	vertex_normal(buffer, 0, 1, 0)
	vertex_texcoord(buffer, uv1.x, uv1.y)
	vertex_color(buffer, color, 1)

	vertex_position_3d(buffer, _x + s, _y + s, _z + s)
	vertex_normal(buffer, 0, 1, 0)
	vertex_texcoord(buffer, uv2.x, uv2.y)
	vertex_color(buffer, color, 1)

	vertex_position_3d(buffer, _x - s, _y + s, _z + s)
	vertex_normal(buffer, 0, 1, 0)
	vertex_texcoord(buffer, uv1.x, uv2.y)
	vertex_color(buffer, color, 1)

	// triangle 2 (tr, br, tl)

	vertex_position_3d(buffer, _x + s, _y + s, _z - s)
	vertex_normal(buffer, 0, 1, 0)
	vertex_texcoord(buffer, uv2.x, uv1.y)
	vertex_color(buffer, color, 1)

	vertex_position_3d(buffer, _x + s, _y + s, _z + s)
	vertex_normal(buffer, 0, 1, 0)
	vertex_texcoord(buffer, uv2.x, uv2.y)
	vertex_color(buffer, color, 1)

	vertex_position_3d(buffer, _x - s, _y + s, _z - s)
	vertex_normal(buffer, 0, 1, 0)
	vertex_texcoord(buffer, uv1.x, uv1.y)
	vertex_color(buffer, color, 1)

	t = sprite_get_uvs(tx_skybox_bottom, 0)
	uv1 = new vec2(t[2], t[1])
	uv2 = new vec2(t[0], t[3])

	// triangle 1

	vertex_position_3d(buffer, _x - s, _y - s, _z + s)
	vertex_normal(buffer, 0, -1, 0)
	vertex_texcoord(buffer, uv1.x, uv1.y)
	vertex_color(buffer, color, 1)

	vertex_position_3d(buffer, _x + s, _y - s, _z + s)
	vertex_normal(buffer, 0, -1, 0)
	vertex_texcoord(buffer, uv2.x, uv1.y)
	vertex_color(buffer, color, 1)

	vertex_position_3d(buffer, _x - s, _y - s, _z - s)
	vertex_normal(buffer, 0, -1, 0)
	vertex_texcoord(buffer, uv1.x, uv2.y)
	vertex_color(buffer, color, 1)

	// triangle 2

	vertex_position_3d(buffer, _x - s, _y - s, _z - s)
	vertex_normal(buffer, 0, -1, 0)
	vertex_texcoord(buffer, uv1.x, uv2.y)
	vertex_color(buffer, color, 1)

	vertex_position_3d(buffer, _x + s, _y - s, _z + s)
	vertex_normal(buffer, 0, -1, 0)
	vertex_texcoord(buffer, uv2.x, uv1.y)
	vertex_color(buffer, color, 1)

	vertex_position_3d(buffer, _x + s, _y - s, _z - s)
	vertex_normal(buffer, 0, -1, 0)
	vertex_texcoord(buffer, uv2.x, uv2.y)
	vertex_color(buffer, color, 1)

	t = sprite_get_uvs(tx_skybox_north, 0)
	uv1 = new vec2(t[2], t[1])
	uv2 = new vec2(t[0], t[3])

	// triangle 1

	vertex_position_3d(buffer, _x - s, _y + s, _z + s)
	vertex_normal(buffer, 0, 0, -1)
	vertex_texcoord(buffer, uv1.x, uv1.y)
	vertex_color(buffer, color, 1)

	vertex_position_3d(buffer, _x + s, _y + s, _z + s)
	vertex_normal(buffer, 0, 0, -1)
	vertex_texcoord(buffer, uv2.x, uv1.y)
	vertex_color(buffer, color, 1)

	vertex_position_3d(buffer, _x - s, _y - s, _z + s)
	vertex_normal(buffer, 0, 0, -1)
	vertex_texcoord(buffer, uv1.x, uv2.y)
	vertex_color(buffer, color, 1)

	// triangle 2

	vertex_position_3d(buffer, _x - s, _y - s, _z + s)
	vertex_normal(buffer, 0, 0, -1)
	vertex_texcoord(buffer, uv1.x, uv2.y)
	vertex_color(buffer, color, 1)

	vertex_position_3d(buffer, _x + s, _y + s, _z + s)
	vertex_normal(buffer, 0, 0, -1)
	vertex_texcoord(buffer, uv2.x, uv1.y)
	vertex_color(buffer, color, 1)

	vertex_position_3d(buffer, _x + s, _y - s, _z + s)
	vertex_normal(buffer, 0, 0, -1)
	vertex_texcoord(buffer, uv2.x, uv2.y)
	vertex_color(buffer, color, 1)

	t = sprite_get_uvs(tx_skybox_south, 0)
	uv1 = new vec2(t[2], t[1])
	uv2 = new vec2(t[0], t[3])

	// triangle 1

	vertex_position_3d(buffer, _x - s, _y - s, _z - s)
	vertex_normal(buffer, 0, 0, 1)
	vertex_texcoord(buffer, uv2.x, uv2.y)
	vertex_color(buffer, color, 1)

	vertex_position_3d(buffer, _x + s, _y + s, _z - s)
	vertex_normal(buffer, 0, 0, 1)
	vertex_texcoord(buffer, uv1.x, uv1.y)
	vertex_color(buffer, color, 1)

	vertex_position_3d(buffer, _x - s, _y + s, _z - s)
	vertex_normal(buffer, 0, 0, 1)
	vertex_texcoord(buffer, uv2.x, uv1.y)
	vertex_color(buffer, color, 1)

	// triangle 2

	vertex_position_3d(buffer, _x + s, _y - s, _z - s)
	vertex_normal(buffer, 0, 0, 1)
	vertex_texcoord(buffer, uv1.x, uv2.y)
	vertex_color(buffer, color, 1)

	vertex_position_3d(buffer, _x + s, _y + s, _z - s)
	vertex_normal(buffer, 0, 0, 1)
	vertex_texcoord(buffer, uv1.x, uv1.y)
	vertex_color(buffer, color, 1)

	vertex_position_3d(buffer, _x - s, _y - s, _z - s)
	vertex_normal(buffer, 0, 0, 1)
	vertex_texcoord(buffer, uv2.x, uv2.y)
	vertex_color(buffer, color, 1)

	t = sprite_get_uvs(tx_skybox_east, 0)
	uv1 = new vec2(t[2], t[1])
	uv2 = new vec2(t[0], t[3])

	// triangle 1

	vertex_position_3d(buffer, _x - s, _y + s, _z - s)
	vertex_normal(buffer, 1, 0, 0)
	vertex_texcoord(buffer, uv1.x, uv1.y)
	vertex_color(buffer, color, 1)

	vertex_position_3d(buffer, _x - s, _y + s, _z + s)
	vertex_normal(buffer, 1, 0, 0)
	vertex_texcoord(buffer, uv2.x, uv1.y)
	vertex_color(buffer, color, 1)

	vertex_position_3d(buffer, _x - s, _y - s, _z - s)
	vertex_normal(buffer, 1, 0, 0)
	vertex_texcoord(buffer, uv1.x, uv2.y)
	vertex_color(buffer, color, 1)

	// triangle 2

	vertex_position_3d(buffer, _x - s, _y - s, _z - s)
	vertex_normal(buffer, 1, 0, 0)
	vertex_texcoord(buffer, uv1.x, uv2.y)
	vertex_color(buffer, color, 1)

	vertex_position_3d(buffer, _x - s, _y + s, _z + s)
	vertex_normal(buffer, 1, 0, 0)
	vertex_texcoord(buffer, uv2.x, uv1.y)
	vertex_color(buffer, color, 1)

	vertex_position_3d(buffer, _x - s, _y - s, _z + s)
	vertex_normal(buffer, 1, 0, 0)
	vertex_texcoord(buffer, uv2.x, uv2.y)
	vertex_color(buffer, color, 1)

	t = sprite_get_uvs(tx_skybox_west, 0)
	uv1 = new vec2(t[2], t[1])
	uv2 = new vec2(t[0], t[3])

	// triangle 1

	vertex_position_3d(buffer, _x + s, _y - s, _z - s)
	vertex_normal(buffer, -1, 0, 0)
	vertex_texcoord(buffer, uv2.x, uv2.y)
	vertex_color(buffer, color, 1)

	vertex_position_3d(buffer, _x + s, _y + s, _z + s)
	vertex_normal(buffer, -1, 0, 0)
	vertex_texcoord(buffer, uv1.x, uv1.y)
	vertex_color(buffer, color, 1)

	vertex_position_3d(buffer, _x + s, _y + s, _z - s)
	vertex_normal(buffer, -1, 0, 0)
	vertex_texcoord(buffer, uv2.x, uv1.y)
	vertex_color(buffer, color, 1)

	// triangle 2

	vertex_position_3d(buffer, _x + s, _y - s, _z + s)
	vertex_normal(buffer, -1, 0, 0)
	vertex_texcoord(buffer, uv1.x, uv2.y)
	vertex_color(buffer, color, 1)

	vertex_position_3d(buffer, _x + s, _y + s, _z + s)
	vertex_normal(buffer, -1, 0, 0)
	vertex_texcoord(buffer, uv1.x, uv1.y)
	vertex_color(buffer, color, 1)

	vertex_position_3d(buffer, _x + s, _y - s, _z - s)
	vertex_normal(buffer, -1, 0, 0)
	vertex_texcoord(buffer, uv2.x, uv2.y)
	vertex_color(buffer, color, 1)	
}