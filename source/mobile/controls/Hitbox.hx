package mobile.controls;

import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.FlxSprite;
import flixel.math.FlxRect;
import flixel.math.FlxPoint;

class Hitbox extends FlxGroup
{
    var leftRect:FlxRect;
    var downRect:FlxRect;
    var upRect:FlxRect;
    var rightRect:FlxRect;

    var leftHint:FlxSprite;
    var downHint:FlxSprite;
    var upHint:FlxSprite;
    var rightHint:FlxSprite;

    public static var LEFT:Bool = false;
    public static var DOWN:Bool = false;
    public static var UP:Bool = false;
    public static var RIGHT:Bool = false;

    public function new()
    {
        super();

        var w = FlxG.width / 4;

        leftRect  = new FlxRect(0, 0, w, FlxG.height);
        downRect  = new FlxRect(w, 0, w, FlxG.height);
        upRect    = new FlxRect(w * 2, 0, w, FlxG.height);
        rightRect = new FlxRect(w * 3, 0, w, FlxG.height);

        leftHint  = makeHint(0, 0, w, FlxG.height, 0xFFFF0000);
        downHint  = makeHint(w, 0, w, FlxG.height, 0xFF00FFFF);
        upHint    = makeHint(w * 2, 0, w, FlxG.height, 0xFF00FF00);
        rightHint = makeHint(w * 3, 0, w, FlxG.height, 0xFFFFFF00);

        add(leftHint);
        add(downHint);
        add(upHint);
        add(rightHint);

        var hint = new FlxSprite(0, 0);
        hint.loadGraphic("assets/images/mobile/hitbox_hint.png");
        hint.setGraphicSize(FlxG.width, FlxG.height);
        hint.updateHitbox();
        hint.alpha = 0.8;
        add(hint);
    }

    function makeHint(x:Float, y:Float, w:Float, h:Float, color:Int):FlxSprite
    {
        var s = new FlxSprite(x, y);
        s.makeGraphic(Std.int(w), Std.int(h), color);
        s.alpha = 0;
        s.scrollFactor.set();
        return s;
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        LEFT = DOWN = UP = RIGHT = false;

        leftHint.alpha = 0;
        downHint.alpha = 0;
        upHint.alpha = 0;
        rightHint.alpha = 0;

        for (touch in FlxG.touches.list)
        {
            if (touch.pressed)
            {
                var pos:FlxPoint = touch.getWorldPosition();

                if (leftRect.containsPoint(pos))
                {
                    LEFT = true;
                    leftHint.alpha = 0.2;
                }

                if (downRect.containsPoint(pos))
                {
                    DOWN = true;
                    downHint.alpha = 0.2;
                }

                if (upRect.containsPoint(pos))
                {
                    UP = true;
                    upHint.alpha = 0.2;
                }

                if (rightRect.containsPoint(pos))
                {
                    RIGHT = true;
                    rightHint.alpha = 0.2;
                }
            }
        }
    }
}
