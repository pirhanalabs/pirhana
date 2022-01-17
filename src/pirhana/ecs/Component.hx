package pirhana.ecs;

class Component{

    public var type (get, never) : String;

    private function get_type():String{
        return "Component";
    }
}