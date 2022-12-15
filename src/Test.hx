class Test extends hxd.App{

    public static function main(){
        new Test();
    }

    override function init() {
        super.init();

        var x = pirhana.MathTools.bezier3(0.1, 0, 80, 100);
        var y = pirhana.MathTools.bezier3(0.1, 0, 100, 0);
    }
}