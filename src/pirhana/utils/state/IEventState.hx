package pirhana.utils.state;

interface IEventState{

    function onEnter():Void;
    function update(frame:Frame):Void;
    function postupdate():Void;
    function isFinished():Bool;
}