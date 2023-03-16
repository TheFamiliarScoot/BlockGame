r_push_matrix()
r_scale(global.world_scale, global.world_scale, global.world_scale)

with (obj_spatial)
{
	if (id == obj_player)
	{
		if (obj_game.thirdperson)
		{
			event_perform(ev_draw, 0)
		}
	}
	else
	{
		event_perform(ev_draw, 0)
	}
}

r_pop_matrix()