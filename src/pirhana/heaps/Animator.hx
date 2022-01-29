package pirhana.heaps;

class AnimatorState{

    public var id (default, null) : String;
    public var anim (default, null) : Array<h2d.Tile>;

    // animation specific details //
    public var loop = true;
    public var speed = 15;
    public var onAnimEnd : Null<Void->Void>;
    public var fading = false;
    
    var animator : Animator;
    var conditions : Map<String, Void->Bool> = [];

    public function new(id:String, anim:Array<h2d.Tile>, animator:Animator){
        this.id = id;
        this.anim = anim;
        this.animator = animator;
    }

    public function addCondition(id:String, fn:Void->Bool){
        this.conditions.set(id, fn);
    }

    public function enter(){
        if (onEnter != null){
            onEnter(this);
        }
    }

    public function exit(){
        if (onExit != null){
            onExit(this);
        }
    }

    public dynamic function onEnter(state:AnimatorState){

    }

    public dynamic function onExit(state:AnimatorState){

    }

    public dynamic function onUpdate(state:AnimatorState){

    }

    public function update(){

        if (onUpdate != null){
            onUpdate(this);
        }

        for (id => fn in this.conditions){
            if (fn()){
                this.animator.forcePlay(id);
                return;
            }
        }
    }
}

class Animator{

    public var anim (default, null) : h2d.Anim;

    public var scaleX (get, set) : Float;
    public var scaleY (get, set) : Float;

    public var alpha (get, set) : Float;
    public var visible (get, set) : Bool;

    public var pause (get, set) : Bool;

    var states : Map<String, AnimatorState>;
    var stateCurrent : AnimatorState;


    public function new(){
        this.anim = new h2d.Anim();
        this.states = [];
    }

    public function addState(id:String, anim:Array<h2d.Tile>){
        var state = new AnimatorState(id, anim, this);
        this.states.set(id, state);
        return state;
    }

    public function forcePlay(id:String){
        if (this.stateCurrent != null){
            this.stateCurrent.exit();
        }
        this.stateCurrent = this.states.get(id);
        this.anim.play(this.stateCurrent.anim);
        this.anim.speed = this.stateCurrent.speed;
        this.anim.loop = this.stateCurrent.loop;
        this.anim.onAnimEnd = this.stateCurrent.onAnimEnd;
        this.anim.fading = this.stateCurrent.fading;
        this.stateCurrent.enter();
    }

    public function update(){
        if (stateCurrent != null){
            stateCurrent.update();
        }
    }

    inline function get_scaleX() return anim.scaleX;
    inline function set_scaleX(scale) return anim.scaleX = scaleY;

    inline function get_scaleY() return anim.scaleY;
    inline function set_scaleY(scale) return anim.scaleY = scale;

    inline function get_alpha() return anim.alpha;
    inline function set_alpha(alpha) return anim.alpha = alpha;

    inline function get_visible() return anim.visible;
    inline function set_visible(visible) return anim.visible = visible;

    inline function get_pause() return anim.pause;
    inline function set_pause(pause) return anim.pause = pause;
}