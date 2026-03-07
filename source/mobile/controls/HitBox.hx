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
        var h:Int = FlxG.height;

        add(buttonLeft  = new HitboxButton(0, 0, w, h, 0xFFC24B99));
        add(buttonDown  = new HitboxButton(w, 0, w, h, 0xFF00FFFF));
        add(buttonUp    = new HitboxButton(w * 2, 0, w, h, 0xFF12FA05));
        add(buttonRight = new HitboxButton(w * 3, 0, w, h, 0xFFF9393F));
        
        scrollFactor.set();
    }
}

class HitboxButton extends FlxSprite {
    public var pressed:Bool = false;
    public var justPressed:Bool = false;
    public var justReleased:Bool = false;
    private var _wasPressed:Bool = false;

    public function new(x:Float, y:Float, width:Int, height:Int, color:FlxColor) {
        super(x, y);
        makeGraphic(width, height, color);
        alpha = 0.0001;
    }

    override public function update(elapsed:Float) {
        _wasPressed = pressed;
        pressed = false;

        #if FLX_TOUCH
        for (touch in FlxG.touches.list) {
            if (touch.overlaps(this) && touch.pressed) {
                pressed = true;
            }
        }
        #end

        #if FLX_MOUSE
        if (FlxG.mouse.overlaps(this) && FlxG.mouse.pressed) {
            pressed = true;
        }
        #end

        justPressed = (pressed && !_wasPressed);
        justReleased = (!pressed && _wasPressed);

        if (pressed) 
            alpha = 0.25;
        else 
            alpha = 0.0001;

        super.update(elapsed);
    }
}
