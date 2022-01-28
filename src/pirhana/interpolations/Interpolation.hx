package pirhana.interpolations;

interface Interpolable{
    function getRatio(ratio:Float):Point;
}

class Interpolation{

    var callback : Null<Void->Void>;
    var stime : Float;
    var curtime : Float;
    var target : h2d.Object;
    var interpolation : Interpolable;

    public function new(){
        this.curtime = 0;
    }

    public function setTimeS(time:Float){
        this.stime = time;
        return this;
    }

    public function setTarget(target:h2d.Object){
        this.target = target;
        return this;
    }

    public function setInterpolation(interpolation:Interpolable){
        this.interpolation = interpolation;
        return this;
    }

    public function setCallback(fn:Void->Void){
        this.callback = fn;
        return this;
    }

    public function update(dt:Float){
        var point = interpolation.getRatio(curtime/stime);
        
        target.x = point.x;
        target.y = point.y;

        curtime += dt;
        if (curtime >= stime){
            if (callback != null){
                callback();
            }
        }
    }
}