function vec2(_x, _y) constructor
{
	x = _x;
	y = _y;
	
	static add = function(vec)
	{
		if (is_numeric(vec))
		{
			return new vec2(self.x + vec, self.y + vec);	
		}
		return new vec2(self.x + vec.x, self.y + vec.y);
	};
	
	static sub = function(vec)
	{
		if (is_numeric(vec))
		{
			return new vec2(self.x - vec, self.y - vec);	
		}
		return new vec2(self.x - vec.x, self.y - vec.y);
	};
	
	static mul = function(vec)
	{
		if (is_numeric(vec))
		{
			return new vec2(self.x * vec, self.y * vec);	
		}
		return new vec2(self.x * vec.x, self.y * vec.y);
	};
	
	static divd = function(vec)
	{
		if (is_numeric(vec))
		{
			return new vec2(self.x / vec, self.y / vec);	
		}
		return new vec2(self.x / vec.x, self.y / vec.y);
	};
	
	static mag = function(vec)
	{
		return point_distance(0, 0, self.x, self.y);	
	};
	
	static dist = function(vec)
	{
		return point_distance(vec.x, vec.y, self.x, self.y);	
	};
	
	static dot = function(vec)
	{
		return dot_product(vec.x, vec.y, self.x, self.y);	
	};
	
	static cross = function(vec)
	{
		return new vec2(self.y * vec.x - vec.y * self.x, self.x * vec.y - vec.x * self.y);
	};
	
	static eq = function(vec)
	{
		return (self.x == vec.x) && (self.y == vec.y);	
	};
	
	static gt = function(vec)
	{
		return (self.x > vec.x) && (self.y > vec.y);	
	};
	
	static lt = function(vec)
	{
		return (self.x < vec.x) && (self.y < vec.y);	
	};
	
	static gte = function(vec)
	{
		return (self.x >= vec.x) && (self.y >= vec.y);	
	};
	
	static lte = function(vec)
	{
		return (self.x <= vec.x) && (self.y <= vec.y);	
	};
	
	static norm = function()
	{
		var m = self.mag();
		return new vec2(self.x / m.x, self.y / m.y);
	};
	
	static _abs = function()
	{
		return new vec2(abs(self.x), abs(self.y))
	}
}

function vec3(_x, _y, _z) constructor
{
	x = _x;
	y = _y;
	z = _z;
		
	static add = function(vec)
	{
		if (is_numeric(vec))
		{
			return new vec3(self.x + vec, self.y + vec, self.z + vec);	
		}
		return new vec3(self.x + vec.x, self.y + vec.y, self.z + vec.z);
	};
	
	static sub = function(vec)
	{
		if (is_numeric(vec))
		{
			return new vec3(self.x - vec, self.y - vec, self.z - vec);	
		}
		return new vec3(self.x - vec.x, self.y - vec.y, self.z - vec.z);
	};
	
	static mul = function(vec)
	{
		if (is_numeric(vec))
		{
			return new vec3(self.x * vec, self.y * vec, self.z * vec);	
		}
		return new vec3(self.x * vec.x, self.y * vec.y, self.z * vec.z);
	};
	
	static divd = function(vec)
	{
		if (is_numeric(vec))
		{
			return new vec3(self.x / vec, self.y / vec, self.z / vec);	
		}
		return new vec3(self.x / vec.x, self.y / vec.y, self.z / vec.z);
	};
	
	static mag = function(vec)
	{
		return point_distance_3d(0, 0, 0, self.x, self.y, self.z);	
	};
	
	static dist = function(vec)
	{
		return point_distance_3d(vec.x, vec.y, vec.z, self.x, self.y, self.z);
	};
	
	static dot = function(vec)
	{
		return dot_product_3d(vec.x, vec.y, vec.z, self.x, self.y, self.z);
	};
	
	static cross = function(vec)
	{
		return new vec3(self.y * vec.z - vec.y * self.z, self.z * vec.x - vec.z * self.x, self.x * vec.y - vec.x * self.y);
	};
	
	static eq = function(vec)
	{
		return (self.x == vec.x) && (self.y == vec.y) && (self.z == vec.z);	
	};
	
	static gt = function(vec)
	{
		return (self.x > vec.x) && (self.y > vec.y) && (self.z > vec.z);	
	};
	
	static lt = function(vec)
	{
		return (self.x < vec.x) && (self.y < vec.y) && (self.z < vec.z);	
	};
	
	static gte = function(vec)
	{
		return (self.x >= vec.x) && (self.y >= vec.y) && (self.z >= vec.z);	
	};
	
	static lte = function(vec)
	{
		return (self.x <= vec.x) && (self.y <= vec.y) && (self.z <= vec.z);	
	};
	
	static norm = function()
	{
		var m = self.mag();
		return new vec3(self.x / m, self.y / m, self.z / m);
	};
	
	static _abs = function()
	{
		return new vec3(abs(self.x), abs(self.y), abs(self.z))
	}
}