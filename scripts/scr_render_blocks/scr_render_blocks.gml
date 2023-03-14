vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_texcoord();
vertex_format_add_color();
global.vformat_block = vertex_format_end();

vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_color();
global.vformat_outline = vertex_format_end();

function br_draw_face(buffer, texture, _x, _y, _z, face)
{
	switch (face)
	{
		case 0: br_draw_top_face(buffer, texture, _x, _y, _z, c_white); break;
		case 1: br_draw_bottom_face(buffer, texture, _x, _y, _z, make_color_rgb(70, 70, 70)); break;
		case 2: br_draw_north_face(buffer, texture, _x, _y, _z, make_color_rgb(230, 230, 230)); break;
		case 3: br_draw_south_face(buffer, texture, _x, _y, _z, make_color_rgb(200, 200, 200)); break;
		case 4: br_draw_east_face(buffer, texture, _x, _y, _z, make_color_rgb(170, 170, 170)); break;
		case 5: br_draw_west_face(buffer, texture, _x, _y, _z, make_color_rgb(180, 180, 180)); break;
	}
}

function br_draw_top_face(buffer, texture, _xx, _yy, _zz, color)
{
	var t = sprite_get_uvs(texture, 0)
	var s = 1
	var uv1 = new vec2(t[0], t[1])
	var uv2 = new vec2(t[2], t[3])
	var _x = _xx * s
	var _y = _yy * s
	var _z = _zz * s
	
	// triangle 1 (tl, br, bl)
	
	vertex_position_3d(buffer, _x, _y + s, _z)
	vertex_normal(buffer, 0, 1, 0)
	vertex_texcoord(buffer, uv1.x, uv1.y)
	vertex_color(buffer, color, 1)
	
	vertex_position_3d(buffer, _x + s, _y + s, _z + s)
	vertex_normal(buffer, 0, 1, 0)
	vertex_texcoord(buffer, uv2.x, uv2.y)
	vertex_color(buffer, color, 1)

	vertex_position_3d(buffer, _x, _y + s, _z + s)
	vertex_normal(buffer, 0, 1, 0)
	vertex_texcoord(buffer, uv1.x, uv2.y)
	vertex_color(buffer, color, 1)
	
	// triangle 2 (tr, br, tl)
	
	vertex_position_3d(buffer, _x + s, _y + s, _z)
	vertex_normal(buffer, 0, 1, 0)
	vertex_texcoord(buffer, uv2.x, uv1.y)
	vertex_color(buffer, color, 1)
	
	vertex_position_3d(buffer, _x + s, _y + s, _z + s)
	vertex_normal(buffer, 0, 1, 0)
	vertex_texcoord(buffer, uv2.x, uv2.y)
	vertex_color(buffer, color, 1)
	
	vertex_position_3d(buffer, _x, _y + s, _z)
	vertex_normal(buffer, 0, 1, 0)
	vertex_texcoord(buffer, uv1.x, uv1.y)
	vertex_color(buffer, color, 1)
}

function br_draw_bottom_face(buffer, texture, _xx, _yy, _zz, color)
{
	var t = sprite_get_uvs(texture, 0)
	var s = 1
	var uv1 = new vec2(t[0], t[1])
	var uv2 = new vec2(t[2], t[3])
	var _x = _xx * s
	var _y = _yy * s
	var _z = _zz * s
	
	// triangle 1
	
	vertex_position_3d(buffer, _x, _y, _z + s)
	vertex_normal(buffer, 0, -1, 0)
	vertex_texcoord(buffer, uv1.x, uv1.y)
	vertex_color(buffer, color, 1)
	
	vertex_position_3d(buffer, _x + s, _y, _z + s)
	vertex_normal(buffer, 0, -1, 0)
	vertex_texcoord(buffer, uv2.x, uv1.y)
	vertex_color(buffer, color, 1)
	
	vertex_position_3d(buffer, _x, _y, _z)
	vertex_normal(buffer, 0, -1, 0)
	vertex_texcoord(buffer, uv1.x, uv2.y)
	vertex_color(buffer, color, 1)
	
	// triangle 2
	
	vertex_position_3d(buffer, _x, _y, _z)
	vertex_normal(buffer, 0, -1, 0)
	vertex_texcoord(buffer, uv1.x, uv2.y)
	vertex_color(buffer, color, 1)
	
	vertex_position_3d(buffer, _x + s, _y, _z + s)
	vertex_normal(buffer, 0, -1, 0)
	vertex_texcoord(buffer, uv2.x, uv1.y)
	vertex_color(buffer, color, 1)
	
	vertex_position_3d(buffer, _x + s, _y, _z)
	vertex_normal(buffer, 0, -1, 0)
	vertex_texcoord(buffer, uv2.x, uv2.y)
	vertex_color(buffer, color, 1)
}

