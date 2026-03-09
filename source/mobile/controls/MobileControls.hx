package mobile.controls;

import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.ui.FlxButton;

class MobileControls extends FlxGroup
{
	public static var left:Bool = false;
	public static var right:Bool = false;
	public static var up:Bool = false;
	public static var down:Bool = false;

	public static inline var NONE:Int = -1;
	public static inline var UP_DOWN:Int = 0;
	public static inline var LEFT_RIGHT:Int = 1;
	public static inline var FULL:Int = 2;

	public function new(dpad:Int, actions:Int)
	{
		super();
		createDpad(dpad);
	}

	function createButton(x:Float, y:Float, img:String, press:Void->Void, release:Void->Void)
	{
		var btn = new FlxButton(x, y);
		btn.loadGraphic("assets/images/mobile/buttons/" + img + ".png");

		btn.onDown.callback = press;
		btn.onUp.callback = release;
		btn.onOut.callback = release;

		add(btn);
	}

	function createDpad(type:Int)
	{
		switch(type)
		{
			case UP_DOWN:

				createButton(80, FlxG.height - 260, "UP",
					function(){ up = true; },
					function(){ up = false; }
				);

				createButton(80, FlxG.height - 140, "DOWN",
					function(){ down = true; },
					function(){ down = false; }
				);

			case LEFT_RIGHT:

				createButton(20, FlxG.height - 180, "LEFT",
					function(){ left = true; },
					function(){ left = false; }
				);

				createButton(140, FlxG.height - 180, "RIGHT",
					function(){ right = true; },
					function(){ right = false; }
				);

			case FULL:

				createButton(80, FlxG.height - 260, "UP",
					function(){ up = true; },
					function(){ up = false; }
				);

				createButton(20, FlxG.height - 180, "LEFT",
					function(){ left = true; },
					function(){ left = false; }
				);

				createButton(140, FlxG.height - 180, "RIGHT",
					function(){ right = true; },
					function(){ right = false; }
				);

				createButton(80, FlxG.height - 100, "DOWN",
					function(){ down = true; },
					function(){ down = false; }
				);
		}
	}
		}
