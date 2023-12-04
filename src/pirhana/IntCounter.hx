package pirhana;

class IntCounter{

    private static final counters:Map<String, IntCounter> = [];

    public static function createGlobal(id:String){
        resetCounter(id);
    }

    public static function next(id:String){
        if (!counters.exists(id)) return -1;
        return counters.get(id).getNextInt();
    }

    public static function resetCounter(id:String){
        counters.set(id, new IntCounter());
    }

    public static function clear(){
        counters.clear();
    }



    var val = 0;

    public function new(){

    }

    public function getNextInt(){
        return val++;
    }
}