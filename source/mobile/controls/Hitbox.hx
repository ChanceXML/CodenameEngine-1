package mobile.controls;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import mobile.controls.TouchInput;

class Hitbox extends FlxSpriteGroup {
    public var hitboxes:Array<FlxSprite> = [];
    public var hint:FlxSprite;

    public function new(hintPath:String = null) {
        super();

        if (hintPath != null) {
            hint = new FlxSprite(0, 0, hintPath);
            hint.width = FlxG.width;
            hint.height = FlxG.height;
            add(hint);
        }

        createHitboxes();
        scrollFactor.set();
    }

    function createHitboxes():Void {
        var width = FlxG.width / 4;
        var height = FlxG.height;

        for (i in 0...4) {
            var hb = new FlxSprite(i * width, 0);
            hb.makeGraphic(Std.int(width), Std.int(height), FlxColor.WHITE);
            hb.alpha = 0;
            add(hb);
            hitboxes.push(hb);
        }
    }

    public function updateHitboxes():Void {
        for (i in 0...hitboxes.length) {
            var hb = hitboxes[i];
            if (TouchInput.pressed(hb)) {
                hb.alpha = 0.25;
            } else {
                hb.alpha = 0;
            }
        }
    }
}
