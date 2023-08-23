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
}
