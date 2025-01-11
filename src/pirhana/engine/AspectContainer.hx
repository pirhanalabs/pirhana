package pirhana.engine;

class AspectContainer extends Container implements IAspect{

    var container:IContainer;

    public function setContainer(container:IContainer){
        this.container = container;
    }

    public function getContainer():IContainer{
        return this.container;
    }
}