package pirhana.utils.state;

interface IEventState{

    function onEnter():Void;
    function update(tmod:Float):Void;
    function postupdate():Void;
    function isFinished():Bool;
}