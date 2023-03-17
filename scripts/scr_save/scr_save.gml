function s_save_world(obj, i)
{
	var save = buffer_create(0, buffer_grow, 1)
	buffer_write(save, buffer_u64, obj.noise.seed)
	for (var xx = 0; xx < array_length(obj.chunks); xx++)
	{
		for (var zz = 0; zz < array_length(obj.chunks[xx]); zz++)
		{
			var c = obj.chunks[xx][zz]
			buffer_write(save, buffer_u32, xx)
			buffer_write(save, buffer_u32, zz)
			
			buffer_compress(c.grid_buffer, 0, buffer_get_size(c.grid_buffer))
			var size = buffer_get_size(c.grid_buffer)
			buffer_write(save, buffer_u64, size)
			buffer_copy(c.grid_buffer, 0, size, save, buffer_tell(save))
			buffer_decompress(c.grid_buffer)
			buffer_seek(save, buffer_seek_relative, size)
		}
	}
	buffer_compress(save, 0, buffer_get_size(save))
	buffer_save(save, "world" + string(i))
	buffer_delete(save)
}

function s_load_world(obj, i)
{
	var save = buffer_load("world" + string(i))
	buffer_decompress(save)
	obj.noise.seed = buffer_read(save, buffer_u64)
	while (buffer_tell(save) < buffer_get_size(save))
	{
		var xx = buffer_read(save, buffer_u32)
		var zz = buffer_read(save, buffer_u32)
		
		var size = buffer_read(save, buffer_u64)
		obj.chunks[xx][zz].load_compressed_from_buffer(save, buffer_tell(save), size)
		buffer_seek(save, buffer_seek_relative, size)
	}
}