/// @description Insert description here
// You can write your code in this editor
spd = 1

ray = new c_ray(new vec3(0, 0, 0), new vec3(0, 0, 0))
hit = new ray_hit()

block_selected = false
sel_block_x = 0
sel_block_y = 0
sel_block_z = 0
sel_norm_x = 0
sel_norm_y = 0
sel_norm_z = 0

selected_block = 1

sensitivity = 10

move_vec = new vec2(0, 0)
look_vec = new vec2(0, 0)

skybox = r_start_drawing(global.vformat_block)
r_render_skybox(skybox, c_white)
r_stop_drawing(skybox)
vertex_freeze(skybox)

mouse_deadzone = 0.01