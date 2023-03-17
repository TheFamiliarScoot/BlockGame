rot_pitch = 0
rot_yaw = 0

pos_x = 0
pos_y = 0
pos_z = 0

vel_x = 0
vel_y = 0
vel_z = 0

frict = 1.35

on_ground = false

var box_center = new vec3(pos_x + 0.5, pos_y + box_height / 2, pos_z + 0.5);
var box_extent = new vec3(box_radius / 2, box_height / 2, box_radius / 2);
box = new c_aabb(box_center, box_extent)

col_pool = []
block_pool = []