function br_draw_north_face(buffer, texture, _xx, _yy, _zz, color)
{
	var t = sprite_get_uvs(texture, 0)
	var s = 1
	var uv1 = new vec2(t[0], t[1])
	var uv2 = new vec2(t[2], t[3])
	var _x = _xx * s
	var _y = _yy * s
	var _z = _zz * s
	
	// triangle 1
	
	vertex_position_3d(buffer, _x, _y + s, _z + s)
	vertex_normal(buffer, 0, 0, -1)
	vertex_texcoord(buffer, uv1.x, uv1.y)
	vertex_color(buffer, color, 1)
	
	vertex_position_3d(buffer, _x + s, _y + s, _z + s)
	vertex_normal(buffer, 0, 0, -1)
	vertex_texcoord(buffer, uv2.x, uv1.y)
	vertex_color(buffer, color, 1)
	
	vertex_position_3d(buffer, _x, _y, _z + s)
	vertex_normal(buffer, 0, 0, -1)
	vertex_texcoord(buffer, uv1.x, uv2.y)
	vertex_color(buffer, color, 1)
	
	// triangle 2
	
	vertex_position_3d(buffer, _x, _y, _z + s)
	vertex_normal(buffer, 0, 0, -1)
	vertex_texcoord(buffer, uv1.x, uv2.y)
	vertex_color(buffer, color, 1)
	
	vertex_position_3d(buffer, _x + s, _y + s, _z + s)
	vertex_normal(buffer, 0, 0, -1)
	vertex_texcoord(buffer, uv2.x, uv1.y)
	vertex_color(buffer, color, 1)
	
	vertex_position_3d(buffer, _x + s, _y, _z + s)
	vertex_normal(buffer, 0, 0, -1)
	vertex_texcoord(buffer, uv2.x, uv2.y)
	vertex_color(buffer, color, 1)
}

function br_draw_south_face(buffer, texture, _xx, _yy, _zz, color)
{
	var t = sprite_get_uvs(texture, 0)
	var s = 1
	var uv1 = new vec2(t[0], t[1])
	var uv2 = new vec2(t[2], t[3])
	var _x = _xx * s
	var _y = _yy * s
	var _z = _zz * s
	
	// triangle 1
	
	vertex_position_3d(buffer, _x, _y, _z)
	vertex_normal(buffer, 0, 0, 1)
	vertex_texcoord(buffer, uv2.x, uv2.y)
	vertex_color(buffer, color, 1)
	
	vertex_position_3d(buffer, _x + s, _y + s, _z)
	vertex_normal(buffer, 0, 0, 1)
	vertex_texcoord(buffer, uv1.x, uv1.y)
	vertex_color(buffer, color, 1)
	
	vertex_position_3d(buffer, _x, _y + s, _z)
	vertex_normal(buffer, 0, 0, 1)
	vertex_texcoord(buffer, uv2.x, uv1.y)
	vertex_color(buffer, color, 1)
	
	// triangle 2
	
	vertex_position_3d(buffer, _x + s, _y, _z)
	vertex_normal(buffer, 0, 0, 1)
	vertex_texcoord(buffer, uv1.x, uv2.y)
	vertex_color(buffer, color, 1)
	
	vertex_position_3d(buffer, _x + s, _y + s, _z)
	vertex_normal(buffer, 0, 0, 1)
	vertex_texcoord(buffer, uv1.x, uv1.y)
	vertex_color(buffer, color, 1)
	
	vertex_position_3d(buffer, _x, _y, _z)
	vertex_normal(buffer, 0, 0, 1)
	vertex_texcoord(buffer, uv2.x, uv2.y)
	vertex_color(buffer, color, 1)
}

