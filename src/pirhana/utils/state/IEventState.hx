package pirhana.utils.state;

interface IEventState{

    function onEnter():Void;
    function update(tmod:Float):Void;
    function isFinished():Bool;
}