package pirhana.heaps.anims;

/**
    A simple object wrapper to make it easier to handle animation node stuff.
**/
class ObjectWrapper
{
	public var o(default, null):h2d.Object;

	public var x(default, set):Float;
	public var y(default, set):Float;

	public var scaleX(default, set):Float;
	public var scaleY(default, set):Float;

	public var r(default, set):Float;
	public var g(default, set):Float;
	public var b(default, set):Float;

	private var coloradd:h3d.Vector;

	public var alpha(default, set):Float;

	public function new(o:h2d.Object)
	{
		this.o = o;
		this.x = o.x;
		this.y = o.y;
		this.scaleX = o.scaleX;
		this.scaleY = o.scaleY;
		this.alpha = o.alpha;

		if (Std.isOfType(o, h2d.Drawable))
		{
			var d = cast(o, h2d.Drawable);
			if (d.colorAdd != null)
			{
				coloradd = d.colorAdd;
			}
			else
			{
				coloradd = d.colorAdd = new h3d.Vector();
			}
		}
		else
		{
			coloradd = new h3d.Vector();
		}

		r = coloradd.r;
		g = coloradd.g;
		b = coloradd.b;
	}

	inline function set_x(value:Float)
	{
		this.x = value;
		o.x = this.x;
		return x;
	}

	inline function set_y(value:Float)
	{
		this.y = value;
		o.y = this.y;
		return y;
	}

	inline function set_scaleX(value:Float)
	{
		this.scaleX = value;
		o.scaleX = this.scaleX;
		return scaleX;
	}

	inline function set_scaleY(value:Float)
	{
		this.scaleY = value;
		o.scaleY = this.scaleY;
		return scaleY;
	}

	inline function set_r(value:Float)
	{
		this.coloradd.r = value;
		return r;
	}

	inline function set_g(value:Float)
	{
		this.coloradd.g = value;
		return value;
	}

	inline function set_b(value:Float)
	{
		this.coloradd.b = value;
		return value;
	}

	inline function set_alpha(value:Float)
	{
		this.alpha = value;
		o.alpha = value;
		return alpha;
	}
}