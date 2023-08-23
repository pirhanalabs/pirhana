package pirhana.state;

interface IState{

    /** triggers whenever this state is entered **/
    function onEnter():Void;
    /** triggers whenever this state is destroyed **/
    function onDestroy():Void;
    /** triggers whenever this state is not active **/
    function onSuspend():Void;
    /** triggers whenever this state is back to active **/
    function onResume():Void;
    /** triggers every frame **/
    function update(tmod:Float):Void;
}