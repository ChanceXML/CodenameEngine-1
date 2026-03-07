package mobile.controls;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import flixel.FlxBasic;
import funkin.mobile.backend.TouchInput;

class Hitbox extends FlxSpriteGroup {
    public var notes:Array<FlxSprite> = [];
    public var hint:FlxSprite;

    public function new(hintPath:String, width:Float, height:Float) {
        super();

        // Create static hint
        hint = new FlxSprite(0, 0, hintPath);
        hint.scrollFactor.set();
        add(hint);

        // Create 4 hitboxes for notes (you can expand if needed)
        for (i in 0...4) {
            var hb = new FlxSprite(i * width, 0);
            hb.makeGraphic(width, height, FlxColor.WHITE);
            hb.alpha = 0; // invisible by default
            hb.scrollFactor.set();
            add(hb);
            notes.push(hb);
        }
    }

    public function updateHitboxes():Void {
        for (i in 0...notes.length) {
            var hb = notes[i];
            if (TouchInput.pressed(hb)) {
                hb.alpha = 0.25;
                if (PlayState.instance != null) PlayState.instance.hitNote(i);
            } else {
                hb.alpha = 0;
            }
        }
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);
        updateHitboxes();
    }
}
