package mobile.controls;

import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.ui.FlxButton;

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

	function pressKey(key:String, down:Bool)
	{
		switch(key)
		{
			case "LEFT": FlxG.keys.pressed.LEFT = down;
			case "RIGHT": FlxG.keys.pressed.RIGHT = down;
			case "UP": FlxG.keys.pressed.UP = down;
			case "DOWN": FlxG.keys.pressed.DOWN = down;

			case "ACCEPT": FlxG.keys.pressed.ENTER = down;
			case "BACK": FlxG.keys.pressed.BACKSPACE = down;

			case "DEBUG": FlxG.keys.pressed.SEVEN = down;
			case "RESET": FlxG.keys.pressed.R = down;
		}
	}

	function createButton(x:Float, y:Float, img:String, key:String)
	{
		var btn = new FlxButton(x, y);
		btn.loadGraphic("assets/images/mobile/buttons/" + img + ".png");

		btn.alpha = 0.6;

		btn.onDown.callback = function()
		{
			btn.alpha = 1;
			pressKey(key, true);
		};

		btn.onUp.callback = function()
		{
			btn.alpha = 0.6;
			pressKey(key, false);
		};

		btn.onOut.callback = btn.onUp.callback;

		add(btn);
	}

	function createDpad(type:Int)
	{
		switch(type)
		{
			case UP_DOWN:

				createButton(80, FlxG.height - 260, "UP", "UP");
				createButton(80, FlxG.height - 140, "DOWN", "DOWN");

			case LEFT_RIGHT:

				createButton(20, FlxG.height - 180, "LEFT", "LEFT");
				createButton(140, FlxG.height - 180, "RIGHT", "RIGHT");

			case FULL:

				createButton(80, FlxG.height - 260, "UP", "UP");
				createButton(20, FlxG.height - 180, "LEFT", "LEFT");
				createButton(140, FlxG.height - 180, "RIGHT", "RIGHT");
				createButton(80, FlxG.height - 100, "DOWN", "DOWN");
		}
	}

	function createActions(type:Int)
	{
		switch(type)
		{
			case NONE:

			case A_B:

				createButton(FlxG.width - 200, FlxG.height - 160, "A", "ACCEPT");
				createButton(FlxG.width - 100, FlxG.height - 160, "B", "BACK");

			case A_B_X_Y:

				createButton(FlxG.width - 200, FlxG.height - 260, "Y", "RESET");
				createButton(FlxG.width - 100, FlxG.height - 260, "X", "DEBUG");
				createButton(FlxG.width - 200, FlxG.height - 140, "A", "ACCEPT");
				createButton(FlxG.width - 100, FlxG.height - 140, "B", "BACK");
		}
	}
		}
