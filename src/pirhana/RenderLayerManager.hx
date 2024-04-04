package pirhana;

enum RenderLayerType {
	Background;
	Ground;
	Objects;
	Actors;
	Fx;
	Overlay;
	Hud;
	Popup;
}

class RenderLayerManager {
	public var ob(default, null):h2d.Layers;
	public var scroller(default, null):h2d.Layers;
	public var screen(default, null):h2d.Layers;

	private var borders:Array<h2d.Bitmap> = [];

	/**
		Used to apply camera effects on scroller.
	**/
	@:allow(pirhana.Camera)
	private var cameraEffects(default, null):h2d.Object;

	private var scrollerFix:h2d.Object;
	private var cameraEffectsPlacer:h2d.Object;
	private var overlay:h2d.Object;

	private var scrollerCount = 0;
	private var screenCount = 0;

	public var layers:Map<RenderLayerType, RenderLayer>;

	public function new() {
		layers = new Map();
		ob = new h2d.Layers();

		cameraEffectsPlacer = new h2d.Object(ob);
		cameraEffects = new h2d.Object(cameraEffectsPlacer);
		scrollerFix = new h2d.Object(cameraEffects);
		scroller = new h2d.Layers(scrollerFix);
		screen = new h2d.Layers(ob);

		var tile = h2d.Tile.fromColor(0, 1, 1, 1);
		for (i in 0...4) {
			var b = new h2d.Bitmap(tile, ob);
			borders.push(b);
		}

		cameraEffectsPlacer.x = Application.VIEW_WID_2;
		cameraEffectsPlacer.y = Application.VIEW_HEI_2;
		scrollerFix.x = -Application.VIEW_WID_2;
		scrollerFix.y = -Application.VIEW_HEI_2;

		createLayer(Background, World);
		createLayer(Ground, World);
		createLayer(Objects, World);
		createLayer(Actors, World);
		createLayer(Overlay, World);
		createLayer(Hud, Screen);
		createLayer(Popup, Screen);
	}

	private function createLayer(type:RenderLayerType, space:RenderLayer.RenderLayerSpace) {
		var layer = new RenderLayer(space);
		switch (layer.space) {
			case World:
				scroller.add(layer.ob, scrollerCount++);
			case Screen:
				screen.add(layer.ob, screenCount++);
		}
		layers.set(type, layer);
	}

	/**
		Renders a specified object on a given render layer.
	**/
	public function render(layer:RenderLayerType, ob:h2d.Object) {
		layers.get(layer).ob.addChild(ob);
	}

	/**
		Clears an entire render layer.
	**/
	public function clear(layer:RenderLayerType) {
		layers.get(layer).ob.removeChildren();
	}

	/**
		Clears all render layer.
	**/
	public function clearAll() {
		for (id => layer in layers) {
			layer.ob.removeChildren();
		}
	}

	public function ysort(layer:RenderLayerType) {
		layers.get(layer).ob.ysort(0);
	}

	@:allow(pirhana.Game)
	private function updateBorders() {
		// top border
		borders[0].width = Game.instance.window.width;
		borders[0].height = Application.OFFSET_Y * 0.5;
		// bottom border
		borders[1].width = Game.instance.window.width;
		borders[1].height = Application.OFFSET_Y * 0.5;
		borders[1].y = Game.instance.window.height - (Application.OFFSET_Y * 0.5);
		// left border
		borders[2].width = Application.OFFSET_X * 0.5;
		borders[2].height = Game.instance.window.height;
		// right border
		borders[3].width = Application.OFFSET_X * 0.5;
		borders[3].height = Game.instance.window.height;
		borders[3].x = Game.instance.window.width - (Application.OFFSET_X * 0.5);

		// positioning
		scroller.scaleX = Application.VIEW_SCALE;
		scroller.scaleY = Application.VIEW_SCALE;
		screen.scaleX = Application.VIEW_SCALE;
		screen.scaleY = Application.VIEW_SCALE;
		screen.x = Application.OFFSET_X * 0.5;
		screen.y = Application.OFFSET_Y * 0.5;

		cameraEffectsPlacer.x = Application.VIEW_WID_2 * Application.VIEW_SCALE + Application.OFFSET_X * 0.5;
		cameraEffectsPlacer.y = Application.VIEW_HEI_2 * Application.VIEW_SCALE + Application.OFFSET_Y * 0.5;
		scrollerFix.x = -Application.VIEW_WID_2 * Application.VIEW_SCALE;
		scrollerFix.y = -Application.VIEW_HEI_2 * Application.VIEW_SCALE;
	}
}
