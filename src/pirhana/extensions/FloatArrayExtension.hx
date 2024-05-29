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

    public static function min(a:Array<Float>):Float{
        var min = Math.POSITIVE_INFINITY;
        for (dat in a){
            if (dat < min){
                min = dat;
            }
        }
        return min;
    }
}