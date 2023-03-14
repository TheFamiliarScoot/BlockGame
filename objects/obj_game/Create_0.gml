/// @description Insert description here
randomize();

// resolution
game_width = room_width
game_height = room_height

// game settings
paused = false
thirdperson = false

// game objects
world = instance_create_depth(0, 0, 0, obj_world)
player = instance_create_depth(0, 0, 0, obj_player)
controller = instance_create_depth(0, 0, 0, obj_player_controller, {plyr:player})
camera = instance_create_depth(0, 0, 0, obj_camera)
player.pos_x = 0.5
player.pos_y = 16
player.pos_z = 0.5