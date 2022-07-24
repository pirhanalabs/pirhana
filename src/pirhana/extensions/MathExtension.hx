using pirhana.extensions.MathExtension;

class MathExtension
{
	public static function irand(clas:Class<Math>, min:Int, max:Int):Int
	{
		return Math.floor(Math.random() * (max - min + 1)) + min;
	}

	public static function pick<T>(clas:Class<Math>, a:Array<T>):T
	{
		return a[Math.irand(0, a.length - 1)];
	}

	public static function distance(clas:Class<Math>, x1, y1, x2, y2)
	{
		return Math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2));
	}

	public static function imid(clas:Class<Math>, val:Int, min:Int, max:Int)
	{
		return val < min ? min : val > max ? max : val;
	}

	public static function imin(clas:Class<Math>, val1:Int, val2:Int)
	{
		return val1 < val2 ? val1 : val2;
	}
}
