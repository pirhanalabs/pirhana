package pirhana.ecs;

class World{

    public var entities : Map<Int, pirhana.ecs.Entity>;
    public var systems : List<pirhana.ecs.System>;

    public var dispatcher (default, null) : pirhana.message.MessageDispatcher;

    public function new(){
        entities = new Map<Int, pirhana.ecs.Entity>();
        systems = new List<pirhana.ecs.System>();
        dispatcher = new pirhana.message.MessageDispatcher();
        init();
    }

    private function init(){
        
    }

    public function addSystem(system:pirhana.ecs.System){
        this.systems.add(system);
        system.init(this);
    }

    public function removeSystem(system:pirhana.ecs.System){
        this.systems.remove(system);
    }

    public function addEntity(ent:pirhana.ecs.Entity){
        var entity = this.entities.get(ent.id);
        if (entity != null) return;
        entities[ent.id] = ent;
        @:privateAccess ent.world = this;
        for (system in this.systems)
            system.entityAdded(entity);
    }

    public function removeEntity(ent:pirhana.ecs.Entity){
        removeEntityById(ent.id);
    }

    public function removeEntityById(id:Int){
        var ent = this.entities.get(id);
        if (ent == null) return;
        this.entities.remove(id);
        for (system in this.systems){
            system.entityRemoved(ent);
        }
    }

    public function update(dt:Float){
        for (system in this.systems)
            system.update(dt);
    }
}