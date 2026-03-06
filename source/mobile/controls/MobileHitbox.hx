package mobile.controls;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.FlxState;
import flixel.input.touch.FlxTouch;

class Hitbox extends FlxGroup
{
    var boxes:Array<FlxSprite>;

    public function new()
    {
        super();

        boxes = [];

        var w:Int = Std.int(FlxG.width / 4);
        var h:Int = FlxG.height;

        for (i in 0...4)
        {
            var box = new FlxSprite(i * w, 0);
            box.makeGraphic(w, h, 0xFFFFFFFF);
            box.alpha = 0.2;
            boxes.push(box);
            add(box);
        }

        var hint = new FlxSprite(0,0,"assets/images/mobile/hitbox_hint.png");
        hint.setGraphicSize(FlxG.width, FlxG.height);
        hint.updateHitbox();
        hint.alpha = 0.8;
        add(hint);
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        for (touch in FlxG.touches.list)
        {
            var pos = touch.getScreenPosition();

            if (boxes[0].overlapsPoint(pos)) FlxG.keys.press("LEFT");
            if (boxes[1].overlapsPoint(pos)) FlxG.keys.press("DOWN");
            if (boxes[2].overlapsPoint(pos)) FlxG.keys.press("UP");
            if (boxes[3].overlapsPoint(pos)) FlxG.keys.press("RIGHT");
        }
    }
}

class MobileHitbox
{
    public static function addMobileHitbox(state:FlxState, enabled:Bool)
    {
        if(enabled)
        {
            state.add(new Hitbox());
        }
    }
}
