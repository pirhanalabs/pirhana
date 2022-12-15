package pirhana.states;

class StateMachine<K:EnumValue, T:IState>{

    var states : Map<K, T>;
    var active : Null<T>;

    public function new(){
        this.states = new Map<K, T>();
    }

    public function add(id:K, state:T){
        this.states.set(id, state);
    }

    public function goto(id:K, ?params:Dynamic){
        if (active != null){
            active.onExit();
        }
        var next = states.get(id);
        if (next != null){
            active = next;
            next.onEnter(params);
        }
    }

    public function update(tmod:Float){
        if (this.active != null)
            this.active.update(tmod);
    }

    public function postUpdate(){
        if (this.active != null)
            this.active.postUpdate();
    }
}