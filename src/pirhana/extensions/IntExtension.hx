package pirhana.extensions;

class IntExtension
{
	/**
		Clamps an integer between min and max.
	**/
	public static function clamp(me:Int, min:Int, max:Int)
	{
		return me < min ? min : me > max ? max : me;
	}

	/**
		Wraps a number around min and max, inclusive.

		e.g.: 6.wrap(0, 5) = 0;

		e.g.: -1.wrap(0, 5) = 5;
	**/
	public static function wrap(me:Int, min:Int, max:Int)
	{
		// https://stackoverflow.com/questions/707370/clean-efficient-algorithm-for-wrapping-integers-in-c
		var range = max - min + 1;
		if (me < min)
			return me + Std.int(range * ((min - me) / range + 1)) - 1;
		return min + (me - min) % range;
	}

	public static function above(me:Int, min:Int){
		return me < min ? min : me;
	}

	public static function under(me:Int, max:Int){
		return me > max ? max : me;
	}
}
