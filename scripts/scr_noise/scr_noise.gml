/// Script Functions

function noisegen(s) constructor
{
	self.seed = s;
	
	static get_random_seed = function()
	{
		var range = argument[0];
		var num = 0;
		switch(argument_count)
		{
		    case 2:
		        num = argument[1];
		        break;
		    case 3:
		        num = argument[1] + argument[2] * 65536;
		        break;
		}

		var sd = self.seed + num;

		random_set_seed(sd);
		var rand = irandom_range(0,range);

		return round(rand);	
	}

	static get_noise = function()
	{
		var xx = argument0;
		var yy = argument1;
		var range = argument2;

		var chunkSize = 16;

		var noise = 0;

		range = range div 2;

		while(chunkSize > 0)
		{
		    var index_x = xx div chunkSize;
		    var index_y = yy div chunkSize;
    
		    var t_x = (xx % chunkSize) / chunkSize;
		    var t_y = (yy % chunkSize) / chunkSize;
    
		    var r_00 = self.get_random_seed(range,index_x,   index_y);
		    var r_01 = self.get_random_seed(range,index_x,   index_y+1);
		    var r_10 = self.get_random_seed(range,index_x+1, index_y);
		    var r_11 = self.get_random_seed(range,index_x+1, index_y+1);
    
		    var r_0 = lerp(r_00,r_01,t_y);
		    var r_1 = lerp(r_10,r_11,t_y);
    
		    noise += lerp(r_0,r_1,t_x);
    
		    chunkSize = chunkSize div 2;
		    range = range div 2;
		    range = max(1,range);
		}

		return round(noise);
	}
}