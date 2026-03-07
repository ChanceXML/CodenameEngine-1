package mobile.controls;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import funkin.mobile.backend.TouchInput;

class Hitbox extends FlxSpriteGroup {
	public var hitboxes:Array<FlxSprite>;
	public var hitboxHint:FlxSprite;

	public function new(hitboxHintPath:String, width:Float, height:Float) {
		super();
		hitboxes = [];
		createHitboxes(width, height);
		addHint(hitboxHintPath, width, height);
	}

	private function createHitboxes(width:Float, height:Float) {
		var colors = [FlxColor.RED, FlxColor.BLUE, FlxColor.GREEN, FlxColor.YELLOW];
		for (i in 0...4) {
			var hb = new FlxSprite(i * width, 0);
			hb.makeGraphic(width, height, colors[i]);
			hb.alpha = 0; // invisible by default
			hitboxes.push(hb);
			add(hb);
		}
	}

	private function addHint(path:String, width:Float, height:Float) {
		hitboxHint = new FlxSprite(0, 0, path);
		hitboxHint.scale.set(width / hitboxHint.width, height / hitboxHint.height);
		add(hitboxHint);
	}

	public function updateHitboxes():Void {
		for (i in 0...hitboxes.length) {
			var hb = hitboxes[i];
			if (TouchInput.pressed(hb)) hb.alpha = 0.25;
			else hb.alpha = 0;
		}
	}
}
