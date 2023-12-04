package pirhana.utils.state;

class StateManager<T:IState>{

    private var states:Array<T>;

    /** the currently active state. **/
    public var current (get, null):T;
    /** the previously active state. **/
    public var previous (get, null):T;
    /** a copy of the states array. **/
    public var stack (get, null):Array<T>;

    /** creates a new state manager. It is both a state stack and a state machine. **/
    public function new(){
        this.states = new Array();
    }

    /** removes all states and set the given one. **/
    public function set(state:T){
        while (states.length > 0){
            current.onDestroy();
            states.pop();
        }
        states.push(state);
        current.onEnter();
    }

    /** replaces the current state with the given one. **/
    public function replace(state:T){
        current.onDestroy();
        states.pop();
        states.push(state);
        current.onEnter();
    }

    /** pushes the given state on top of the stack. **/
    public function push(state:T){
        current.onSuspend();
        states.push(state);
        current.onEnter();
    }

    /** pops the current state and resume the previous one. **/
    public function pop(){
        if (current != null){
            current.onDestroy();
        }
        states.pop();
        if (current != null){
            current.onResume();
        }
    }

    inline function get_current(){
        return states[states.length-1];
    }

    inline function get_previous(){
        return states[states.length-2];
    }

    inline function get_stack(){
        return states.copy();
    }
}