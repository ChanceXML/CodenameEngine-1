package mobile.controls;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import funkin.options.Options;

class HitBox extends FlxSpriteGroup {
    public var buttonLeft:HitboxButton;
    public var buttonDown:HitboxButton;
    public var buttonUp:HitboxButton;
    public var buttonRight:HitboxButton;

    public function new() {
        super();

        var w:Int = 320; 
        var h:Int = 720;

        add(buttonLeft  = new HitboxButton(0, 0, w, h, 0xFFC24B99));
        add(buttonDown  = new HitboxButton(320, 0, w, h, 0xFF00FFFF));
        add(buttonUp    = new HitboxButton(640, 0, w, h, 0xFF12FA05));
        add(buttonRight = new HitboxButton(960, 0, w, h, 0xFFF9393F));
        
        scrollFactor.set();
    }

    public static function BACK():Bool {
        return #if android FlxG.android.justReleased.BACK #else false #end;
    }
}

class HitboxButton extends FlxSprite {
    public var onDown:HitboxCallback = {callback: null};
    public var onUp:HitboxCallback = {callback: null};
    public var onOut:HitboxCallback = {callback: null};

    public var isPressed:Bool = false;
    private var _wasPressed:Bool = false;

    public function new(x:Float, y:Float, width:Int, height:Int, color:FlxColor) {
        super(x, y);
        makeGraphic(width, height, color);
        alpha = 0.00001;
        antialiasing = false;
    }

    override public function update(elapsed:Float) {
        _wasPressed = isPressed;
        isPressed = false;

        #if FLX_TOUCH
        for (touch in FlxG.touches.list) {
            if (touch.overlaps(this) && touch.pressed) {
                isPressed = true;
                break;
            }
        }
        #end

        #if FLX_MOUSE
        if (FlxG.mouse.overlaps(this) && FlxG.mouse.pressed) isPressed = true;
        #end

         if (isPressed && !_wasPressed) {
            alpha = Options.hitboxOpacity; 
            if (onDown.callback != null) onDown.callback();
        } else if (!isPressed && _wasPressed) {
            alpha = 0.00001;
            if (onUp.callback != null) onUp.callback();
        }

        super.update(elapsed);
    }
}

typedef HitboxCallback = {
    var callback:Void->Void;
}
