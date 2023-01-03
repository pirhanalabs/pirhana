package pirhana;

/**
 * Simplified deepnight's lib Process class.
 * if you want to use it, I recommend looking
 * at Deepnight's work, its much better than this one (:
 * https://github.com/deepnight/deepnightLibs
 */
 class Process{

    public static var FIXED_FPS = 30;
    public static var V_HEI = -1;
    public static var V_WID = -1;

    private static var ROOTS : Array<Process> = [];

    // time-related things.
    public var tmod : Float;
    public var ftime (default, null) : Float;
    public var itime (get, null) : Int;
    public var stime (get, null) : Float;
    public var window (get, null) : hxd.Window;

    @:noCompletion
    private var _fixedUpdateTime : Float;

    // hierarchy.
    private var parent : Process;
    private var children : Array<Process>;

    // flags.
    private var destroyed : Bool;
    private var paused : Bool;

    public var root (default, null) : h2d.Layers;

    private var vw (get, never) : Float;
    private var vh (get, never) : Float;

    public var cd : pirhana.Cooldown;


    public function new(?parent:Process){
        init();

        if (parent != null){
            parent.addChild(this);
        }else{
            ROOTS.push(this);
        }
    }

    private function init(){
        this.tmod = 1;
        this.ftime = 0;
        this.children = [];
        this.destroyed = false;
        this.paused = false;
        this.cd = new pirhana.Cooldown(60);
        _fixedUpdateTime = 0.0;
    }

    public function addChild(child:Process){
        if (child.parent == null) ROOTS.remove(child);
        else child.parent.children.remove(child);
        child.parent = this;
        this.children.push(child);
    }

    private function createRoot(ctx:h2d.Object){
        if (root != null)
            throw '${this}: root already exists';
        root = new h2d.Layers(ctx);
    }

    private function createRootInLayers(ctx:h2d.Layers, layer:Int){
        if (root != null)
            throw '${this}: root already exists';
        root = new h2d.Layers();
        ctx.add(root, layer);
    }

    public function preUpdate(){}
    public function update(){}
    public function fixedUpdate(){}
    public function postUpdate(){}

    public function onDispose(){}

    public function destroy(){
        this.destroyed = true;
    }

    public function isPaused(){
        if (this.paused)
            return true;
        return this.parent == null ? false : this.parent.isPaused();
    }

    public function pause(){
        this.paused = true;
    }

    public function resume(){
        this.paused = false;
    }

    public function togglePause(){
        this.paused = !this.paused;
        return this.paused;
    }


    private function getDefaultFrameRate(){
        #if heaps
            return Math.round(hxd.Timer.wantedFPS);
        #end
        return 30;
    }

    inline function get_stime() return this.ftime / getDefaultFrameRate();
    inline function get_itime() return Std.int(this.ftime);

    inline function get_vw(){
        if (V_WID < 0){
            return window.width;
        }
        return V_WID;
    }

    inline function get_vh(){
        if (V_HEI < 0)
            return window.height;
        return V_HEI;
    }

    inline function get_window(){
        return hxd.Window.getInstance();
    }




    private static function _canRun(p:Process){
        return !p.paused && !p.destroyed;
    }

    private static function _preUpdate(tmod:Float, p:Process){
        if (!_canRun(p))
            return;

        p.tmod = tmod;
        p.ftime += p.tmod;

        p.cd.update(p.tmod);

        p.preUpdate();

        if (_canRun(p)){
            for (p in p.children){
                _preUpdate(p.tmod, p);
            }
        }
    }

    private static function _mainUpdate(p:Process){
        if (!_canRun(p))
            return;

        p.update();

        if (_canRun(p)){
            for (p in p.children){
                _mainUpdate(p);
            }
        }
    }

    private static function _fixedUpdate(p:Process){
        if (!_canRun(p))
            return;

        var t = p.getDefaultFrameRate() / FIXED_FPS;
        p._fixedUpdateTime += p.tmod;

        while (p._fixedUpdateTime >= t){
            p._fixedUpdateTime -= t;
            if (_canRun(p)){
                p.fixedUpdate();
            }
        }

        if (_canRun(p)){
            for (p in p.children){
                _fixedUpdate(p);
            }
        }
    }

    private static function _postUpdate(p:Process){
        if (!_canRun(p))
            return;

        p.postUpdate();

        if (!p.destroyed){
            for (p in p.children){
                _postUpdate(p);
            }
        }
    }

    private static function _dispose(p:Process){
        for (p in p.children)
            p.destroy();
        _gc(p.children);

        if (p.parent != null){
            p.parent.children.remove(p);
        }else{
            ROOTS.remove(p);
        }

        if (p.root != null){
            p.root.remove();
        }

        p.onDispose();

        p.parent = null;
        p.children = null;
        p.root = null;
    }

    private static function _gc(list:Array<Process>){
        for (p in new pirhana.Iterators.ReverseArrayIterator(list)){
            if (p.destroyed){
                _dispose(p);
                continue;
            }
            _gc(p.children);
        }
    }

    public static function updateAll(tmod:Float){
        for (process in ROOTS)
            _preUpdate(tmod, process);

        for (process in ROOTS)
            _mainUpdate(process);

        for (process in ROOTS)
            _fixedUpdate(process);

        for (process in ROOTS)
            _postUpdate(process);

        _gc(ROOTS);
    }
}