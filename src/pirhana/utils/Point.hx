package pirhana;

@:forward(x, y)
abstract Point({x:Float, y:Float}){

    public function new(x:Float, y:Float){
        this = {
            x : x,
            y : y
        };
    }
}