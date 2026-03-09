package mobile.controls;

import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.ui.FlxButton;
import flixel.input.keyboard.FlxKey;
import openfl.events.KeyboardEvent;
import openfl.Lib;

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

		var isPressed:Bool = false;

		btn.onDown.callback = function()
		{
			if (isPressed) return;
			isPressed = true;

			btn.alpha = 0.9;
			triggerKey(key, true);
		};

		btn.onUp.callback = function()
		{
			if (!isPressed) return;
			isPressed = false;

			btn.alpha = 0.5;
			triggerKey(key, false);
		};
        
		btn.onOut.callback = function()
		{
			if (isPressed)
			{
				isPressed = false;
				btn.alpha = 0.5;
				triggerKey(key, false);
			}
		};

		add(btn);
	}

	function createDpad(type:Int)
{
	switch(type)
	{
		case UP_DOWN:
			createButton(-607.5, 72.5, "UP", FlxKey.UP);
			createButton(-607.5, 222.5, "DOWN", FlxKey.DOWN);

		case LEFT_RIGHT:
			createButton(-607.5, 222.5, "LEFT", FlxKey.LEFT);
			createButton(-462.5, 222.5, "RIGHT", FlxKey.RIGHT);

		case FULL:
			createButton(-502.5, -2.5, "UP", FlxKey.UP);
			createButton(-617.5, 92.5, "LEFT", FlxKey.LEFT);
			createButton(-382.5, 92.5, "RIGHT", FlxKey.RIGHT);
			createButton(-502.5, 232.5, "DOWN", FlxKey.DOWN);
	}
}

function createActions(type:Int)
{
	switch(type)
	{
		case NONE:

		case A_B:
			createButton(312.5, 222.5, "A", FlxKey.ENTER);
			createButton(462.5, 222.5, "B", FlxKey.BACKSPACE);

		case A_B_X_Y:
			createButton(312.5, 72.5, "Y", FlxKey.TAB);
			createButton(462.5, 72.5, "X", FlxKey.SEVEN);
			createButton(312.5, 222.5, "A", FlxKey.ENTER);
			createButton(462.5, 222.5, "B", FlxKey.BACKSPACE);
	}
	}

	function triggerKey(key:FlxKey, pressed:Bool)
	{
		var eventType = pressed ? KeyboardEvent.KEY_DOWN : KeyboardEvent.KEY_UP;
		var fakeEvent = new KeyboardEvent(eventType, true, false, 0, key);
		Lib.current.stage.dispatchEvent(fakeEvent);
	}
		}
