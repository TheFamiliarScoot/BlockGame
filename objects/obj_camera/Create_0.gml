gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);
gpu_set_cullmode(cull_counterclockwise);
layer_force_draw_depth(true, 0);

view_enabled = true
view_set_visible(view_current, true);

cam = camera_create();
var projMat = matrix_build_projection_perspective_fov(70, obj_game.game_width/obj_game.game_height, 1, 32000);
camera_set_proj_mat(cam, projMat);
view_set_camera(view_current, cam);