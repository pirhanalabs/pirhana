package pirhana;

class AssetBuilder
{

	public static function subTilesheet(sheet:h2d.Tile, tw:Int, th:Int, dx:Int = 0, dy:Int = 0)
	{
		return [
			for (y in 0...Math.floor(sheet.height / th))
				for (x in 0...Math.floor(sheet.width / tw))
					sheet.sub(x * tw, y * th, tw, th, dx, dy)
		];
	}

	public static function makeAnim(tiles:Array<h2d.Tile>, frames:Array<Int>)
	{
		return [
			for (frame in frames)
				tiles[frame]
		];
	}
}
