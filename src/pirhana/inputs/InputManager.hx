package pirhana.inputs;

/**
	Handles the input system of the game.
	At the moment it only handles a single gamepad at a time (singleplayer).
**/
class InputManager
{
	public var onDisconnect:Null<Void->Void>;
	public var onConnected:Null<Void->Void>;

	public var pad(default, null):hxd.Pad;

	private var enumBindings:Map<PadButton, Int>;

	public function new()
	{
		pad = hxd.Pad.createDummy();
		updateEnumBindings();
		hxd.Pad.wait(_onPadConnected);
	}

	private function _onPadConnected(pad:hxd.Pad)
	{
		this.pad = pad;

		this.pad.onDisconnect = () ->
		{
			if (onDisconnect != null)
				onDisconnect();
		}

		if (onConnected != null)
		{
			onConnected();
		}

		updateEnumBindings();
	}

	private function updateEnumBindings()
	{
		enumBindings = new Map();

		enumBindings.set(PadButton.A, pad.config.A);
		enumBindings.set(PadButton.B, pad.config.B);
		enumBindings.set(PadButton.X, pad.config.X);
		enumBindings.set(PadButton.Y, pad.config.Y);

		enumBindings.set(PadButton.RB, pad.config.RB);
		enumBindings.set(PadButton.RT, pad.config.RT);
		enumBindings.set(PadButton.LB, pad.config.LB);
		enumBindings.set(PadButton.LT, pad.config.LT);

		enumBindings.set(PadButton.DPAD_UP, pad.config.dpadUp);
		enumBindings.set(PadButton.DPAD_DOWN, pad.config.dpadDown);
		enumBindings.set(PadButton.DPAD_RIGHT, pad.config.dpadRight);
		enumBindings.set(PadButton.DPAD_LEFT, pad.config.dpadLeft);

		enumBindings.set(PadButton.START, pad.config.start);
		enumBindings.set(PadButton.SELECT, pad.config.back);

		enumBindings.set(PadButton.LSTICK_PUSH, pad.config.analogClick);
		enumBindings.set(PadButton.RSTICK_PUSH, pad.config.ranalogClick);
	}

	public function getPadButtonValue(button:PadButton):Int
	{
		if (enumBindings.exists(button))
		{
			return enumBindings.get(button);
		}
		return -1;
	}

	/**
		Creates and returns a new input binding.
	**/
	public function createBinding(id:Int, key:Int, button:PadButton)
	{
		var binding = new InputBinding(this, id, key, button);
		return binding;
	}

	/**
		Returns weither or not the given input binding is pressed. 
		NOTE: This works only for keys and pressable buttons on gamepad.
	**/
	public function isPressed(binding:InputBinding)
	{
		// implement this
	}

	/**
		Returns weither or not the given input binding is down. 
		NOTE: This works only for keys and pressable buttons on gamepad.
	**/
	public function isDown(binding:InputBinding)
	{
		// implement this
	}

	/**
		Returns weither or not the given input binding is released. 
		NOTE: This works only for keys and pressable buttons on gamepad.
	**/
	public function isReleased(binding:InputBinding)
	{
		// implement this
	}
}
