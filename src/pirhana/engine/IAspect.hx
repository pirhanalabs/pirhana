package pirhana.engine;

interface IAspect{

    /** gets the container parenting this aspect. **/
    function getContainer():IContainer;

    /** sets the container parenting this aspect. **/
    function setContainer(container:IContainer):Void;
}