function br_draw_east_face(buffer, texture, _xx, _yy, _zz, color)
{
	var t = sprite_get_uvs(texture, 0)
	var s = 1
	var uv1 = new vec2(t[0], t[1])
	var uv2 = new vec2(t[2], t[3])
	var _x = _xx * s
	var _y = _yy * s
	var _z = _zz * s
	
	// triangle 1
	
	vertex_position_3d(buffer, _x, _y + s, _z)
	vertex_normal(buffer, 1, 0, 0)
	vertex_texcoord(buffer, uv1.x, uv1.y)
	vertex_color(buffer, color, 1)
	
	vertex_position_3d(buffer, _x, _y + s, _z + s)
	vertex_normal(buffer, 1, 0, 0)
	vertex_texcoord(buffer, uv2.x, uv1.y)
	vertex_color(buffer, color, 1)
	
	vertex_position_3d(buffer, _x, _y, _z)
	vertex_normal(buffer, 1, 0, 0)
	vertex_texcoord(buffer, uv1.x, uv2.y)
	vertex_color(buffer, color, 1)
	
	// triangle 2
	
	vertex_position_3d(buffer, _x, _y, _z)
	vertex_normal(buffer, 1, 0, 0)
	vertex_texcoord(buffer, uv1.x, uv2.y)
	vertex_color(buffer, color, 1)
	
	vertex_position_3d(buffer, _x, _y + s, _z + s)
	vertex_normal(buffer, 1, 0, 0)
	vertex_texcoord(buffer, uv2.x, uv1.y)
	vertex_color(buffer, color, 1)
	
	vertex_position_3d(buffer, _x, _y, _z + s)
	vertex_normal(buffer, 1, 0, 0)
	vertex_texcoord(buffer, uv2.x, uv2.y)
	vertex_color(buffer, color, 1)
}

function br_draw_west_face(buffer, texture, _xx, _yy, _zz, color)
{
	var t = sprite_get_uvs(texture, 0)
	var s = 1
	var uv1 = new vec2(t[0], t[1])
	var uv2 = new vec2(t[2], t[3])
	var _x = _xx * s
	var _y = _yy * s
	var _z = _zz * s
	
	// triangle 1
	
	vertex_position_3d(buffer, _x + s, _y, _z)
	vertex_normal(buffer, -1, 0, 0)
	vertex_texcoord(buffer, uv2.x, uv2.y)
	vertex_color(buffer, color, 1)
	
	vertex_position_3d(buffer, _x + s, _y + s, _z + s)
	vertex_normal(buffer, -1, 0, 0)
	vertex_texcoord(buffer, uv1.x, uv1.y)
	vertex_color(buffer, color, 1)
	
	vertex_position_3d(buffer, _x + s, _y + s, _z)
	vertex_normal(buffer, -1, 0, 0)
	vertex_texcoord(buffer, uv2.x, uv1.y)
	vertex_color(buffer, color, 1)
	
	// triangle 2
	
	vertex_position_3d(buffer, _x + s, _y, _z + s)
	vertex_normal(buffer, -1, 0, 0)
	vertex_texcoord(buffer, uv1.x, uv2.y)
	vertex_color(buffer, color, 1)
	
	vertex_position_3d(buffer, _x + s, _y + s, _z + s)
	vertex_normal(buffer, -1, 0, 0)
	vertex_texcoord(buffer, uv1.x, uv1.y)
	vertex_color(buffer, color, 1)
	
	vertex_position_3d(buffer, _x + s, _y, _z)
	vertex_normal(buffer, -1, 0, 0)
	vertex_texcoord(buffer, uv2.x, uv2.y)
	vertex_color(buffer, color, 1)
}

