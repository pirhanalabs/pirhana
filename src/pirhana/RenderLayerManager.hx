package pirhana;

enum RenderLayerType
{
	Background;
	Ground;
	Objects;
	Actors;
	Fx;
	Overlay;
	Hud;
	Popup;
}

class RenderLayerManager
{
	public var ob(default, null):h2d.Layers;
	public var scroller(default, null):h2d.Layers;
	public var screen(default, null):h2d.Layers;

	/**
		Used to apply camera effects on scroller.
	**/
	@:allow(pirhana.Camera)
	private var cameraEffects(default, null):h2d.Object;

	private var scrollerFix:h2d.Object;
	private var cameraEffectsPlacer:h2d.Object;

	private var scrollerCount = 0;
	private var screenCount = 0;

	private var layers:Map<RenderLayerType, RenderLayer>;

	public function new()
	{
		layers = new Map();
		ob = new h2d.Layers();
		cameraEffectsPlacer = new h2d.Object(ob);
		cameraEffects = new h2d.Object(cameraEffectsPlacer);
		scrollerFix = new h2d.Object(cameraEffects);
		scroller = new h2d.Layers(scrollerFix);
		screen = new h2d.Layers(ob);

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

	private function createLayer(type:RenderLayerType, space:RenderLayer.RenderLayerSpace)
	{
		var layer = new RenderLayer(space);
		switch (layer.space)
		{
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
	public function render(layer:RenderLayerType, ob:h2d.Object)
	{
		layers.get(layer).ob.addChild(ob);
	}

	/**
		Clears an entire render layer.
	**/
	public function clear(layer:RenderLayerType)
	{
		layers.get(layer).ob.removeChildren();
	}

	/**
		Clears all render layer.
	**/
	public function clearAll()
	{
		for (id => layer in layers)
		{
			layer.ob.removeChildren();
		}
	}

	public function ysort(layer:RenderLayerType)
	{
		layers.get(layer).ob.ysort(0);
	}
}
