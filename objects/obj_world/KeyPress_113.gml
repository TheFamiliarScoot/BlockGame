s_load_world(id, 0)
for (var xx = 0; xx < array_length(chunks); xx++)
{
	for (var zz = 0; zz < array_length(chunks[xx]); zz++)
	{
		chunks[xx][zz].update_vbuffers()	
	}
}