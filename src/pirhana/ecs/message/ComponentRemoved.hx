package pirhana.ecs.message;

class ComponentRemoved implements pirhana.message.IMessage{

    public static final TYPE : String = "pirhana.ecs.message.ComponentRemoved";

    public var ent : pirhana.ecs.DynamicEntity;
    public var component : pirhana.ecs.Component;

    public function new(ent:pirhana.ecs.DynamicEntity, component:pirhana.ecs.Component){
        this.ent = ent;
        this.component = component;
    }

    public function getType(){
        return TYPE;
    }
}