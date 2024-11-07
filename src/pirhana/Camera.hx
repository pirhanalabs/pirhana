package pirhana;

import pirhana.utils.Timeout;

class Camera {
	private var game(get, never):Game;
	private var layers(get, never):RenderLayerManager;
	private var camera(get, never):h2d.Object;
	private var scroller(get, never):h2d.Layers;

	private var timeout:Timeout;

	private var bumpx:Float = 0;
	private var bumpy:Float = 0;
	private var bumpfrict:Float = 0.84;

	private var animator:pirhana.utils.Animator;

	inline function get_scroller() {
		return layers.scroller;
	}

	inline function get_camera() {
		return layers.cameraEffects;
	}

	inline function get_layers() {
		return game.layers;
	}

	inline function get_game() {
		return Game.instance;
	}

	private var shakePower:Float;

	public function new() {
		timeout = new Timeout(0);
		timeout.update();

		animator = new pirhana.utils.Animator();
	}

	public function shakeS(seconds:Float, pow = 1.0) {
		timeout = new Timeout(seconds);
		shakePower = pow;
	}

	public function bumpAngle(angle:Float, distance:Float) {
		bumpx += Math.cos(angle) * distance;
		bumpy += Math.sin(angle) * distance;
	}

	public function bump(x:Float, y:Float) {
		bumpx += x;
		bumpy += y;
	}

	@:allow(pirhana.Game)
	private function update(frame:Frame) {
		camera.x = 0;
		camera.y = 0;
		camera.rotation = 0;

		// bumps
		bumpx *= Math.pow(bumpfrict, frame.tmod);
		bumpy *= Math.pow(bumpfrict, frame.tmod);
		camera.x -= bumpx;
		camera.y -= bumpy;

		// shakes
		if (!timeout.isComplete) {
			timeout.update();
			camera.rotation = Math.sin(0.3 + frame.frames * 0.5) * (Math.PI * 0.008) * shakePower * (1 - timeout.progress);
			camera.x += Math.cos(frame.frames * 1.1) * 2.5 * shakePower * (1 - timeout.progress);
			camera.y += Math.sin(0.3 + frame.frames * 1.7) * 2.5 * shakePower * (1 - timeout.progress);
		}

		animator.update(frame);
		animator.postupdate();
	}

	var scaleModX:Float = 0;
	var scaleModY:Float = 0;

	function scaleAnim(r:Float) {
		camera.scaleX = Tween.lerp(1, scaleModX, Tween.spikeEaseIn(r));
		camera.scaleY = Tween.lerp(1, scaleModY, Tween.spikeEaseIn(r));
	}

	public function scale(modx:Float, mody:Float, stime:Float) {
		scaleModX = modx;
		scaleModY = mody;
		animator.add('scaleani', stime, scaleAnim, null);
	}
}
