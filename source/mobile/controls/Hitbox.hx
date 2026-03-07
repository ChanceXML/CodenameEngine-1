package mobile.controls;

import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import funkins.game.PlayState;

class Hitbox extends FlxGroup
{
    public static var LEFT:Bool = false;
    public static var DOWN:Bool = false;
    public static var UP:Bool = false;
    public static var RIGHT:Bool = false;

    var leftHint:FlxSprite;
    var downHint:FlxSprite;
    var upHint:FlxSprite;
    var rightHint:FlxSprite;

    public function new()
    {
        super();

        var w = FlxG.width / 4;
        var h = FlxG.height;

        leftHint  = makeHint(0, 0, w, h, FlxColor.fromInts(255, 0, 0, 50));     
        downHint  = makeHint(w, 0, w, h, FlxColor.fromInts(0, 255, 255, 50));   
        upHint    = makeHint(w*2, 0, w, h, FlxColor.fromInts(0, 255, 0, 50));   
        rightHint = makeHint(w*3, 0, w, h, FlxColor.fromInts(255, 255, 0, 50)); 

        add(leftHint);
        add(downHint);
        add(upHint);
        add(rightHint);
    }

    function makeHint(x:Float, y:Float, w:Float, h:Float, color:Int):FlxSprite
    {
        var s = new FlxSprite(x, y);
        s.makeGraphic(Std.int(w), Std.int(h), color);
        s.alpha = 0;
        s.immovable = true;
        s.moves = false;
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
                var pos:FlxPoint = touch.getScreenPosition(); 

                if (leftHint.overlapsPoint(pos)) 
                {
                    LEFT = true;
                    leftHint.alpha = 0.2;
                    PlayState.noteLeft();
                }

                if (downHint.overlapsPoint(pos)) 
                {
                    DOWN = true;
                    downHint.alpha = 0.2;
                    PlayState.noteDown();
                }

                if (upHint.overlapsPoint(pos)) 
                {
                    UP = true;
                    upHint.alpha = 0.2;
                    PlayState.noteUp();
                }

                if (rightHint.overlapsPoint(pos)) 
                {
                    RIGHT = true;
                    rightHint.alpha = 0.2;
                    PlayState.noteRight();
                }
            }
        }
    }
}
