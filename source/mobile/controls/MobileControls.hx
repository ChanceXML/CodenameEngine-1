package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.FlxCamera;

class MobileControls extends FlxGroup
{
	public static inline var NONE:Int = -1;

	public static inline var UP_DOWN:Int = 0;
	public static inline var LEFT_RIGHT:Int = 1;
	public static inline var FULL:Int = 2;

	public static inline var A_B:Int = 0;
	public static inline var A_B_X_Y:Int = 1;

	var cam:FlxCamera;

	public function new(dpad:Int, actions:Int, camera:FlxCamera)
	{
		super();
		cam = camera;

		createDpad(dpad);
		createActions(actions);
	}

	function createButton(x:Float, y:Float, img:String, key:Int)
	{
		var btn = new FlxSprite(x, y);
		btn.loadGraphic("assets/images/mobile/buttons/" + img + ".png");

		btn.scrollFactor.set();
		btn.cameras = [cam];

		btn.alpha = 0.5;

		btn.update = function(elapsed:Float)
		{
			if (FlxG.mouse.overlaps(btn) && FlxG.mouse.pressed)
			{
				btn.alpha = 0.9;
				FlxG.keys.press(key);
			}
			else
			{
				btn.alpha = 0.5;
				FlxG.keys.release(key);
			}
		};

		add(btn);
	}

	function createDpad(type:Int)
	{
		switch(type)
		{
			case UP_DOWN:

				createButton(
					80,
					FlxG.height - 260,
					"UP",
					FlxG.keys.UP
				);

				createButton(
					80,
					FlxG.height - 140,
					"DOWN",
					FlxG.keys.DOWN
				);

			case LEFT_RIGHT:

				createButton(
					20,
					FlxG.height - 180,
					"LEFT",
					FlxG.keys.LEFT
				);

				createButton(
					140,
					FlxG.height - 180,
					"RIGHT",
					FlxG.keys.RIGHT
				);

			case FULL:

				createButton(
					80,
					FlxG.height - 260,
					"UP",
					FlxG.keys.UP
				);

				createButton(
					20,
					FlxG.height - 180,
					"LEFT",
					FlxG.keys.LEFT
				);

				createButton(
					140,
					FlxG.height - 180,
					"RIGHT",
					FlxG.keys.RIGHT
				);

				createButton(
					80,
					FlxG.height - 100,
					"DOWN",
					FlxG.keys.DOWN
				);
		}
	}

	function createActions(type:Int)
	{
		switch(type)
		{
			case NONE:

			case A_B:

				createButton(
					FlxG.width - 200,
					FlxG.height - 160,
					"A",
					FlxG.keys.ENTER
				);

				createButton(
					FlxG.width - 100,
					FlxG.height - 160,
					"B",
					FlxG.keys.BACKSPACE
				);

			case A_B_X_Y:

				createButton(
					FlxG.width - 200,
					FlxG.height - 260,
					"Y",
					FlxG.keys.TAB
				);

				createButton(
					FlxG.width - 100,
					FlxG.height - 260,
					"X",
					FlxG.keys.SEVEN
				);

				createButton(
					FlxG.width - 200,
					FlxG.height - 140,
					"A",
					FlxG.keys.ENTER
				);

				createButton(
					FlxG.width - 100,
					FlxG.height - 140,
					"B",
					FlxG.keys.BACKSPACE
				);
		}
	}
		}
