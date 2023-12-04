package pirhana;

import pirhana.inputs.InputManager;

/**
	This engine is heavily based on ddmills' Odyssey engine, I have been a fan of it since i tried it.
	I have since then adapted it to my taste.
	Check out their game at https://github.com/ddmills/odyssey/tree/master
**/
class Game
{
	/**
		Singleton instance of Game
	**/
	public static var instance(default, null):Game;

	/**
		Creates a Game instance. This should normally only be called inside Application.hx
	**/
	public static function create(app:hxd.App)
	{
		if (instance == null)
		{
			new Game(app);
		}
		return instance;
	}

	/** Base application layer **/
	public var app(default, null):hxd.App;

	/** Rendering manager **/
	public var layers(default, null):RenderLayerManager;

	/** Screen manager **/
	public var screens(default, null):ScreenManager;

	/** Input manager. Handles keyboard and limited partial controller support. **/
	public var inputs(default, null):InputManager;

	/** A barebone camera system **/
	public var camera(default, null):Camera;

	/** Update loop data **/
	public var frame(default, null):Frame;

	/** Application window **/
	public var window(get, null):hxd.Window;

	/**
		Engine inspired heavily on ddmills' Odyssey.
	**/
	private final function new(app:hxd.App)
	{
		instance = this;
		this.app = app;
		layers = new RenderLayerManager();
		screens = new ScreenManager();
		inputs = new InputManager();
		frame = new Frame();
		camera = new Camera();
		app.s2d.addChild(layers.ob);
	}

	/**
		Fast access to layers.render for ease of use.
	**/
	public inline function render(layer:RenderLayerManager.RenderLayerType, ob:h2d.Object)
	{
		layers.render(layer, ob);
	}

	@:allow(pirhana.Application)
	private function update()
	{
		frame.update();
		screens.current.update(frame);
		screens.current.postupdate();
		camera.update(frame);
	}

	inline function get_window()
	{
		return hxd.Window.getInstance();
	}
}
