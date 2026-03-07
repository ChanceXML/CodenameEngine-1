package mobile.controls;

import flixel.FlxG;
import flixel.FlxBasic;

class TouchInput {
    public static function justTouched():Bool {
        #if mobile
        return FlxG.touches.list.filter(touch -> touch.justPressed).length > 0;
        #end
        return false;
    }

    public static function justPressed(obj:FlxBasic):Bool {
        #if mobile
        return FlxG.touches.list.filter(touch -> touch.justPressed && touch.overlaps(obj)).length > 0;
        #end
        return false;
    }

    public static function justReleased(obj:FlxBasic):Bool {
        #if mobile
        return FlxG.touches.list.filter(touch -> touch.justReleased && touch.overlaps(obj)).length > 0;
        #end
        return false;
    }

    public static function pressed(obj:FlxBasic):Bool {
        #if mobile
        return FlxG.touches.list.filter(touch -> touch.pressed && touch.overlaps(obj)).length > 0;
        #end
        return false;
    }

    public static function released(obj:FlxBasic):Bool {
        #if mobile
        return FlxG.touches.list.filter(touch -> touch.released && touch.overlaps(obj)).length > 0;
        #end
        return false;
    }

    public static function idfkaName(x:Float, y:Float, width:Float, height:Float):Bool {
        #if mobile
        return FlxG.touches.list.filter(touch ->
            touch.x >= x && touch.x <= x + width &&
            touch.y >= y && touch.y <= y + height
        ).length > 0;
        #end
        return false;
    }

    public static function BACK():Bool {
        #if android
        return FlxG.android.justReleased.BACK;
        #else
        return false;
        #end
    }
}
