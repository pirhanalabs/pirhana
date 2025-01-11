package pirhana.engine;

interface IContainer{

    /** adds an aspect to this container. **/
    function addAspect<T:IAspect>(aspect:T, name:String = ''):T;

    /** removes an aspect from this container. **/
    function removeAspect(aspect:IAspect):Bool;

    /** returns if this container has a given aspect. **/
    function hasAspect<T:IAspect>(?aspect:Class<T>, name:String = ''):Bool;

    /** returns the instance of a given aspect class. **/
    function getAspect<T:IAspect>(aspect:Class<T>):T;

    /** returns the instance of a given aspect name. **/
    function getAspectByName<T:IAspect>(name:String):T;

    /** returns all instances of a given aspect class. **/
    function getAspects<T:IAspect>(aspect:Class<T>):Array<T>;

    /** returns all instances of a given aspect name. **/
    function getAspectsByName<T:IAspect>(name:String):Array<T>;
}