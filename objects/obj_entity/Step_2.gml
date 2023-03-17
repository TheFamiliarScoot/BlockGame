/// @description Dereference AABB pool (prevents a memory leak)
for (var i = 0; i < array_length(aabb_pool); i++)
{
	delete aabb_pool[i]	
}