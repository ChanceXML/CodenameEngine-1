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
    public function new(x:Float, y:Float, width:Int, height:Int, color:FlxColor) {
        super(x, y);
        makeGraphic(width, height, color);
        alpha = 0.0001;
    }

    override public function update(elapsed:Float) {
        super.update(elapsed);

        if (status == FlxButton.PRESSED) 
            alpha = 0.25;
        else 
            alpha = 0.0001;
    }
}
