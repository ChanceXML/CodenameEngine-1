package mobile.controls;

import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.ui.FlxButton;
import flixel.input.keyboard.FlxKey;
import openfl.events.KeyboardEvent;
import openfl.Lib;
import haxe.Timer;

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

			Timer.delay(function() {
				triggerKey(key, false);
			}, 50);
		};

		btn.onUp.callback = function()
		{
			btn.alpha = 0.5;
			Timer.delay(function() {
				isPressed = false;
			}, 100);
		};
        
		btn.onOut.callback = function()
		{
			btn.alpha = 0.5;
			isPressed = false;
		};

		add(btn);
	}

	function createDpad(type:Int)
	{
		switch(type)
		{
			case UP_DOWN:
				createButton(32.5, 432.5, "UP", FlxKey.UP);
				createButton(32.5, 582.5, "DOWN", FlxKey.DOWN);

			case LEFT_RIGHT:
				createButton(32.5, 582.5, "LEFT", FlxKey.LEFT);
				createButton(177.5, 582.5, "RIGHT", FlxKey.RIGHT);

			case FULL:
				createButton(137.5, 387.5, "UP", FlxKey.UP);
				createButton(22.5, 482.5, "LEFT", FlxKey.LEFT);
				createButton(257.5, 482.5, "RIGHT", FlxKey.RIGHT);
				createButton(137.5, 592.5, "DOWN", FlxKey.DOWN);
		}
	}

	function createActions(type:Int)
	{
		switch(type)
		{
			case NONE:

			case A_B:
				createButton(982.5, 582.5, "A", FlxKey.ENTER);
				createButton(1132.5, 582.5, "B", FlxKey.BACKSPACE);

			case A_B_X_Y:
				createButton(982.5, 432.5, "Y", FlxKey.TAB);
				createButton(1135.5, 432.5, "X", FlxKey.SEVEN);
				createButton(982.5, 582.5, "A", FlxKey.ENTER);
				createButton(1132.5, 582.5, "B", FlxKey.BACKSPACE);
		}
	}

	function triggerKey(key:FlxKey, pressed:Bool)
	{
		var eventType = pressed ? KeyboardEvent.KEY_DOWN : KeyboardEvent.KEY_UP;
		var fakeEvent = new KeyboardEvent(eventType, true, false, 0, key);
		Lib.current.stage.dispatchEvent(fakeEvent);
	}
		}
