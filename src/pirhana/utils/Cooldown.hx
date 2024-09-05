package pirhana.utils;

private class CooldownItem
{
	public var id:String;
	public var cur:Float;
	public var max:Float;
	public var cb:Void->Void;
	public var upd:Float->Void;
	public var pause:Bool;
	public var onDone:CooldownItem;
	private var fps:Int;

	public function new(id, frames, upd, cb, fps = 60)
	{
		this.id = id;
		this.cur = 0;
		this.max = frames;
		this.cb = cb;
		this.upd = upd;
		this.fps = fps;
		pause = false;
	}

	public function thenS(id:String, seconds:Float, upd:Float->Void, cb:Void->Void){
		return thenF(id, seconds * fps, upd, cb);
	}

	public function thenF(id:String, frames:Float, upd:Float->Void, cb:Void->Void){
		onDone = new CooldownItem(id, frames, upd, cb, fps);
		return onDone;
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
	public final FPS:Int;

	private var cds:Map<String, CooldownItem>;

	public function new(fps:Int)
	{
		FPS = fps;
		cds = new Map();
	}

	public function createF(id:String, frames:Int, ?upd:Float->Void, ?cb:Void->Void)
	{
		var cd = new CooldownItem(id, frames, upd, cb, FPS);
		cds.set(id, cd);
		return cd;
	}

	public function createS(id:String, seconds:Float, ?upd:Float->Void, ?cb:Void->Void)
	{
		return createF(id, Math.floor(seconds * FPS), upd, cb);
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

	public function addS(id:String, seconds:Float)
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

	public function update(frame:Frame)
	{
		for (id => cd in cds)
		{
			if (cd.isCompleted())
			{
				cds.remove(id);
				if (cd.onDone != null){
					cds.set(cd.onDone.id, cd.onDone);
				}
				if (cd.cb != null){
					cd.cb();
				}
			}
			if (cd.pause || cd.max < 0)
			{
				continue;
			}
			cd.cur += Math.pow(1, frame.tmod);
		}
	}

	public function postupdate(){
		for (id=>cd in cds){
			if (cd.upd != null){
				cd.upd(cd.getRatio());
			}
		}
	}
}