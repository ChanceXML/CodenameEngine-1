package mobile.controls;

import openfl.display.BitmapData;
import openfl.display.Shape;
import flixel.graphics.FlxGraphic;
import flixel.FlxG;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import flixel.ui.FlxButton;

class HitBox extends FlxSpriteGroup {
    public var buttonLeft:FlxButton;
    public var buttonDown:FlxButton;
    public var buttonUp:FlxButton;
    public var buttonRight:FlxButton;

    public function new() {
        super();

        var buttonWidth:Int = Std.int(FlxG.width / 4);
        var buttonHeight:Int = FlxG.height;

        add(buttonLeft = createHitbox(0, 0, buttonWidth, buttonHeight, '0xC24B99'));
        add(buttonDown = createHitbox(buttonWidth, 0, buttonWidth, buttonHeight, '0x00FFFF'));
        add(buttonUp = createHitbox(buttonWidth * 2, 0, buttonWidth, buttonHeight, '0x12FA05'));
        add(buttonRight = createHitbox(buttonWidth * 3, 0, buttonWidth, buttonHeight, '0xF9393F'));
        
        scrollFactor.set();
    }

    function createHitbox(x:Float, y:Float, width:Int, height:Int, color:String):FlxButton {
        var button:FlxButton = new FlxButton(x, y);
        button.makeGraphic(width, height, FlxColor.fromString(color));
        button.alpha = 0.0001;
        
        button.onDown.callback = function() {
            FlxTween.tween(button, {alpha: 0.25}, 0.01, {ease: FlxEase.circInOut});
        };

        button.onUp.callback = function() {
            FlxTween.tween(button, {alpha: 0.0001}, 0.1, {ease: FlxEase.circInOut});
        };

        button.onOut.callback = button.onUp.callback;

        return button;
    }

    public static function BACK():Bool {
        return #if android FlxG.android.justReleased.BACK #else false #end;
    }

    override public function destroy() {
        super.destroy();
        buttonLeft = buttonDown = buttonUp = buttonRight = null;
    }
}
