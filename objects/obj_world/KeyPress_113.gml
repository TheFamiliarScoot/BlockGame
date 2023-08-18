s_load_world(id, 0)
var xx = 0;
var yy = 0;
repeat (array_length(chunks))
{
	repeat(array_length(chunks[xx]))
	{
		chunks[xx][zz].update_vbuffers(self)	
	}
	xx++;
	zz = 0;
}