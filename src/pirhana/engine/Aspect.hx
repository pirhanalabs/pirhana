package pirhana.engine;

class Aspect implements IAspect{

    private var container:IContainer;

    public function setContainer(container:IContainer){
        this.container = container;
    }

    public function getContainer():IContainer{
        return this.container;
    }
}