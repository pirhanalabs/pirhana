package pirhana;

class Screen
{
	private var game(get, never):Game;

	inline function get_game()
	{
		return Game.instance;
	}

	@:allow(pirhana.ScreenManager)
	function ready():Void
	{
		// override this in subclasses
	}

	@:allow(pirhana.Game)
	function update(frame:Frame):Void
	{
		// override this in subclasses
	}

	@:allow(pirhana.Game)
	function permupdate(frame:Frame):Void{
		// override this in subclasses.
		// this is necessary for updating certain game
		// aspects regardless if we are the active screen
		// or not.
	}

	@:allow(pirhana.Game)
	function postupdate():Void
	{
		// override this in subclasses
	}

	@:allow(pirhana.ScreenManager)
	function dispose():Void
	{
		// override this in subclasses
	}

	@:allow(pirhana.ScreenManager)
	function suspend():Void
	{
		// override this in subclasses
	}

	@:allow(pirhana.ScreenManager)
	function resume():Void
	{
		// override this in subclasses
	}
}
