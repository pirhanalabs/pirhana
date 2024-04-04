package pirhana;

class Application extends hxd.App
{
	/**
		Wanted FPS.
	**/
	public static var FPS(default, null):Int;

	/**
		Viewport scale.
	**/
	public static var VIEW_SCALE(get, null):Float;


	public static var INTEGER_SCALING = true;

	/** Viewport x offset **/
	public static var OFFSET_X (get, null):Float;

	/** Viewport y offset **/
	public static var OFFSET_Y (get, null):Float;

	/**
		Viewport width.
	**/
	public static var VIEW_WID(default, null):Int;

	/**
		Viewport height.
	**/
	public static var VIEW_HEI(default, null):Int;

	/**
		Half of the viewport width.
	**/
	public static var VIEW_WID_2(default, null):Float;

	/**
		Half of the viewport height.
	**/
	public static var VIEW_HEI_2(default, null):Float;

	/**
		Singleton instance.
	**/
	private static var _instance:Application;

	/**
		Application's game instance. This is what contains all the generic stuff every game needs.
	**/
	private var game:Game;

	/**
		Flag needed for initialization.
	**/
	private var intscale:Bool;

	/**
		Root and starting point of any game application.

		It initializes all the repetitive stuff required in every single game.

		override the `start()` method to do extra initialization stuff.
	**/
	private function new(viewportw, viewporth, intscale = false, fps = 60)
	{
		if (_instance != null)
		{
			throw 'There can be only one instance of Application';
		}
		_instance = this;

		FPS = fps;
		VIEW_WID = viewportw;
		VIEW_HEI = viewporth;
		VIEW_WID_2 = VIEW_WID * 0.5;
		VIEW_HEI_2 = VIEW_HEI * 0.5;
		this.intscale = intscale;

		super();
	}

	/**
		Initialization phase. Engine setup. Scalemode.
	**/
	override final function init()
	{
		super.init();

		// initialize scalemode
		s2d.scaleMode = LetterBox(VIEW_WID, VIEW_HEI, intscale, Center, Center);

		_initEngine();

		game = Game.create(this);
		haxe.Timer.delay(function()
		{
			start();
		}, 1);
	}

	/**
		Initialize the engine.
	**/
	function _initEngine()
	{
		engine.backgroundColor = 0xff << 24 | 0x111133;

		#if hl
		hl.UI.closeConsole();
		hl.Api.setErrorHandler(onCrash);
		#end

		#if (hl && debug)
		hxd.Res.initLocal();
		#else
		hxd.Res.initEmbed();
		#end

		// fix an audio bug/ sound chipping
		haxe.MainLoop.add(() -> {});
		// initialize the sound manager to avoid freeze on first sound playback.
		hxd.snd.Manager.get();
		// ignore heavy sound manager init frame.
		hxd.Timer.skip();

		// framerate
		hxd.Timer.smoothFactor = 0.4;
		hxd.Timer.wantedFPS = FPS;
	}

	/**
		Handle crashes on HL target.
	**/
	private function onCrash(err:Dynamic)
	{
		#if hl
		var title = 'Fatal Error';
		var msg = 'Error:${Std.string(err)}';
		var flags:haxe.EnumFlags<hl.UI.DialogFlags> = new haxe.EnumFlags();
		flags.set(IsError);

		hl.UI.dialog(title, msg, flags);

		hxd.System.exit();
		#end
	}

	/**
		Override this to do initialization work in subclass
	**/
	private function start()
	{
		// override this in Main
	}

	/**
		Main update loop.
	**/
	override function update(dt:Float)
	{
		super.update(dt);
		game.update();
	}

	private inline static function get_VIEW_SCALE():Float
	{
		var scaleX = Game.instance.window.width / Application.VIEW_WID;
		var scaleY = Game.instance.window.height / Application.VIEW_HEI;
		var scale = 0.0;
		if (scaleX < scaleY)
		{
			scale = scaleX;
		}
		scale = scaleY;

		return INTEGER_SCALING ? Math.floor(scale) : scale;
	}

	private inline static function get_OFFSET_X(){
		return (Game.instance.window.width - VIEW_WID * VIEW_SCALE);
	}

	private inline static function get_OFFSET_Y(){
		return (Game.instance.window.height - VIEW_HEI * VIEW_SCALE);
	}
}
