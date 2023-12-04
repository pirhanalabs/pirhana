package pirhana.utils.message;

class MessageDispatcher{

    var listeners : Map<String, Array<Dynamic>>;
    var messageQueue : List<IMessage>;
    var messageDispatching : Array<IMessage>;

    public function new(){
        listeners = new Map<String, Array<Dynamic>>();
        messageQueue = new List<IMessage>();
        messageDispatching = new Array<IMessage>();
    }

    public function addListener<T:IMessage>(messageType:String, callback:T->Void){
        var list = listeners.get(messageType);
        if (list == null){
            listeners[messageType] = list = [];
        }
        list.push(callback);
    }

    public function removeListener<T:IMessage>(messageType:String, callback:T->Void){
        var list = listeners.get(messageType);
        if (list == null){
            return;
        }
        list.remove(callback);
        if (list.length == 0){
            listeners.remove(messageType); 
        }
    }

    public function dispatch(message:IMessage, dispatchType: pirhana.utils.message.DispatchType = QueueEnd){
        if (messageQueue.length == 0) 
            dispatchType = Immediate;
        
        if (dispatchType == QueueStart){
            messageQueue.push(message);
        }
        else if (dispatchType == QueueEnd){
            messageQueue.add(message);
        }
        else if (dispatchType == Immediate){
            _dispatch(message);
            dispatchQueue();
        }
    }

    private function _dispatch(message:IMessage){
        messageDispatching.push(message);
        var list = listeners.get(message.getType());
        if (list == null){
            return;
        }
        for (callback in list){
            callback(message);
        }
        messageDispatching.remove(message);
    }

    private function dispatchQueue(){
        if (messageQueue.length == 0 || messageDispatching.length != 0){
            return;
        }
        while(messageQueue.length != 0){
            _dispatch(messageQueue.pop());
        }
    }
}