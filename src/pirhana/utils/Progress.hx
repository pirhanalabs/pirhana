package pirhana;

class Progress{

    var min:Float;
    var max:Float;
    var curr:Float;
    var onMax:Void->Void;
   
    public function new(min:Float, max:Float, ?onMax:Void->Void){
        this.min = min;
        this.max = max;
        this.curr = min;
        this.onMax = onMax;
    }

    public function reset(){
        this.curr = min;
    }

    public function getRatio(){
        return min / max;
    }

    public function addPercent(p:Float){
        add(Std.int(p * max));
    }

    public function add(val:Int){
        var wasmax = this.curr == this.max;
        if (val < 0){
            this.curr = Math.max(min, this.curr + val);
        }else{
            this.curr = Math.min(max, this.curr + val);
        }
        if (this.curr == this.max && !wasmax){
            if (onMax != null)
                onMax();
        }
    }
}