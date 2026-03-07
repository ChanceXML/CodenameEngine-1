package mobile.controls;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;

class HitBox extends FlxSpriteGroup {
    public var buttonLeft:HitboxButton;
    public var buttonDown:HitboxButton;
    public var buttonUp:HitboxButton;
    public var buttonRight:HitboxButton;

    public function new() {
        super();
        var w:Int = Std.int(FlxG.width / 4);
        var h:Int = Std.int(FlxG.height);

        add(buttonLeft  = new HitboxButton(0, 0, w, h, 0xFFC24B99));
        add(buttonDown  = new HitboxButton(w, 0, w, h, 0xFF00FFFF));
        add(buttonUp    = new HitboxButton(w * 2, 0, w, h, 0xFF12FA05));
        add(buttonRight = new HitboxButton(w * 3, 0, w, h, 0xFFF9393F));
        
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
        alpha = 0.0001;
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

        if (isPressed && !_wasPressed && onDown.callback != null) onDown.callback();
        if (!isPressed && _wasPressed && onUp.callback != null) onUp.callback();

        alpha = isPressed ? 0.25 : 0.0001;

        super.update(elapsed);
    }
}

typedef HitboxCallback = {
    var callback:Void->Void;
}
