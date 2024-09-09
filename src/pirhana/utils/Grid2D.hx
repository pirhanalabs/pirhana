package pirhana.utils;

class Grid2D<T>{

      public var wid (default, null) : Int;
      public var hei (default, null) : Int;

      var grid : Array<T>;

      public function new(wid:Int, hei:Int, valfn:(x:Int, y:Int)->T){
            this.wid = wid;
            this.hei = hei;

            this.grid = [
                  for (y in 0 ... hei)
                  for (x in 0 ... wid)
                        valfn(x, y)
            ];
      }

      public function each(fn:T->Void) {
		for (element in grid) {
			fn(element);
		}
	}

      public function inbounds(x:Int, y:Int){
            return x >= 0 && y >= 0 && x < wid && y < hei;
      }

      public function set(x:Int, y:Int, val:T){
            if (!inbounds(x, y)) return;
            this.grid[convert(x, y)] = val;
      }

      public function get(x:Int, y:Int){
            if (!inbounds(x, y)) return null;
            return this.grid[convert(x, y)];
      }

      inline function convert(x:Int, y:Int){
            return y * wid + x;
      }
}