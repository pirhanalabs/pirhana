package pirhana.utils;

using pirhana.extensions.IntExtension;

interface IOptionList {
	public function getCurrent():OptionListItem;
	public function moveUp():Bool;
	public function moveDown():Bool;
	public function moveLeft():Bool;
	public function moveRight():Bool;
	public function select():Void;
	public function canMove(dir:pirhana.utils.Direction):Bool;
}

interface OptionListItem {
	var x(default, set):Float;
	var y(default, set):Float;
	function onActive():Void;
	function onInactive():Void;
	function onSelect():Void;
	function update(frame:Frame):Void;
}

class OptionList<T:OptionListItem> implements IOptionList {
	public var warp:Bool = false;

	public var list:Array<T>;
	public var current(get, never):T;

	private var cols(default, null):Int;
	private var rows(default, null):Int;

	private var index(default, set):Int;

	private var x(get, never):Int;
	private var y(get, never):Int;

	public function new(cols:Int = 1, rows:Int = 0) {
		this.cols = cols;
		this.rows = rows;
	}

	public function setOptions(list:Array<T>, index:Int = 0) {
		this.list = list;

		for (i in 0...list.length) {
			onAdded(list[i], getx(i), gety(i));
		}

		this.index = index;
	}

	public function getCurrent() {
		return current;
	}

	public function moveUp() {
		var old = index;
		delta(0, -1, onMoveUp);
		return index != old;
	}

	public function moveDown() {
		var old = index;
		delta(0, 1, onMoveDown);
		return index != old;
	}

	public function moveLeft() {
		var old = index;
		delta(-1, 0, onMoveLeft);
		return index != old;
	}

	public function moveRight() {
		var old = index;
		delta(1, 0, onMoveRight);
		return index != old;
	}

	function inBounds(x:Int, y:Int) {
		return x >= 0 && x < cols && y >= 0 && y < rows;
	}

	public function canMove(dir:pirhana.utils.Direction) {
		if (dir.x != 0 && dir.y != 0) {
			throw 'unsupported diagonals!';
		}
		if (warp) {
			if ((dir.x != 0 && cols > 1) || (dir.y != 0 && rows > 1)) {
				// validate the next in line is not yourself (means its alone!)
				var xx = x;
				var yy = y;
				var target:T = null;
				var cur = getCurrent();

				do {
					xx += dir.x;
					yy += dir.y;
					xx = wrapX(xx);
					yy = wrapY(yy);
					target = list[yy * cols + xx];
				} while (target == null);

				return cur != target;
			}
		}
		if (inBounds(x + dir.x, y + dir.y)) {
			if (list[(y + dir.y) * cols + x + dir.x] == null) {
				return false;
			}
			return true;
		}
		return false;
	}

	private function wrapX(x:Int):Int {
		return warp ? x.wrap(0, cols - 1) : x.clamp(0, cols - 1);
	}

	private function wrapY(y:Int):Int {
		if (rows > 0) {
			return warp ? y.wrap(0, rows - 1) : y.clamp(0, rows - 1);
		} else {
			return warp ? y.wrap(0, list.length - 1) : y.clamp(0, list.length - 1);
		}
	}

	private function delta(dx:Int, dy:Int, cb:T->Void) {
		var nx = x + dx;
		var ny = y + dy;

		ny = wrapY(ny);
		nx = wrapX(nx);

		index = ny * cols + nx;

		if (getCurrent() == null) {
			if (warp) {
				delta(dx, dy, cb);
			} else {
				delta(dx * -1, dy * -1, null);
			}

			return;
		}

		if (cb != null) {
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

	public function select() {
		if (current != null) {
			current.onSelect();
			onSelect(current);
		}
	}

	public function update(frame:Frame) {
		if (list == null)
			return;

		for (option in list) {
			option.update(frame);
		}
	}

	private function getx(i:Int) {
		return i % cols;
	}

	private function gety(i:Int) {
		return Math.floor(i / cols);
	}

	inline function set_index(val:Int) {
		if (current != null) {
			current.onInactive();
			onInactive(current);
		}

		index = val;

		if (current != null) {
			current.onActive();
			onActive(current);
		}

		return index;
	}

	inline function get_current() {
		return list[index];
	}

	inline function get_x() {
		return cols > 1 ? index % cols : 0;
	}

	inline function get_y() {
		return cols > 1 ? Math.floor(index / cols) : index;
	}
}