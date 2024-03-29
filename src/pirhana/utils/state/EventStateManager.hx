package pirhana.utils.state;

class EventStateManager<T:IEventState>{

    var queue:List<T>;
    var current:T;

    public var length (get, never):Int;

    /**
        An event queue system that triggers one after the other.
        If an event is finished on the same frame it started, it will not take up a frame.
    **/
    public function new(){
        queue = new List();
    }

    public function addTop(event:T){
        queue.push(event);
    }

    public function addBottom(event:T){
        queue.add(event);
    }

    /** triggers whenever an event is begun. **/
    public dynamic function onEventEntered(state:T){

    }

    /** triggers whenever an event is done. **/
    public dynamic function onEventFinished(state:T){

    }

    /** triggers whenever all events in queue are done. **/
    public dynamic function onAllEventFinished(){

    }

    public function hasEvent(){
        return current != null || length > 0;
    }

    private inline function get_length(){
        return queue.length + (current == null ? 0 : 1);
    }

    public function update(frame:Frame){
        if (queue.length == 0 && current == null) return;

        var success = true;

        if (current != null){
            if (current.isFinished()){
                onEventFinished(current);
                current = null;
                success = true;
            }else{
                current.update(frame);
                success = false;
            }
        }

        while (success){
            current = queue.pop();
            if (current == null){
                onAllEventFinished();
                return;
            }
            current.onEnter();
            onEventEntered(current);
            success = current.isFinished();
            if (success){
                onEventFinished(current);
            }
        }
    }

    public function postupdate(){
        if (current != null){
            current.postupdate();
        }
    }
}