/// Script Functions

function noisegen(s) constructor
{
	self.seed = s;
	self.perms = []
	
	var old_seed = random_get_seed()
	random_set_seed(s)
	for (var i = 0; i < 256; i++)
	{
		perms[i] = irandom_range(0, 256)	
	}
	random_set_seed(old_seed)

	static get_noise = function(xx, yy, zz)
	{
		function fade(t)
		{
			return t * t * t * (t * (t * 6 - 15) + 10)
		}
		
		function grad(hash, xx, yy, zz)
		{
		      var h = hash & 15;                      // CONVERT LO 4 BITS OF HASH CODE
		      var u = h<8 ? xx : yy;                    // INTO 12 GRADIENT DIRECTIONS.
		      var v = h<4 ? yy : (h==12||h==14 ? xx : zz);
		      return ((h&1) == 0 ? u : -u) + ((h&2) == 0 ? v : -v);
		}
		
		function getp(p)
		{
			return perms[((p % 256) + 256) % 256]	
		}
		
		var X = floor(xx) & 255;                  // FIND UNIT CUBE THAT
		var Y = floor(yy) & 255;                  // CONTAINS POINT.
		var Z = floor(zz) & 255;
		xx -= floor(xx);                            // FIND RELATIVE X,Y,Z
		yy -= floor(yy);                            // OF POINT IN CUBE.
		zz -= floor(zz);
		var u = fade(xx);                          // COMPUTE FADE CURVES
		var v = fade(yy);                              // FOR EACH OF X,Y,Z.
		var w = fade(zz);
		var	A  = getp(X)+Y
		var AA = getp(A)+Z
		var AB = getp(A+1)+Z  // HASH COORDINATES OF
		var B  = getp(X+1)+Y
		var BA = getp(B)+Z
		var BB = getp(B+1)+Z;    // THE 8 CUBE CORNERS,

		return lerp(w, lerp(v, lerp(u, grad(getp(AA  ), xx  , yy  , zz   ),  // AND ADD
									 grad(getp(BA  ), xx-1, yy  , zz   )), // BLENDED
							 lerp(u, grad(getp(AB  ), xx  , yy-1, zz   ),  // RESULTS
									 grad(getp(BB  ), xx-1, yy-1, zz   ))),// FROM  8
					 lerp(v, lerp(u, grad(getp(AA+1), xx  , yy  , zz-1 ),  // CORNERS
									 grad(getp(BA+1), xx-1, yy  , zz-1 )), // OF CUBE
							 lerp(u, grad(getp(AB+1), xx  , yy-1, zz-1 ),
									 grad(getp(BB+1), xx-1, yy-1, zz-1 ))));
	}
}