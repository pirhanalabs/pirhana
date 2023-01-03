package pirhana;

class CooldownItem{

    public var paused : Bool = false;
    public var id : String;
    public var init : Float;
    public var curr : Float;
    public var cb:Void->Void;

    public function new(id:String, frames:Int, cb:Void->Void){
        this.id = id;
        this.init = frames;
        this.curr = frames;
        this.cb = cb;
    }

    public function add(val:Float){
        if (val < 0){
            this.curr = Math.max(0, this.curr + val);
        }else{
            this.curr = Math.min(0, this.curr + val);
        }
    }

    public function getRatio(){
        return curr == 0 ? 0 : curr / init;
    }

    public function getProgress(){
        return 1 - getRatio();
    }
}

class Cooldown{

    var fps : Int;
    var cds : Map<String, CooldownItem> = [];
    var all : List<CooldownItem> = new List();

    public function new(fps:Int){
        this.fps = fps;
    }

    public function has(id:String){
        return cds.exists(id);
    }

    public function getRatio(id:String){
        var cd = cds.get(id);
        if (cd != null){
            return cd.getRatio();
        }
        return 0;
    }

    public function getProgress(id:String){
        var cd = cds.get(id);
        if (cd != null){
            return cd.getProgress();
        }
        return 0;
    }

    public function remove(id:String){
        var cd = cds.get(id);
        if (cd != null){
            cds.remove(id);
            all.remove(cd);
        }
    }

    public function pause(id:String){
        var cd = cds.get(id);
        if (cd != null){
            cd.paused = true;
        }
    }

    public function resume(id:String){
        var cd = cds.get(id);
        if (cd != null){
            cd.paused = false;
        }
    }

    /**
     * pos val increases the time, up to initial time.
     * neg val decreases the time, up to 0.
     */
    public function addFTo(id:String, frames:Int){
        var cd = cds.get(id);
        if (cd != null){
            cd.add(frames);
        }
    }

    /**
     * pos val increases the time, up to initial time.
     * neg val decreases the time, up to 0.
     */
    public function addSTo(id:String, seconds:Float){
        addFTo(id, Math.round(seconds * fps));
    }

    public function addS(id:String, seconds:Float, ?onFinish:Void->Void){
        addF(id, Math.round(seconds * fps), onFinish);
    }

    public function addF(id:String, frames:Int, ?onFinish:Void->Void){
        if (has(id)){
            remove(id);
        }
        var cd = new CooldownItem(id, frames, onFinish);
        cds[id] = cd;
        all.push(cd);
    }

    public function update(tmod:Float){
        for (cd in all){

            if (cd.paused) 
                continue;

            // if infinite
            if (cd.init < 0)
                continue;

            // before time calculations so that we get
            // an extra frame after the cd is done.
            if (cd.getRatio() == 0){
                if (cd.cb != null){
                    cd.cb();
                }
                remove(cd.id);
            }

            cd.add(-tmod);
        }
    }
}