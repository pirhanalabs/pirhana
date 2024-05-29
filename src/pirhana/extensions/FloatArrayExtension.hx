package pirhana.extensions;

class FloatArrayExtension{

    public static function max(a:Array<Float>):Float{
        var max = Math.NEGATIVE_INFINITY;
        for (dat in a){
            if (dat > max){
                max = dat;
            }
        }
        return max;
    }

    public static function absmax(a:Array<Float>):Float{
        var max = 0;
        for (dat in a){
            if (Math.abs(dat) > max){
                max = Math.abs(dat);
            }
        }
        return max;
    }

    public static function min(a:Array<Float>):Float{
        var min = Math.POSITIVE_INFINITY;
        for (dat in a){
            if (dat < min){
                min = dat;
            }
        }
        return min;
    }

    public static function normalize(a:Array<Float>, copy:Bool = false){
        var max = absmax(a);
        for (i in 0 ... a.length){
            a[i] += max;
        }
        max = max(a);
        for (i in 0 ... a.length){
            a[i] /= max;
        }
    }
}