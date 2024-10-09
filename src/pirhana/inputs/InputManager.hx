package pirhana.inputs;

import pirhana.utils.Direction;

/**
	Handles the input system of the game.
	At the moment it only handles a single gamepad at a time (singleplayer).
**/
class InputManager {
	public var onDisconnect:Null<Void->Void>;
	public var onConnected:Null<Void->Void>;

	public var pad(default, null):hxd.Pad;

	private var enumBindings:Map<PadButton, Int>;

	public function new() {
		pad = hxd.Pad.createDummy();
		updateEnumBindings();
		hxd.Pad.wait(_onPadConnected);
	}

	private function _onPadConnected(pad:hxd.Pad) {
		this.pad = pad;

		this.pad.onDisconnect = () -> {
			if (onDisconnect != null)
				onDisconnect();
		}

		if (onConnected != null) {
			onConnected();
		}

		updateEnumBindings();
	}

	private function updateEnumBindings() {
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

	public function getPadButtonValue(button:PadButton):Int {
		if (enumBindings.exists(button)) {
			return enumBindings.get(button);
		}
		return -1;
	}

	public var analogDeadzone:Float = 0.85;

	// u, d, l, r
	private var analogInputs:Map<Direction, Float> = [
		Up => 0.0, 
		Down => 0.0, 
		Left => 0.0, 
		Right => 0.0
	];

	public function isAnalogPressed(dir:Direction) {
		return analogInputs[dir] == Game.instance.frame.frames - 1;
	}

	public function isAnalogDown(dir:Direction) {
		return analogInputs[dir] > 0;
	}

	public function isAnalogReleased(dir:Direction) {
		return analogInputs[dir] == -Game.instance.frame.frames;
	}

	@:allow(pirhana.Game)
	private function update(frame:Frame) {
		// update analog inputs
		if (pad.connected) {
			var deadzone = pad.xAxis * pad.xAxis + pad.yAxis * pad.yAxis < analogDeadzone * analogDeadzone;
			if (deadzone) {
				for (direction=>value in 0...analogInputs.length) {
					analogInputs[direction] = value > 0 ? -frame.frames : 0;
				}
			} else {
				var a = MathTools.angle(0, 0, pad.xAxis, pad.yAxis);
				parseAnalogInput(Up, frame, a > -2.25 && a < -1.25);
				parseAnalogInput(Down, frame, a > 1.25 && a < 2.25);
				parseAnalogInput(Left, frame, Math.abs(a) >= 2.70);
				parseAnalogInput(Right, frame, Math.abs(a) <= 0.07);
			}
		}
	}

	private function parseAnalogInput(dir:Direction, frame:Frame, condition:Bool) {
		if (condition) {
			if (analogInputs[dir] == 0) {
				analogInputs[dir] = frame.frames;
			}
		} else {
			analogInputs[dir] = analogInputs[dir] > 0 ? -frame.frames : 0;
		}
	}

	/**
		Creates and returns a new input binding.
	**/
	public function createBinding(id:Int, key:Int, button:PadButton) {
		var binding = new InputBinding(this, id, key, button);
		return binding;
	}

	public function createDirBinding(dir:Direction, key:Int, button:PadButton){
		var binding = new InputBinding(this, id, key, button);
		binding.direction = dir;
		return binding;
	}

	/**
		Returns weither or not the given input binding is pressed. 
		NOTE: This works only for keys and pressable buttons on gamepad.
	**/
	public function isPressed(binding:InputBinding) {
		// implement this
	}

	/**
		Returns weither or not the given input binding is down. 
		NOTE: This works only for keys and pressable buttons on gamepad.
	**/
	public function isDown(binding:InputBinding) {
		// implement this
	}

	/**
		Returns weither or not the given input binding is released. 
		NOTE: This works only for keys and pressable buttons on gamepad.
	**/
	public function isReleased(binding:InputBinding) {
		// implement this
	}

	public function getString(binding:InputBinding) {
		// for now only returns with keyboard inputs. needs to support gamepad too
		return hxd.Key.getKeyName(binding.key);
	}
}