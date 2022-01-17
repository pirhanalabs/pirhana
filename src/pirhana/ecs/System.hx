package pirhana.ecs;

class System{
    
    public function new(){

    }

    /**
     * Initialization.
     * Template is used to allow world subclasses
     */
    public function init<T:pirhana.ecs.World>(world:T):Void{

    }

    /**
     * Activates when an entity is added to the world.
     * @param ent the added entity.
     */
    public function entityAdded(ent:pirhana.ecs.Entity):Void{

    }

    /**
     * Activates when an entity is removed from the world.
     * @param ent the removed entity.
     */
    public function entityRemoved(ent:pirhana.ecs.Entity):Void{

    }

    /**
     * Updates every game frame.
     * @param dt delta time.
     */
    public function update(dt:Float):Void{
        
    }
}