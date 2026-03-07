package mobile.controls;

#if android
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.input.keyboard.FlxKey;
import funkins.backend.TurboControls;
import funkins.game.PlayState;

class Hitbox extends FlxGroup
{
    var hintBG:FlxSprite;
    var leftRect:FlxSprite;
    var downRect:FlxSprite;
    var upRect:FlxSprite;
    var rightRect:FlxSprite;

    public var leftTurbo:TurboControls;
    public var downTurbo:TurboControls;
    public var upTurbo:TurboControls;
    public var rightTurbo:TurboControls;

    public function new()
    {
        super();

        var w = FlxG.width / 4;
        var h = FlxG.height;

        hintBG = new FlxSprite(0, 0, "assets/images/mobile/hitbox_hint.png");
        hintBG.setGraphicSize(FlxG.width, FlxG.height);
        add(hintBG);

        leftRect  = makeRect(0, 0, w, h, 0x80FF0000);
        downRect  = makeRect(w, 0, w, h, 0x8000FFFF);
        upRect    = makeRect(w*2, 0, w, h, 0x8000FF00);
        rightRect = makeRect(w*3, 0, w, h, 0x80FFFF00);

        add(leftRect);
        add(downRect);
        add(upRect);
        add(rightRect);

        leftTurbo  = new TurboControls([FlxKey.LEFT]);
        downTurbo  = new TurboControls([FlxKey.DOWN]);
        upTurbo    = new TurboControls([FlxKey.UP]);
        rightTurbo = new TurboControls([FlxKey.RIGHT]);
    }

    function makeRect(x:Float, y:Float, w:Float, h:Float, color:Int):FlxSprite
    {
        var s = new FlxSprite(x, y);
        s.makeGraphic(Std.int(w), Std.int(h), color);
        s.alpha = 0;
        s.immovable = true;
        s.moves = false;
        return s;
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        leftRect.alpha = 0;
        downRect.alpha = 0;
        upRect.alpha = 0;
        rightRect.alpha = 0;

        for (touch in FlxG.touches.list)
        {
            if (!touch.pressed) continue;

            var pos:FlxPoint = touch.getScreenPosition();

            if (leftRect.overlapsPoint(pos))
            {
                leftRect.alpha = 0.2;
                leftTurbo.update(elapsed);
                if (leftTurbo.activated) PlayState.noteLeft();
            }

            if (downRect.overlapsPoint(pos))
            {
                downRect.alpha = 0.2;
                downTurbo.update(elapsed);
                if (downTurbo.activated) PlayState.noteDown();
            }

            if (upRect.overlapsPoint(pos))
            {
                upRect.alpha = 0.2;
                upTurbo.update(elapsed);
                if (upTurbo.activated) PlayState.noteUp();
            }

            if (rightRect.overlapsPoint(pos))
            {
                rightRect.alpha = 0.2;
                rightTurbo.update(elapsed);
                if (rightTurbo.activated) PlayState.noteRight();
            }
        }
    }
}
#end
