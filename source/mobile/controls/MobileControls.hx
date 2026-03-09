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
        
        btn.onOut.callback = function()
        {
            if (btn.alpha == 0.9)
            {
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
			createButton(120, 460, "UP", FlxKey.UP);
			createButton(120, 600, "DOWN", FlxKey.DOWN);

		case LEFT_RIGHT:
			createButton(40, 540, "LEFT", FlxKey.LEFT);
			createButton(200, 540, "RIGHT", FlxKey.RIGHT);

		case FULL:
			createButton(120, 460, "UP", FlxKey.UP);
			createButton(40, 540, "LEFT", FlxKey.LEFT);
			createButton(200, 540, "RIGHT", FlxKey.RIGHT);
			createButton(120, 620, "DOWN", FlxKey.DOWN);
	}
}

function createActions(type:Int)
{
	switch(type)
	{
		case NONE:

		case A_B:
			createButton(1040, 560, "A", FlxKey.ENTER);
			createButton(1160, 480, "B", FlxKey.BACKSPACE);

		case A_B_X_Y:
			createButton(1040, 460, "Y", FlxKey.TAB);
			createButton(1160, 540, "X", FlxKey.SEVEN);
			createButton(1040, 620, "A", FlxKey.ENTER);
			createButton(1160, 460, "B", FlxKey.BACKSPACE);
	}
	}

	function triggerKey(key:FlxKey, pressed:Bool)
	{
		var eventType = pressed ? KeyboardEvent.KEY_DOWN : KeyboardEvent.KEY_UP;
		var fakeEvent = new KeyboardEvent(eventType, true, false, 0, key);
		Lib.current.stage.dispatchEvent(fakeEvent);
	}
		}
		
