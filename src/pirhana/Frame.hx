package pirhana;

class Frame
{
	/**
		the seconds since last frame.
	**/
	public var dt(get, null):Float;

	/**
		The current number of frames per second.
	**/
	public var fps(get, null):Float;

	/**
		modifier that shows real FPS relative to desired FPS. this allows
		for the game to be frame-rate independant. Use this whenever moving
		objects on the screen.

		tmod = 1, game is running at desired speed.
		tmod < 1, game is running faster than desired speed.
		tmod > 1, game is running slower than desired speed.
	**/
	public var tmod(get, null):Float;

	/** 
		the seconds since the game has been running 
	**/
	public var elapsed(default, null):Float = 0;

	/** 
		number of frames since the game start 
	**/
	public var frames(default, null):Float = 0;

	@:allow(pirhana.Game)
	private function new() {}

	@:allow(pirhana.Game)
	private function update()
	{
		frames++;
		elapsed += dt;
	}

	inline function get_dt()
	{
		return hxd.Timer.elapsedTime;
	}

	inline function get_fps()
	{
		return hxd.Timer.fps();
	}

	inline function get_tmod()
	{
		return hxd.Timer.tmod;
	}
}