function br_draw_block_outline(buffer, xx, yy, zz)
{
	var s = 1;
	var _x = xx * s;
	var _y = yy * s;
	var _z = zz * s;
	
	// bottom outline
	
	br_add_point_with_color(buffer, _x, _y, _z, c_black, 0.5);
	br_add_point_with_color(buffer, _x + s, _y, _z, c_black, 0.5);
	
	br_add_point_with_color(buffer, _x + s, _y, _z, c_black, 0.5);
	br_add_point_with_color(buffer, _x + s, _y, _z + s, c_black, 0.5);
	
	br_add_point_with_color(buffer, _x + s, _y, _z + s, c_black, 0.5);
	br_add_point_with_color(buffer, _x, _y, _z + s, c_black, 0.5);
	
	br_add_point_with_color(buffer, _x, _y, _z + s, c_black, 0.5);
	br_add_point_with_color(buffer, _x, _y, _z, c_black, 0.5);
	
	// top outline
	
	br_add_point_with_color(buffer, _x, _y + s, _z, c_black, 0.5);
	br_add_point_with_color(buffer, _x + s, _y + s, _z, c_black, 0.5);
	
	br_add_point_with_color(buffer, _x + s, _y + s, _z, c_black, 0.5);
	br_add_point_with_color(buffer, _x + s, _y + s, _z + s, c_black, 0.5);
	
	br_add_point_with_color(buffer, _x + s, _y + s, _z + s, c_black, 0.5);
	br_add_point_with_color(buffer, _x, _y + s, _z + s, c_black, 0.5);
	
	br_add_point_with_color(buffer, _x, _y + s, _z + s, c_black, 0.5);
	br_add_point_with_color(buffer, _x, _y + s, _z, c_black, 0.5);
	
	// sides
	
	br_add_point_with_color(buffer, _x, _y, _z, c_black, 0.5);
	br_add_point_with_color(buffer, _x, _y + s, _z, c_black, 0.5);
	
	br_add_point_with_color(buffer, _x + s, _y, _z, c_black, 0.5);
	br_add_point_with_color(buffer, _x + s, _y + s, _z, c_black, 0.5);
	
	br_add_point_with_color(buffer, _x + s, _y, _z + s, c_black, 0.5);
	br_add_point_with_color(buffer, _x + s, _y + s, _z + s, c_black, 0.5);
	
	br_add_point_with_color(buffer, _x, _y, _z + s, c_black, 0.5);
	br_add_point_with_color(buffer, _x, _y + s, _z + s, c_black, 0.5);
}

function br_add_point_with_color(buffer, _x, _y, _z, color, alpha)
{
	vertex_position_3d(buffer, _x, _y, _z);
	vertex_color(buffer,color,alpha);
}

function br_add_vertex_buffer(destination, source, matrix)
{
    var nmatrix = [
        matrix[00], matrix[01], matrix[02], matrix[03],
        matrix[04], matrix[05], matrix[06], matrix[07],
        matrix[08], matrix[09], matrix[10], matrix[11],
                 0,          0,          0, matrix[15]
    ];
    var data = buffer_create_from_vertex_buffer(source, buffer_fixed, 1);
    for (var i = 0; i < buffer_get_size(data); i += 36)
	{
        var xx = buffer_peek(data, i + 00, buffer_f32);
        var yy = buffer_peek(data, i + 04, buffer_f32);
        var zz = buffer_peek(data, i + 08, buffer_f32);
        var nx = buffer_peek(data, i + 12, buffer_f32);
        var ny = buffer_peek(data, i + 16, buffer_f32);
        var nz = buffer_peek(data, i + 20, buffer_f32);
        var xt = buffer_peek(data, i + 24, buffer_f32);
        var yt = buffer_peek(data, i + 28, buffer_f32);
        var cc = buffer_peek(data, i + 32, buffer_u32);
        
        var pos = matrix_transform_vertex(matrix, xx, yy, zz);
        var norm = matrix_transform_vertex(nmatrix, nx, ny, nz);
        var mag = point_distance_3d(0, 0, 0, norm[0], norm[1], norm[2]);
        norm[0] /= mag;
        norm[1] /= mag;
        norm[2] /= mag;
		
		vertex_position_3d(destination, pos[0], pos[1], pos[2])
		vertex_normal(destination, norm[0], norm[1], norm[2])
		vertex_texcoord(destination, xt, yt)
		vertex_color(destination, cc & 0xffffff, (cc >> 24) / 255)
    }
	buffer_delete(data)
}