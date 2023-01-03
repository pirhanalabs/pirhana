package pirhana;
/**
 * typedef for custom tweens
**/
typedef TweenFn = (p:Float)->Float;

class Tween{

    /**
     * 
     * usage
     * 
     *      lerp(0, 5, time/timemax)
     *      lerp(0, 5, outElastic(time/timemax))
     * 
     * @param a start value
     * @param b end value
     * @param p progress percent (0-1)
     */
    public static function lerp(a:Float, b:Float, p:Float){
        return MathTools.lerp(a, b, p);
    }

    public static function linear(p:Float){
        return p;
    }

    public static function easeIn(p:Float){
        return p * p;
    }

    public static function easeOut(p:Float){
        return flip(easeIn(flip(p)));
    }

    public static function easeInOut(p:Float){
        return lerp(easeIn(p), easeOut(p), p);
    }

    public static function spike(p:Float){
        return customSpike(linear, linear, p);
    }

    public static function spikeEaseIn(p:Float){
        return customSpike(easeIn, easeIn, p);
    }

    public static function spikeEaseOut(p:Float){
        return customSpike(easeOut, easeOut, p);
    }

    public static function spikeEaseInOut(p:Float){
        return customSpike(easeInOut, easeInOut, p);
    }

    public static function customSpike(a:TweenFn, b:TweenFn, p:Float){
        if (p < 0.5)
            return a(p / 0.5);
        return b(flip(p) / 0.5);
    }

    public static function elasticEaseOut(p:Float){
        return pow(2, -10 * p) * sin((p * 10 - 0.75) * (2 * Math.PI) / 3) + 1;
    }

    public static function elasticEaseIn(p:Float){
        return flip(elasticEaseOut(flip(p)));
    }

    public static function elasticEaseInOut(p:Float){
        return lerp(elasticEaseIn(p), elasticEaseOut(p), p);
    }

    public static function bounceEaseOut(x:Float){
        var n1 = 7.5625;
        var d1 = 2.75;
        if (x < 1 / d1)
            return n1 * x * x;
        if (x < 2 / d1)
            return n1 * (x -= 1.5 / d1) * x + 0.75;
        if (x < 2.5 / d1)
            return n1 * (x -= 2.25 / d1) * x + 0.9375;
        return n1 * (x -= 2.625 / d1) * x + 0.984375;
    }

    public static function bounceEaseIn(p:Float){
        return flip(bounceEaseOut(flip(p)));
    }

    public static function bounceEaseInOut(p:Float){
        return lerp(bounceEaseIn(p), bounceEaseOut(p), p);
    }

    public static function flip(p:Float){
        return 1 - p;
    }

    private static inline function sin(v:Float){
        return Math.sin(v);
    }

    private static inline function pow(v:Float, exp:Float){
        return Math.pow(v, exp);
    }
}