package pirhana.ecs;

import pirhana.ecs.message.ComponentRemoved;
import pirhana.ecs.message.ComponentAdded;

class DynamicEntity extends pirhana.ecs.Entity{

    var components : Map<String, pirhana.ecs.Component>;

    public function new(){
        super();
        components = new Map<String, pirhana.ecs.Component>();
    }

    public function getComponent<T:Component>(type:String):T{
        return cast this.components[type];
    }

    public function addComponent(component:Component){
        removeComponent(component);
        this.components[component.type] = component;
        dispatchComponentAdded(component);
    }

    public function removeComponent(component:Component){
        removeComponentByType(component.type);
    }

    public function removeComponentByType(type:String){
        var component = this.components.get(type);
        if (component == null) return;
        dispatchComponentRemoved(component);
        this.components.remove(type);
    }

    public function hasComponent(type:String){
        return this.components.exists(type);
    }

    private inline function dispatchComponentAdded(component:Component){
        if (this.world != null){
            this.world.dispatcher.dispatch(new ComponentAdded(this, component));
        }
    }

    private inline function dispatchComponentRemoved(component:Component){
        if (this.world != null){
            this.world.dispatcher.dispatch(new ComponentRemoved(this, component));
        }
    }

}