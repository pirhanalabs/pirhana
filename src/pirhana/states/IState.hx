package pirhana.states;

interface IState{
    public function onEnter(?params:Dynamic):Void;
    public function onExit():Void;
    public function update(tmod:Float):Void;
    public function postUpdate():Void;
}