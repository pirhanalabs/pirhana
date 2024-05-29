package pirhana.extensions;

class IntArrayExtension{

    public static function max(a:Array<Int>):Int{
        var max = Math.NEGATIVE_INFINITY;
        for (dat in a){
            if (dat > max){
                max = dat;
            }
        }
        return Std.int(max);
    }

    public static function min(a:Array<Int>):Int{
        var min = Math.POSITIVE_INFINITY;
        for (dat in a){
            if (dat < min){
                min = dat;
            }
        }
        return Std.int(min);
    }
}