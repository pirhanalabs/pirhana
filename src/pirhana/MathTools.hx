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

    /**
        Converts degrees to radians.
    **/
    public static inline function toRadian(deg:Float){
        return deg * MathTools.DEG_TO_RAD;
    }

    /**
        Converts radians to degrees.
    **/
    public static inline function toDegree(rad:Float){
        return rad * MathTools.RAD_TO_DEG;
    }

    /**
        Returns the angle between two points, in radians.
    **/
    public static inline function angle(x1:Float, y1:Float, x2:Float, y2:Float){
        return Math.atan2(y2-y1, x2-x1);
    }

    /**
        Discards a given number of decimals on a float and keeps `precision` decimals. 
    **/
    public static inline function pretty(x:Float, precision = 2):Float{
        if (precision == 0)
            return Math.round(x);
        var d = Math.pow(10, precision);
        return Math.round(x*d)/d;
    }

    /**
        Randomly picks a float between min and max, seeded.    
    **/ 
    public static function seeded_rand(min:Float, max:Float, seed:hxd.Rand){
        return seed.rand() * (max-min) + min;
    }

    /**
        Randomly picks an integer between min and max, seeded.
    **/
    public static function seeded_irand(min:Int, max:Int, seed:hxd.Rand){
        return Math.floor(seed.rand() * (max-min)) + min;
    }

    /**
        Picks a random item from an array, seeded.
    **/
    public static inline function seeded_pick<T>(a:Array<T>, start = -1, end:Int = -1, seed:hxd.Rand):T
    {
        start = start < 0 ? 0 : start;
        end = end < 0 ? a.length-1 : end;
        return a[MathTools.seeded_irand(start, end, seed)];
    }

    /**
        Randomly picks a float between min and max, unseeded.    
    **/    
    public static inline function rand(min:Float, max:Float){
        return Math.random() * (max-min) + min;
    }

    /**
        Randomly picks an integer between min and max, unseeded.
    **/
	public static inline function irand(min:Int, max:Int):Int
	{
		return Math.floor(Math.random() * (max - min + 1)) + min;
	}

    /**
        Picks a random item from an array, unseeded.
    **/
	public static inline function pick<T>(a:Array<T>, start = -1, end:Int = -1):T
	{
        start = start < 0 ? 0 : start;
        end = end < 0 ? a.length-1 : end;
		return a[MathTools.irand(start, end)];
	}

    /**
        Returns the distance between two points
    **/
	public static inline function distance(x1:Float, y1:Float, x2:Float, y2:Float)
	{
		return Math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2));
	}

    /**
        returns if x is between min and max
    **/
    public static inline function inRange(x:Float, min:Float, max:Float){
        return x >= min && x <= max;
    }

    /**
        Returns the minimum value as an integer
    **/
	public static inline function imin(a:Int, b:Int)
	{
		return a < b ? a : b;
	}

    /**
        Returns the maximum value as an integer
    **/
    public static inline function imax(a:Int, b:Int){
        return a > b ? a : b;
    }

    /**
        Returns the absolute value as an integer.
    **/
    public static inline function iabs(val:Int){
        return val < 0 ? -val : val;
    }

    /**
        Returns the sign of x.
    **/
    public static inline function sign(x:Float){
        return (x > 0) ? 1 : (x < 0 ? -1 : 0);
    }

    /**
        Wraps x between min and max. If it passes a value treshold, it will return on the other side
    **/
    public static inline function wrap(x:Int, min:Int, max:Int){
        return x < min ? (x-min) + max + 1: ((x > max) ? (x - max) + min - 1 : x);
    }

    /**
        Clamps x between min and max.
    **/
    public static inline function clamp(x:Int, min:Int, max:Int){
        return x < min ? min : x > max ? max : x;
    }

    /**
        Lerp between two values. To do tween interpolation, see `Tween.hx`
    **/
    inline public static function lerp(a:Float, b:Float, t:Float){
        return a + (b - a) * t;
    }

    /**
        Modulo supporting negative values properly
    **/
    public inline static function modneg(n:Float, mod:Float){
        while (n > mod)
            n -= mod*2;
        while (n < -mod)
            n += mod*2;
        return n;
    }

    public static inline function range(val:Float, omin:Float, omax:Float, nmin:Float, nmax:Float){
        return (((val-omin)*(nmax-nmin)) / (omax - omin)) + nmin;
    }

    /**
        Creates a bezier curve. It is applied to a single axis at a time (x or y). call this on each to get a bezier curve point
        @param t progress on the bezier curve
        @param a first point on the bezier curve
        @param b second point on the bezier curve
        @param c third point on the bezier curve
    **/
    public static inline function bezier3(t:Float, a:Float, b:Float, c:Float){
        return (1 - t)*(1 - t)*a + 2*(1 - t)*t*b + t*t*c;
    }

    /**
        allow to center multiple elements.
    **/
    public static function layout(item_size:Float, num_items:Int, pos:Int)
    {
        return (-item_size * (num_items - 1) * 0.5) + (item_size * pos);
    }
}