package pirhana.extensions;

class FloatExtension
{
	public static function clamp(me:Float, min:Float, max:Float)
	{
		return me < min ? min : me > max ? max : me;
	}

	public static function pretty(me:Float, precision = 2):Float
	{
		if (precision == 0)
			return Math.round(me);
		var d = Math.pow(10, precision);
		return Math.round(me * d) / d;
	}

	public static inline function int(me:Float)
	{
		return Math.floor(me);
	}

	public static function above(me:Float, min:Float){
		return me < min ? min : me;
	}

	public static function under(me:Float, max:Float){
		return me > max ? max : me;
	}

	/**
		Wraps a number around min and max, inclusive.

		e.g.: 6.wrap(0, 5) = 0;

		e.g.: -1.wrap(0, 5) = 5;
	**/
	public static function wrap(me:Float, min:Float, max:Float)
		{
			// https://stackoverflow.com/questions/707370/clean-efficient-algorithm-for-wrapping-integers-in-c
			var range = max - min + 1;
			if (me < min)
				return me + Std.int(range * ((min - me) / range + 1)) - 1;
			return min + (me - min) % range;
		}
}
