package pirhana.ecs;

class Entity{

    public static var idCounter (default, null) : pirhana.IntCounter;

    public var id (default, null) : Null<Int>;

    var world : pirhana.ecs.World;

    public function new(){
        if (idCounter == null){
            idCounter = new pirhana.IntCounter();
        }

        if (id == null){
            this.id = idCounter.getNextInt();
        }
    }

    public function destroy(){

    }
}