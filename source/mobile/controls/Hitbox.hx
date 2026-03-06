package mobile.controls;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.FlxState;

class Hitbox extends FlxGroup
{
	public var boxes:Array<FlxSprite>;
	public var hint:FlxSprite;

	public function new()
	{
		super();

		boxes = [];

		var hitWidth:Int = 480;
		var hitHeight:Int = 1080;

		for (i in 0...4)
		{
			var box = new FlxSprite(i * hitWidth, 0);
			box.makeGraphic(hitWidth, hitHeight, 0x33FFFFFF);
			box.alpha = 0.2;
			box.scrollFactor.set();

			boxes.push(box);
			add(box);
		}

		hint = new FlxSprite(0,0);
		hint.loadGraphic("assets/images/mobile/hitbox_hint.png");
		hint.setGraphicSize(1280,720);
		hint.updateHitbox();
		hint.scrollFactor.set();
		add(hint);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.keys.pressed.LEFT = false;
		FlxG.keys.pressed.DOWN = false;
		FlxG.keys.pressed.UP = false;
		FlxG.keys.pressed.RIGHT = false;

		for (touch in FlxG.touches.list)
		{
			if (boxes[0].overlapsPoint(touch.screenPosition))
				FlxG.keys.pressed.LEFT = true;

			if (boxes[1].overlapsPoint(touch.screenPosition))
				FlxG.keys.pressed.DOWN = true;

			if (boxes[2].overlapsPoint(touch.screenPosition))
				FlxG.keys.pressed.UP = true;

			if (boxes[3].overlapsPoint(touch.screenPosition))
				FlxG.keys.pressed.RIGHT = true;
		}
	}
}

function addMobile(c:Class<Dynamic>)
{
	var obj = Type.createInstance(c, []);
	FlxG.state.add(obj);
}
