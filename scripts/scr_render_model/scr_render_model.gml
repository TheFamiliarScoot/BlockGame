function mdl_cube(sx, sy, sz, tx, ty) constructor
{
	self.sx = sx;
	self.sy = sy;
	self.sz = sz;
	self.tx = tx;
	self.ty = ty;
	
	static draw_top_face = function (buffer, texture, _xx, _yy, _zz)
	{
		var tw = texture_get_width(sprite_get_texture(texture, 0));
		var th = texture_get_height(sprite_get_texture(texture, 0));
		var t = sprite_get_uvs(texture, 0)
		var s = 1
		var uv1 = new vec2(t[0], t[1]).add(new vec2(tx * tw, ty * th)).add(new vec2(sx * tw, 0));
		var uv2 = new vec2(t[2], t[3]).add(new vec2(tx * tw, ty * th)).add(new vec2(sx * tw, 0));
		var _x = _xx * s
		var _y = _yy * s
		var _z = _zz * s
	
		// triangle 1 (tl, br, bl)
	
		vertex_position_3d(buffer, _x, _y + s, _z)
		vertex_normal(buffer, 0, 1, 0)
		vertex_texcoord(buffer, uv1.x, uv1.y)
		vertex_color(buffer, c_white, 1)
	
		vertex_position_3d(buffer, _x + s, _y + s, _z + s)
		vertex_normal(buffer, 0, 1, 0)
		vertex_texcoord(buffer, uv2.x, uv2.y)
		vertex_color(buffer, c_white, 1)

		vertex_position_3d(buffer, _x, _y + s, _z + s)
		vertex_normal(buffer, 0, 1, 0)
		vertex_texcoord(buffer, uv1.x, uv2.y)
		vertex_color(buffer, c_white, 1)
	
		// triangle 2 (tr, br, tl)
	
		vertex_position_3d(buffer, _x + s, _y + s, _z)
		vertex_normal(buffer, 0, 1, 0)
		vertex_texcoord(buffer, uv2.x, uv1.y)
		vertex_color(buffer, c_white, 1)
	
		vertex_position_3d(buffer, _x + s, _y + s, _z + s)
		vertex_normal(buffer, 0, 1, 0)
		vertex_texcoord(buffer, uv2.x, uv2.y)
		vertex_color(buffer, c_white, 1)
	
		vertex_position_3d(buffer, _x, _y + s, _z)
		vertex_normal(buffer, 0, 1, 0)
		vertex_texcoord(buffer, uv1.x, uv1.y)
		vertex_color(buffer, c_white, 1)
	}

	static draw_bottom_face = function(buffer, texture, _xx, _yy, _zz)
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
		vertex_color(buffer, c_white, 1)
	
		vertex_position_3d(buffer, _x + s, _y, _z + s)
		vertex_normal(buffer, 0, -1, 0)
		vertex_texcoord(buffer, uv2.x, uv1.y)
		vertex_color(buffer, c_white, 1)
	
		vertex_position_3d(buffer, _x, _y, _z)
		vertex_normal(buffer, 0, -1, 0)
		vertex_texcoord(buffer, uv1.x, uv2.y)
		vertex_color(buffer, c_white, 1)
	
		// triangle 2
	
		vertex_position_3d(buffer, _x, _y, _z)
		vertex_normal(buffer, 0, -1, 0)
		vertex_texcoord(buffer, uv1.x, uv2.y)
		vertex_color(buffer, c_white, 1)
	
		vertex_position_3d(buffer, _x + s, _y, _z + s)
		vertex_normal(buffer, 0, -1, 0)
		vertex_texcoord(buffer, uv2.x, uv1.y)
		vertex_color(buffer, c_white, 1)
	
		vertex_position_3d(buffer, _x + s, _y, _z)
		vertex_normal(buffer, 0, -1, 0)
		vertex_texcoord(buffer, uv2.x, uv2.y)
		vertex_color(buffer, c_white, 1)
	}

	static draw_north_face = function(buffer, texture, _xx, _yy, _zz)
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
		vertex_color(buffer, c_white, 1)
	
		vertex_position_3d(buffer, _x + s, _y + s, _z + s)
		vertex_normal(buffer, 0, 0, -1)
		vertex_texcoord(buffer, uv2.x, uv1.y)
		vertex_color(buffer, c_white, 1)
	
		vertex_position_3d(buffer, _x, _y, _z + s)
		vertex_normal(buffer, 0, 0, -1)
		vertex_texcoord(buffer, uv1.x, uv2.y)
		vertex_color(buffer, c_white, 1)
	
		// triangle 2
	
		vertex_position_3d(buffer, _x, _y, _z + s)
		vertex_normal(buffer, 0, 0, -1)
		vertex_texcoord(buffer, uv1.x, uv2.y)
		vertex_color(buffer, c_white, 1)
	
		vertex_position_3d(buffer, _x + s, _y + s, _z + s)
		vertex_normal(buffer, 0, 0, -1)
		vertex_texcoord(buffer, uv2.x, uv1.y)
		vertex_color(buffer, c_white, 1)
	
		vertex_position_3d(buffer, _x + s, _y, _z + s)
		vertex_normal(buffer, 0, 0, -1)
		vertex_texcoord(buffer, uv2.x, uv2.y)
		vertex_color(buffer, c_white, 1)
	}

	static draw_south_face = function(buffer, texture, _xx, _yy, _zz)
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
		vertex_color(buffer, c_white, 1)
	
		vertex_position_3d(buffer, _x + s, _y + s, _z)
		vertex_normal(buffer, 0, 0, 1)
		vertex_texcoord(buffer, uv1.x, uv1.y)
		vertex_color(buffer, c_white, 1)
	
		vertex_position_3d(buffer, _x, _y + s, _z)
		vertex_normal(buffer, 0, 0, 1)
		vertex_texcoord(buffer, uv2.x, uv1.y)
		vertex_color(buffer, c_white, 1)
	
		// triangle 2
	
		vertex_position_3d(buffer, _x + s, _y, _z)
		vertex_normal(buffer, 0, 0, 1)
		vertex_texcoord(buffer, uv1.x, uv2.y)
		vertex_color(buffer, c_white, 1)
	
		vertex_position_3d(buffer, _x + s, _y + s, _z)
		vertex_normal(buffer, 0, 0, 1)
		vertex_texcoord(buffer, uv1.x, uv1.y)
		vertex_color(buffer, c_white, 1)
	
		vertex_position_3d(buffer, _x, _y, _z)
		vertex_normal(buffer, 0, 0, 1)
		vertex_texcoord(buffer, uv2.x, uv2.y)
		vertex_color(buffer, c_white, 1)
	}

	static draw_east_face = function(buffer, texture, _xx, _yy, _zz)
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
		vertex_color(buffer, c_white, 1)
	
		vertex_position_3d(buffer, _x, _y + s, _z + s)
		vertex_normal(buffer, 1, 0, 0)
		vertex_texcoord(buffer, uv2.x, uv1.y)
		vertex_color(buffer, c_white, 1)
	
		vertex_position_3d(buffer, _x, _y, _z)
		vertex_normal(buffer, 1, 0, 0)
		vertex_texcoord(buffer, uv1.x, uv2.y)
		vertex_color(buffer, c_white, 1)
	
		// triangle 2
	
		vertex_position_3d(buffer, _x, _y, _z)
		vertex_normal(buffer, 1, 0, 0)
		vertex_texcoord(buffer, uv1.x, uv2.y)
		vertex_color(buffer, c_white, 1)
	
		vertex_position_3d(buffer, _x, _y + s, _z + s)
		vertex_normal(buffer, 1, 0, 0)
		vertex_texcoord(buffer, uv2.x, uv1.y)
		vertex_color(buffer, c_white, 1)
	
		vertex_position_3d(buffer, _x, _y, _z + s)
		vertex_normal(buffer, 1, 0, 0)
		vertex_texcoord(buffer, uv2.x, uv2.y)
		vertex_color(buffer, c_white, 1)
	}

	static draw_west_face = function(buffer, texture, _xx, _yy, _zz)
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
		vertex_color(buffer, c_white, 1)
	
		vertex_position_3d(buffer, _x + s, _y + s, _z + s)
		vertex_normal(buffer, -1, 0, 0)
		vertex_texcoord(buffer, uv1.x, uv1.y)
		vertex_color(buffer, c_white, 1)
	
		vertex_position_3d(buffer, _x + s, _y + s, _z)
		vertex_normal(buffer, -1, 0, 0)
		vertex_texcoord(buffer, uv2.x, uv1.y)
		vertex_color(buffer, c_white, 1)
	
		// triangle 2
	
		vertex_position_3d(buffer, _x + s, _y, _z + s)
		vertex_normal(buffer, -1, 0, 0)
		vertex_texcoord(buffer, uv1.x, uv2.y)
		vertex_color(buffer, c_white, 1)
	
		vertex_position_3d(buffer, _x + s, _y + s, _z + s)
		vertex_normal(buffer, -1, 0, 0)
		vertex_texcoord(buffer, uv1.x, uv1.y)
		vertex_color(buffer, c_white, 1)
	
		vertex_position_3d(buffer, _x + s, _y, _z)
		vertex_normal(buffer, -1, 0, 0)
		vertex_texcoord(buffer, uv2.x, uv2.y)
		vertex_color(buffer, c_white, 1)
	}
}