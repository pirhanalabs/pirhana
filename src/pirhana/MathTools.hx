package pirhana;

class MathTools
{

    inline public static final PI_HALF = 1.5707963267948966;
    inline public static final PI   = 3.141592653589793;
    inline public static final PI2  = 6.283185307179586;
    inline public static final ANGLE_360 = PI2;
    inline public static final ANGLE_180 = PI;
    inline public static final ANGLE_90 = PI_HALF;
    inline public static final ANGLE_45 = 0.785398163397448;

    inline public static final RAD_TO_DEG = 180 / PI;
    inline public static final DEG_TO_RAD = PI / 180;

    public static inline function toRadian(deg:Float){
        return deg * MathTools.DEG_TO_RAD;
    }

    public static inline function toDegree(rad:Float){
        return rad * MathTools.RAD_TO_DEG;
    }

    public static inline function angle(x1:Float, y1:Float, x2:Float, y2:Float){
        return Math.atan2(y1-y2, x1-x2);
    }

    public static inline function pretty(x:Float, precision = 2):Float{
        if (precision == 0)
            return Math.round(x);
        var d = Math.pow(10, precision);
        return Math.round(x*d)/d;
    }

    public static inline function rand(min:Float, max:Float){
        return Math.random() * (max-min) + min;
    }

	public static inline function irand(min:Int, max:Int):Int
	{
		return Math.floor(Math.random() * (max - min + 1)) + min;
	}

	public static inline function pick<T>(a:Array<T>, start = -1, end:Int = -1):T
	{
        start = start < 0 ? 0 : start;
        end = end < 0 ? a.length-1 : end;
		return a[MathTools.irand(start, end)];
	}

	public static inline function distance(x1:Float, y1:Float, x2:Float, y2:Float)
	{
		return Math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2));
	}

    public static inline function inRange(x:Float, min:Float, max:Float){
        return x >= min && x <= max;
    }

	public static inline function imid(val:Int, min:Int, max:Int)
	{
		return val < min ? min : val > max ? max : val;
	}

	public static inline function imin(a:Int, b:Int)
	{
		return a < b ? a : b;
	}

    public static inline function imax(a:Int, b:Int){
        return a > b ? a : b;
    }

    public static inline function iabs(val:Int){
        return val < 0 ? -val : val;
    }

    public static inline function sign(x:Float){
        return (x > 0) ? 1 : (x < 0 ? -1 : 0);
    }

    public static inline function wrap(x:Int, min:Int, max:Int){
        return x < min ? (x-min) + max + 1: ((x > max) ? (x - max) + min - 1 : x);
    }

    inline public static function lerp(a:Float, b:Float, t:Float){
        return a + (b - a) * t;
    }

    /**
     * modulo supporting negative values
     */
    inline public static function mod(n:Float, mod:Float){
        while (n > mod)
            n -= mod*2;
        while (n < -mod)
            n += mod*2;
        return n;
    }

    public static inline function bezier3(t:Float, a:Float, b:Float, c:Float){
        return (1 - t)*(1 - t)*a + 2*(1 - t)*t*b + t*t*c;
    }
}