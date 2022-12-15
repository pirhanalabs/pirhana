package pirhana.states;

class StateStack<T:IState>{

    var stack : Array<T>;
    var state : T;

    var invalidated : Bool = false;

    public function new(){
        this.stack = [];
    }

    public function push(state:T, ?params:Dynamic){
        this.stack.push(state);
        this.state = state;
        this.state.onEnter(params);
    }

    public function pop():T{
        var prev = this.stack.pop();
        prev.onExit();
        if (this.stack.length != 0){
            this.invalidated = true;
            this.state = this.stack[this.stack.length-1];
        }
    }

    public function update(tmod:Float){
        this.invalidated = false;
        if (this.state != null){
            this.state.update(tmod);
        }
    }

    public function postUpdate(){
        if (this.state != null && !invalidated){
            this.state.postUpdate();
        }
    }
}