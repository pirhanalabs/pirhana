package pirhana.inputs;

import pirhana.utils.Direction;

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
	public var direction:Null<Direction> = null;

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
			if (direction != null && manager.isAnalogPressed(direction)) {
				return true;
			}
		}
		return hxd.Key.isPressed(key);
	}

	public function isDown() {
		if (manager.pad.connected) {
			if (manager.pad.isDown(manager.getPadButtonValue(button))) {
				return true;
			}
			if (direction != null && manager.isAnalogDown(direction)) {
				return true;
			}
		}
		return hxd.Key.isDown(key);
	}

	public function isReleased() {
		if (manager.pad.connected) {
			if (manager.pad.isReleased(manager.getPadButtonValue(button))) {
				return true;
			}
			if (direction != null && manager.isAnalogReleased(direction)) {
				return true;
			}
		}
		return hxd.Key.isReleased(key);
	}
}