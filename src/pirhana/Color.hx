package pirhana;

abstract Color(Int) from Int to Int
{
	public inline function new(rgb:Color)
	{
		this = rgb;
	}

	public var ai(get, set):Int;
	public var ri(get, set):Int;
	public var gi(get, set):Int;
	public var bi(get, set):Int;

	public var af(get, set):Float;
	public var rf(get, set):Float;
	public var gf(get, set):Float;
	public var bf(get, set):Float;

	public static inline function fromRGBi(r:Int, g:Int, b:Int, a = 0)
	{
		return new Color((a << 24) | (r << 16) | (g << 8) | b);
	}

	public static inline function fromRGBf(r:Float, g:Float, b:Float, a = 0.0)
	{
		return fromRGBi(Math.round(r * 255), Math.round(g * 255), Math.round(b * 255), Math.round(a * 255));
	}

	public inline function to(to:Color, ratio:Float):Color
	{
		return (Math.round(Tween.lerp(ai, to.ai,
			ratio)) << 24) | (Math.round(Tween.lerp(ri, to.ri,
				ratio)) << 16) | (Math.round(Tween.lerp(gi, to.gi, ratio)) << 8) | (Math.round(Tween.lerp(bi, to.bi, ratio)));
	}

	inline function get_ri()
		return (this >> 16) & 0xFF;

	inline function set_ri(ri:Int)
		return this = fromRGBi(ri, gi, bi, ai);

	inline function get_gi()
		return (this >> 8) & 0xFF;

	inline function set_gi(gi:Int)
		return this = fromRGBi(ri, gi, bi, ai);

	inline function get_bi()
		return (this) & 0xFF;

	inline function set_bi(bi:Int)
		return this = fromRGBi(ri, gi, bi, ai);

	inline function get_ai()
		return (this >> 24) & 0xFF;

	inline function set_ai(ai:Int)
		return this = fromRGBi(ri, gi, bi, ai);

	inline function get_rf()
		return ri / 255;

	inline function set_rf(rf:Float)
		return this = fromRGBf(rf, gf, bf, af);

	inline function get_gf()
		return gi / 255;

	inline function set_gf(gf:Float)
		return this = fromRGBf(rf, gf, bf, af);

	inline function get_bf()
		return bi / 255;

	inline function set_bf(bf:Float)
		return this = fromRGBf(rf, gf, bf, af);

	inline function get_af()
		return ai / 255;

	inline function set_af(af:Float)
		return this = fromRGBf(rf, gf, bf, af);
}