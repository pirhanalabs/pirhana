package pirhana.engine;

class Container implements IContainer{

    var aspectsSorted:Map<String, Array<IAspect>> = [];
    var aspectsList:Array<IAspect> = [];

    public function addAspect<T:IAspect>(aspect:T, name:String = ''){
        if (aspect == null)
            return null;

        if (name == ''){
            name = Type.getClassName(Type.getClass(aspect));
        }

        var list = aspectsSorted.get(name);

        if (list == null){
            aspectsSorted.set(name, list = []);
        }

        list.push(aspect);
        aspectsList.push(aspect);

        aspect.setContainer(this);

        return aspect;
    }

    public function removeAspect(aspect:IAspect){
        if (aspect == null)
            return false;

        var name = Type.getClassName(Type.getClass(aspect));

        var list = aspectsSorted.get(name);
        var result = list.remove(aspect);

        if (list.length == 0){
            aspectsSorted.remove(name);
        }

        aspectsList.remove(aspect);
        return result;
    }

    public function hasAspect<T:IAspect>(?aspect:Class<T>, name:String = ''){
        if (name == ''){
            if (aspect == null)
                return false;
            name = Type.getClassName(aspect);
        }

        return aspectsSorted.exists(name);
    }

    public function getAspect<T:IAspect>(aspect:Class<T>):T{
        if (aspect == null)
            return null;

        var name = Type.getClassName(aspect);

        if (!aspectsSorted.exists(name))
            return null;

        return cast aspectsSorted.get(name)[0];
    }

    public function getAspectByName<T:IAspect>(name:String):T{
        if (!aspectsSorted.exists(name))
            return null;

        return cast aspectsSorted.get(name)[0];
    }

    public function getAspects<T:IAspect>(aspect:Class<T>):Array<T>{
        if (aspect == null)
            return null;

        var name = Type.getClassName(aspect);

        if (!aspectsSorted.exists(name))
            return null;

        return cast aspectsSorted.get(name);
    }

    public function getAspectsByName<T:IAspect>(name:String):Array<T>{
        if (!aspectsSorted.exists(name))
            return null;

        return cast aspectsSorted.get(name);
    }
}