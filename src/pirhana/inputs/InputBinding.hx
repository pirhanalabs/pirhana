package pirhana.inputs;

class InputBinding {
	public var id(default, null):Int;
	public var key(default, null):Int = -1;
	public var button(default, null):Null<PadButton>;

	/**
		0 = Up

		1 = Down

		2 = Left

		3 = Right
	**/
	public var analogBinding:Int = -1;

	private var manager:InputManager;

	@:allow(pirhana.inputs.InputManager)
	private function new(c:InputManager, id:Int, key:Int, button:PadButton) {
		this.id = id;
		this.manager = c;
		this.key = key;
		this.button = button;
	}

	public function getName() {
		return manager.getString(this);
	}

	public function isPressed() {
		if (manager.pad.connected) {
			if (manager.pad.isPressed(manager.getPadButtonValue(button))) {
				return true;
			}
			if (analogBinding > 0) {
				return manager.isAnalogPressed(analogBinding);
			}
		}
		return hxd.Key.isPressed(key);
	}

	public function isDown() {
		if (manager.pad.connected) {
			if (manager.pad.isDown(manager.getPadButtonValue(button))) {
				return true;
			}
			if (analogBinding > 0) {
				return manager.isAnalogDown(analogBinding);
			}
		}
		return hxd.Key.isDown(key);
	}

	public function isReleased() {
		if (manager.pad.connected) {
			if (manager.pad.isReleased(manager.getPadButtonValue(button))) {
				return true;
			}
			if (analogBinding > 0) {
				return manager.isAnalogReleased(analogBinding);
			}
		}
		return hxd.Key.isReleased(key);
	}
}

