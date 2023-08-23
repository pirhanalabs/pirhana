package pirhana.state;

class EventStateManager<T:IEventState>{

    var queue:List<T>;
    var current:T;

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

    public function update(tmod:Float){
        if (queue.length == 0 && current == null) return;

        if (current != null){
            if (current.isFinished()){
                onEventFinished(current);
                current = null;
            }else{
                current.update(tmod);
            }
        }

        var success = false;

        while (success){
            current = queue.pop();
            if (current == null){
                onAllEventFinished();
                return;
            }
            current.onEnter();
            onEventEntered(current);
            success = !current.isFinished();
            if (!success){
                onEventFinished(current);
            }
        }


    }
}