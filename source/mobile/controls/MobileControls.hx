package mobile.controls;

import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.ui.FlxButton;
import flixel.input.keyboard.FlxKey;
import openfl.events.KeyboardEvent;
import openfl.Lib;
import flixel.FlxCamera;

class MobileControls extends FlxGroup
{
    public var buttonCam:FlxCamera;

    public static inline var NONE:Int = -1;
    public static inline var UP_DOWN:Int = 0;
    public static inline var LEFT_RIGHT:Int = 1;
    public static inline var FULL:Int = 2;

    public static inline var A_B:Int = 0;
    public static inline var A_B_X_Y:Int = 1;

    public function new(dpad:Int, actions:Int)
    {
        super();

        buttonCam = new FlxCamera(0, 0, FlxG.width, FlxG.height);
        buttonCam.scroll.set(0,0);
        buttonCam.bgColor = 0x00000000;

        if(!FlxG.cameras.list.contains(buttonCam))
            FlxG.cameras.add(buttonCam);

        FlxCamera.defaultCameras = [FlxG.camera];

        createDpad(dpad);
        createActions(actions);
    }

    function createButton(x:Float, y:Float, img:String, key:Int)
    {
        var btn = new FlxButton(x, y);
        btn.loadGraphic("assets/images/mobile/buttons/" + img + ".png");
        btn.alpha = 0.5;

        btn.cameras = [buttonCam];

        var isPressed:Bool = false;
        btn.onDown.callback = function()
        {
            if(isPressed) return;
            isPressed = true;
            btn.alpha = 0.9;
            triggerKey(key, true);
            triggerKey(key, false);
        };

        btn.onUp.callback = function()
        {
            isPressed = false;
            btn.alpha = 0.5;
        };

        btn.onOut.callback = function()
        {
            isPressed = false;
            btn.alpha = 0.5;
        };

        add(btn);
    }

    function createDpad(type:Int)
    {
        switch(type)
        {
            case UP_DOWN:
                createButton(-545, 135, "UP", FlxKey.UP);
                createButton(-545, 285, "DOWN", FlxKey.DOWN);

            case LEFT_RIGHT:
                createButton(-545, 285, "LEFT", FlxKey.LEFT);
                createButton(-400, 285, "RIGHT", FlxKey.RIGHT);

            case FULL:
                createButton(-440, 60, "UP", FlxKey.UP);
                createButton(-555, 155, "LEFT", FlxKey.LEFT);
                createButton(-320, 155, "RIGHT", FlxKey.RIGHT);
                createButton(-440, 295, "DOWN", FlxKey.DOWN);
        }
    }

    function createActions(type:Int)
    {
        switch(type)
        {
            case NONE:

            case A_B:
                createButton(375, 285, "A", FlxKey.ENTER);
                createButton(525, 285, "B", FlxKey.BACKSPACE);

            case A_B_X_Y:
                createButton(375, 135, "Y", FlxKey.TAB);
                createButton(525, 135, "X", FlxKey.SEVEN);
                createButton(375, 285, "A", FlxKey.ENTER);
                createButton(525, 285, "B", FlxKey.BACKSPACE);
        }
    }

    function triggerKey(key:Int, pressed:Bool)
    {
        var eventType = pressed ? KeyboardEvent.KEY_DOWN : KeyboardEvent.KEY_UP;
        var fakeEvent = new KeyboardEvent(eventType, true, false, 0, key);
        Lib.current.stage.dispatchEvent(fakeEvent);
    }
		}
