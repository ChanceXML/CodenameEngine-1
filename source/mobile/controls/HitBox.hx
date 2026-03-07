package mobile.controls;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.ui.FlxButton;
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

    public static function BACK():Bool {
        return #if android FlxG.android.justReleased.BACK #else false #end;
    }

    override public function destroy() {
        super.destroy();
        buttonLeft = buttonDown = buttonUp = buttonRight = null;
    }
}

class HitboxButton extends FlxButton {
    private var _pressed:Bool = false;

    public function new(x:Float, y:Float, width:Int, height:Int, color:FlxColor) {
        super(x, y);
        makeGraphic(width, height, color);
        alpha = 0.0001;
    }

    override public function update(elapsed:Float) {
        var isCurrentlyPressed:Bool = false;

        #if FLX_TOUCH
        for (touch in FlxG.touches.list) if (touch.overlaps(this) && touch.pressed) isCurrentlyPressed = true;
        #end

        #if FLX_MOUSE
        if (FlxG.mouse.overlaps(this) && FlxG.mouse.pressed) isCurrentlyPressed = true;
        #end

        if (isCurrentlyPressed && !_pressed) {
            if (onDown != null && onDown.callback != null) onDown.callback();
        } else if (!isCurrentlyPressed && _pressed) {
            if (onUp != null && onUp.callback != null) onUp.callback();
        }

        _pressed = isCurrentlyPressed;
        alpha = _pressed ? 0.25 : 0.0001;

        super.update(elapsed);
    }
}
