package mobile.controls;

import flixel.FlxG;

class TouchInput {
	public static function BACK():Bool {
		return #if android FlxG.android.justReleased.BACK #else false #end;
	}

	public static function justTouched():Bool {
		#if mobile
		return FlxG.touches.list.filter(touch -> touch.justPressed).length > 0;
		#end
		return false;
	}

	public static function justPressed(obj:flixel.FlxBasic):Bool {
		#if mobile
		return FlxG.touches.list.filter(touch -> touch.justPressed && touch.overlaps(obj)).length > 0;
		#end
		return false;
	}

	public static function justReleased(obj:flixel.FlxBasic):Bool {
		#if mobile
		return FlxG.touches.list.filter(touch -> touch.justReleased && touch.overlaps(obj)).length > 0;
		#end
		return false;
	}

	public static function pressed(obj:flixel.FlxBasic):Bool {
		#if mobile
		return FlxG.touches.list.filter(touch -> touch.pressed && touch.overlaps(obj)).length > 0;
		#end
		return false;
	}

	public static function released(obj:flixel.FlxBasic):Bool {
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
}
