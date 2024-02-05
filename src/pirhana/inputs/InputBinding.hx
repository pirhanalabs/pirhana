package pirhana.inputs;

class InputBinding
{
	public var id(default, null):Int;
	public var key(default, null):Int = -1;
	public var button(default, null):Null<PadButton>;

	private var manager:InputManager;

	@:allow(pirhana.inputs.InputManager)
	private function new(c:InputManager, id:Int, key:Int, button:PadButton)
	{
		this.id = id;
		this.manager = c;
		this.key = key;
		this.button = button;
	}

	public function getName(){
		return manager.getString(this);
	}

	public function isPressed()
	{
		if (manager.pad.connected)
		{
			if (manager.pad.isPressed(manager.getPadButtonValue(button)))
			{
				return true;
			}
		}
		return hxd.Key.isPressed(key);
	}

	public function isDown()
	{
		if (manager.pad.connected)
		{
			if (manager.pad.isDown(manager.getPadButtonValue(button)))
			{
				return true;
			}
		}
		return hxd.Key.isDown(key);
	}

	public function isReleased()
	{
		if (manager.pad.connected)
		{
			if (manager.pad.isReleased(manager.getPadButtonValue(button)))
			{
				return true;
			}
		}
		return hxd.Key.isReleased(key);
	}
}
