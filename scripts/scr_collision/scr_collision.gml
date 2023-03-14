function c_aabb(center, ext) constructor
{
	self.center = center;
	self.ext = ext;
	
	static check_aabb = function(aabb)
	{
        var box_min = self.get_min();
        var box_max = self.get_max();
        var other_min = aabb.get_min();
        var other_max = aabb.get_max();
        return ((box_min.x <= other_max.x) && (box_max.x >= other_min.x) && (box_min.y <= other_max.y) && (box_max.y >= other_min.y) && (box_min.z <= other_max.z) && (box_max.z >= other_min.z));
	};
	
	static check_ray = function(ray, hit_info)
	{
	    var box_min = self.get_min();
        var box_max = self.get_max();
        
        var ray_x = (ray.dir.x == 0) ? 0.0001 : ray.dir.x;
        var ray_y = (ray.dir.y == 0) ? 0.0001 : ray.dir.y;
        var ray_z = (ray.dir.z == 0) ? 0.0001 : ray.dir.z;
        
        var t1 = (box_min.x - ray.pos.x) / ray_x;
        var t2 = (box_max.x - ray.pos.x) / ray_x;
        var t3 = (box_min.y - ray.pos.y) / ray_y;
        var t4 = (box_max.y - ray.pos.y) / ray_y;
        var t5 = (box_min.z - ray.pos.z) / ray_z;
        var t6 = (box_max.z - ray.pos.z) / ray_z;
        
        var tmin = max(
            min(t1, t2),
            min(t3, t4),
            min(t5, t6)
        );
        var tmax = min(
            max(t1, t2),
            max(t3, t4),
            max(t5, t6)
        );
        
        if (tmax < 0) return false;
        if (tmin > tmax) return false;
        
        var t = tmax;
        if (tmin > 0)
		{
            t = tmin;
        }
        
        var contact_point = ray.pos.add(ray.dir.mul(t));
        
        var tnormal;
        if (t == t1) tnormal = new vec3(-1, 0, 0);
        if (t == t2) tnormal = new vec3(+1, 0, 0);
        if (t == t3) tnormal = new vec3(0, -1, 0);
        if (t == t4) tnormal = new vec3(0, +1, 0);
        if (t == t5) tnormal = new vec3(0, 0, -1);
        if (t == t6) tnormal = new vec3(0, 0, +1);
        
        hit_info.update(t, self, contact_point, tnormal);
        
        return true;
	};
	
	static get_min = function()
	{
		return self.center.sub(self.ext);
	};
	
	static get_max = function()
	{
		return self.center.add(self.ext);
	};
}

function c_ray(pos, dir) constructor
{
	self.pos = pos;
	self.dir = dir.norm();

	static check_aabb = function(aabb, hit_info)
	{
		return aabb.check_ray(aabb, hit_info);
	};
	
	static check_ray = function(ray, hit_info)
	{
	
	};
}

function ray_hit() constructor
{
    self.shape = undefined;
    self.point = undefined;
    self.distance = infinity;
    self.normal = undefined;
    
    static update = function(distance, shape, point, normal)
	{
        if (distance < self.distance)
		{
            self.distance = distance;
            self.shape = shape;
            self.point = point;
            self.normal = normal;
        }
    };
    
    static clear = function()
	{
        self.shape = undefined;
        self.point = undefined;
        self.distance = infinity;
        self.normal = undefined;
    };
}