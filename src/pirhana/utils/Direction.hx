package pirhana.utils;

enum abstract Direction(Int)
{
	public static var dirs:Array<Direction> = [Up, Left, Down, Right];

	var Up = 1;
	var Left = 4;
	var Right = 6;
	var Down = 9;

	public var x(get, never):Int;
	public var y(get, never):Int;
	public var angle(get, never):Float;

	public function new(dir:Int)
	{
		this = dir;
	}

	inline function get_x()
	{
		return (this & 3) - 1;
	}

	inline function get_y()
	{
		return (this >> 2) - 1;
	}

	inline function get_angle()
	{
		return Math.atan2(y, x);
	}
}