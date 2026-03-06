package mobile.controls;

import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.util.FlxRect;
import flixel.math.FlxPoint;

class Hitbox extends FlxGroup
{
    var left:FlxRect;
    var down:FlxRect;
    var up:FlxRect;
    var right:FlxRect;

    public static var LEFT:Bool = false;
    public static var DOWN:Bool = false;
    public static var UP:Bool = false;
    public static var RIGHT:Bool = false;

    public function new()
    {
        super();

        var w = FlxG.width / 4;

        left  = new FlxRect(0, 0, w, FlxG.height);
        down  = new FlxRect(w, 0, w, FlxG.height);
        up    = new FlxRect(w * 2, 0, w, FlxG.height);
        right = new FlxRect(w * 3, 0, w, FlxG.height);
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        LEFT = false;
        DOWN = false;
        UP = false;
        RIGHT = false;

        for (touch in FlxG.touches.list)
        {
            if (touch.pressed)
            {
                var pos:FlxPoint = touch.getWorldPosition();

                if (left.containsPoint(pos)) LEFT = true;
                if (down.containsPoint(pos)) DOWN = true;
                if (up.containsPoint(pos)) UP = true;
                if (right.containsPoint(pos)) RIGHT = true;
            }
        }
    }
}
