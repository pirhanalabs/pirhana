package pirhana;

private class EmptyScreen extends Screen
{
	public function new() {}
}

class ScreenManager
{
	var screens:Array<Screen>;

	public var current(get, never):Screen;
	public var previous(get, never):Screen;

	inline function get_current()
	{
		return screens[screens.length - 1];
	}

	inline function get_previous()
	{
		return screens[screens.length - 2];
	}

	public function new()
	{
		screens = new Array();
		screens.push(new EmptyScreen());
	}

	public function set(screen:Screen)
	{
		while (screens.length > 0)
		{
			current.dispose();
			screens.pop();
		}
		screens.push(screen);
		current.ready();
	}

	public function push(screen:Screen)
	{
		current.suspend();
		screens.push(screen);
		current.ready();
	}

	public function pop()
	{
		current.dispose();
		screens.pop();
		current.resume();
	}
}
