package mobile.controls;

import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.ui.FlxButton;
import flixel.input.keyboard.FlxKey;
import flixel.input.keyboard.FlxKeyboard;

class MobileControls extends FlxGroup
{
	public static inline var NONE:Int = -1;

	public static inline var UP_DOWN:Int = 0;
	public static inline var LEFT_RIGHT:Int = 1;
	public static inline var FULL:Int = 2;

	public static inline var A_B:Int = 0;
	public static inline var A_B_X_Y:Int = 1;

	public function new(dpad:Int, actions:Int)
	{
		super();

		createDpad(dpad);
		createActions(actions);
	}

	function createButton(x:Float, y:Float, img:String, key:FlxKey)
	{
		var btn = new FlxButton(x, y);
		btn.loadGraphic("assets/images/mobile/buttons/" + img + ".png");

		btn.alpha = 0.5;

		btn.onDown.callback = function()
		{
			btn.alpha = 0.9;
			triggerKey(key, true);
		};

		btn.onUp.callback = function()
		{
			btn.alpha = 0.5;
			triggerKey(key, false);
		};

		add(btn);
	}

	function createDpad(type:Int)
	{
		switch(type)
		{
			case UP_DOWN:

				createButton(80, FlxG.height - 260, "UP", FlxKey.UP);
				createButton(80, FlxG.height - 140, "DOWN", FlxKey.DOWN);

			case LEFT_RIGHT:

				createButton(20, FlxG.height - 180, "LEFT", FlxKey.LEFT);
				createButton(140, FlxG.height - 180, "RIGHT", FlxKey.RIGHT);

			case FULL:

				createButton(80, FlxG.height - 260, "UP", FlxKey.UP);
				createButton(20, FlxG.height - 180, "LEFT", FlxKey.LEFT);
				createButton(140, FlxG.height - 180, "RIGHT", FlxKey.RIGHT);
				createButton(80, FlxG.height - 100, "DOWN", FlxKey.DOWN);
		}
	}

	function createActions(type:Int)
	{
		switch(type)
		{
			case NONE:

			case A_B:

				createButton(FlxG.width - 200, FlxG.height - 160, "A", FlxKey.ENTER);
				createButton(FlxG.width - 100, FlxG.height - 160, "B", FlxKey.BACKSPACE);

			case A_B_X_Y:

				createButton(FlxG.width - 200, FlxG.height - 260, "Y", FlxKey.TAB);
				createButton(FlxG.width - 100, FlxG.height - 260, "X", FlxKey.SEVEN);
				createButton(FlxG.width - 200, FlxG.height - 140, "A", FlxKey.ENTER);
				createButton(FlxG.width - 100, FlxG.height - 140, "B", FlxKey.BACKSPACE);
		}
	}

	function triggerKey(key:FlxKey, pressed:Bool)
{
	if (pressed)
		FlxG.keys._keyListMap[key] = true;
	else
		FlxG.keys._keyListMap[key] = false;
}
