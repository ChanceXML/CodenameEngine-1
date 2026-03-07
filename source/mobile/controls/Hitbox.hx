package mobile.controls;

#if android
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import funkin.backend.TurboControls;
import funkin.backend.system.Control;
import funkin.options.PlayerSettings;
import funkin.game.PlayState;

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

        leftTurbo  = new TurboControls([PlayerSettings.solo.controls.getActionFromControl(Control.LEFT)]);
        downTurbo  = new TurboControls([PlayerSettings.solo.controls.getActionFromControl(Control.DOWN)]);
        upTurbo    = new TurboControls([PlayerSettings.solo.controls.getActionFromControl(Control.UP)]);
        rightTurbo = new TurboControls([PlayerSettings.solo.controls.getActionFromControl(Control.RIGHT)]);
    }

    function makeRect(x:Float, y:Float, w:Float, h:Float, color:Int):FlxSprite
    {
        var s = new FlxSprite(x, y);
        s.makeGraphic(Std.int(w), Std.int(h), color);
        s.alpha = 0.2;
        s.immovable = true;
        s.moves = false;
        return s;
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        leftRect.alpha = 0.2;
        downRect.alpha = 0.2;
        upRect.alpha = 0.2;
        rightRect.alpha = 0.2;

        for (touch in FlxG.touches.list)
        {
            if (!touch.pressed) continue;

            var pos:FlxPoint = touch.getScreenPosition();

            if (leftRect.overlapsPoint(pos))
            {
                leftTurbo.update(elapsed);
                if (leftTurbo.activated) PlayState.instance.triggerNoteSafe(0);
            }

            if (downRect.overlapsPoint(pos))
            {
                downTurbo.update(elapsed);
                if (downTurbo.activated) PlayState.instance.triggerNoteSafe(1);
            }

            if (upRect.overlapsPoint(pos))
            {
                upTurbo.update(elapsed);
                if (upTurbo.activated) PlayState.instance.triggerNoteSafe(2);
            }

            if (rightRect.overlapsPoint(pos))
            {
                rightTurbo.update(elapsed);
                if (rightTurbo.activated) PlayState.instance.triggerNoteSafe(3);
            }
        }
    }
}
#end
