package pirhana.utils;

private class CooldownItem
{
	public var id:String;
	public var cur:Float;
	public var max:Float;
	public var cb:Void->Void;
	public var pause:Bool;

	public function new(id, frames, cb)
	{
		this.id = id;
		this.cur = 0;
		this.max = frames;
		this.cb = cb;
		pause = false;
	}

	public function getRatio():Float
	{
		if (max == -1)
		{
			return 1; // always return full if infinite
		}
		return cur / max;
	}

	public function isCompleted()
	{
		return getRatio() == 1;
	}
}

class Cooldown
{
	private final FPS:Int;

	private var cds:Map<String, CooldownItem>;

	public function new(fps:Int)
	{
		FPS = fps;
		cds = new Map();
	}

	public function createF(id:String, frames:Int, ?cb:Void->Void)
	{
		var cd = new CooldownItem(id, frames, cb == null ? emptycb : cb);
		cds.set(id, cd);
		return cd;
	}

	public function createS(id:String, seconds:Float, ?cb:Void->Void)
	{
		return createF(id, Math.floor(seconds * FPS), cb);
	}

	public function has(id:String)
	{
		return cds.exists(id);
	}

	public function getRatio(id:String):Float
	{
		var cd = cds.get(id);
		if (cd == null || cd.max == -1)
		{
			return 0;
		}
		return cd.getRatio();
	}

	public function addF(id:String, frames:Int)
	{
		if (has(id))
		{
			var cd = cds.get(id);
			cd.max += frames;
		}
	}

	public function addS(id:String, seconds:Float, ratio:Bool)
	{
		if (has(id))
		{
			cds.get(id).max += Math.floor(seconds * FPS);
		}
	}

	public function reset(id:String)
	{
		if (has(id))
		{
			cds.get(id).cur = 0;
		}
	}

	public function resetAll()
	{
		for (id => cd in cds)
		{
			cd.cur = 0;
		}
	}

	public function pause(id:String)
	{
		if (has(id))
		{
			cds.get(id).pause = true;
		}
	}

	public function pauseAll()
	{
		for (id => cd in cds)
		{
			cd.pause = true;
		}
	}

	public function resume(id:String)
	{
		if (has(id))
		{
			cds.get(id).pause = false;
		}
	}

	public function resumeAll()
	{
		for (id => cd in cds)
		{
			cd.pause = false;
		}
	}

	public function remove(id:String)
	{
		cds.remove(id);
	}

	public function clear()
	{
		cds.clear();
	}

	private final function emptycb() {}

	public function update(frame:Frame)
	{
		for (id => cd in cds)
		{
			if (cd.isCompleted())
			{
				cd.cb();
				cds.remove(id);
			}

			if (cd.pause || cd.max < 0)
			{
				continue;
			}

			cd.cur += Math.pow(1, frame.tmod);
		}
	}
}