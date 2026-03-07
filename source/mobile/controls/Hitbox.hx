package mobile.controls;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import funkin.mobile.controls.TouchInput;
import funkin.game.PlayState;

class HitBox extends FlxSpriteGroup {

    public var hitboxHint:FlxSprite;
    public var hitboxes:Array<FlxSprite> = [];

    public function new() {
        super();

        hitboxHint = new FlxSprite(FlxG.width / 2 - 100, FlxG.height - 150);
        hitboxHint.loadGraphic("assets/images/hitbox_hint.png");
        add(hitboxHint);

        var width:Float = FlxG.width / 4;
        var height:Float = FlxG.height;
        for (i in 0...4) {
            var hb = new FlxSprite(i * width, 0, width, height);
            hb.makeGraphic(width, height, FlxColor.WHITE);
            hb.alpha = 0;
            hitboxes.push(hb);
            add(hb);
        }
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);

        for (i in 0...hitboxes.length) {
            var hb = hitboxes[i];
            if (TouchInput.pressed(hb)) {
                hb.alpha = 0.25;
                if (PlayState.instance != null) PlayState.instance.hitNote(i);
            } else {
                hb.alpha = 0;
            }
        }
    }
}
