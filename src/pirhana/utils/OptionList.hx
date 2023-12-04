package pirhana.utils;

using pirhana.extensions.IntExtension;

interface IOptionList
{
	public function getCurrent():OptionListItem;
	public function moveUp():Void;
	public function moveDown():Void;
	public function moveLeft():Void;
	public function moveRight():Void;
	public function select():Void;
}

interface OptionListItem
{
	var x(default, set):Float;
	var y(default, set):Float;
	function onActive():Void;
	function onInactive():Void;
	function onSelect():Void;
	function update(frame:Frame):Void;
}

class OptionList<T:OptionListItem> implements IOptionList
{
	public var warp:Bool = false;

	public var list:Array<T>;
	public var current(get, never):T;

	private var cols(default, null):Int;
	private var rows(default, null):Int;

	private var index(default, set):Int;

	private var x(get, never):Int;
	private var y(get, never):Int;

	public function new(cols:Int = 1, rows:Int = 0)
	{
		this.cols = cols;
		this.rows = rows;
	}

	public function setOptions(list:Array<T>, index:Int = 0)
	{
		this.list = list;

		for (i in 0...list.length)
		{
			onAdded(list[i], getx(i), gety(i));
		}

		this.index = index;
	}

	public function getCurrent()
	{
		return current;
	}

	public function moveUp()
	{
		delta(0, -1, onMoveUp);
	}

	public function moveDown()
	{
		delta(0, 1, onMoveDown);
	}

	public function moveLeft()
	{
		delta(-1, 0, onMoveLeft);
	}

	public function moveRight()
	{
		delta(1, 0, onMoveRight);
	}

	private function delta(dx:Int, dy:Int, cb:T->Void)
	{
		var nx = x + dx;
		var ny = y + dy;

		if (rows > 0)
		{
			ny = warp ? ny.wrap(0, rows - 1) : ny.clamp(0, rows - 1);
		}
		else
		{
			ny = warp ? ny.wrap(0, list.length - 1) : ny.clamp(0, list.length - 1);
		}

		nx = warp ? nx.wrap(0, cols - 1) : nx.clamp(0, cols - 1);

		index = ny * cols + nx;

		if (cb != null)
		{
			cb(current);
		}
	}

	public dynamic function onAdded(item:T, x:Int, y:Int) {}

	public dynamic function onMoveUp(item:T) {}

	public dynamic function onMoveDown(item:T) {}

	public dynamic function onMoveLeft(item:T) {}

	public dynamic function onMoveRight(item:T) {}

	public dynamic function onSelect(item:T) {}

	public dynamic function onActive(item:T) {}

	public dynamic function onInactive(item:T) {}

	public function select()
	{
		if (current != null)
		{
			current.onSelect();
			onSelect(current);
		}
	}

	public function update(frame:Frame)
	{
		if (list == null)
			return;

		for (option in list)
		{
			option.update(frame);
		}
	}

	private function getx(i:Int)
	{
		return i % cols;
	}

	private function gety(i:Int)
	{
		return Math.floor(i / cols);
	}

	inline function set_index(val:Int)
	{
		if (current != null)
		{
			current.onInactive();
			onInactive(current);
		}

		index = val;

		if (current != null)
		{
			current.onActive();
			onActive(current);
		}

		return index;
	}

	inline function get_current()
	{
		return list[index];
	}

	inline function get_x()
	{
		return cols > 1 ? index % cols : 0;
	}

	inline function get_y()
	{
		return cols > 1 ? Math.floor(index / cols) : index;
	}
}