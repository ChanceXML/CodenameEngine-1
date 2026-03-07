package mobile.controls;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;

class Hitbox extends FlxSpriteGroup {
    public var buttonLeft:HitboxButton;
    public var buttonDown:HitboxButton;
    public var buttonUp:HitboxButton;
    public var buttonRight:HitboxButton;

    public function new() {
        super();

        var w:Int = Std.int(FlxG.width / 4);
        var h:Int = FlxG.height;

        buttonLeft  = new HitboxButton(0, 0, w, h, 0xFFC24B99);
        buttonDown  = new HitboxButton(w, 0, w, h, 0xFF00FFFF);
        buttonUp    = new HitboxButton(w * 2, 0, w, h, 0xFF12FA05);
        buttonRight = new HitboxButton(w * 3, 0, w, h, 0xFFF9393F);

        add(buttonLeft);
        add(buttonDown);
        add(buttonUp);
        add(buttonRight);
    }

    public var leftPressed(get, never):Bool;
    inline function get_leftPressed() return buttonLeft.pressed;

    public var leftJustPressed(get, never):Bool;
    inline function get_leftJustPressed() return buttonLeft.justPressed;

    public var downPressed(get, never):Bool;
    inline function get_downPressed() return buttonDown.pressed;

    public var downJustPressed(get, never):Bool;
    inline function get_downJustPressed() return buttonDown.justPressed;

    public var upPressed(get, never):Bool;
    inline function get_upPressed() return buttonUp.pressed;

    public var upJustPressed(get, never):Bool;
    inline function get_upJustPressed() return buttonUp.justPressed;

    public var rightPressed(get, never):Bool;
    inline function get_rightPressed() return buttonRight.pressed;

    public var rightJustPressed(get, never):Bool;
    inline function get_rightJustPressed() return buttonRight.justPressed;
}

class HitboxButton extends FlxSprite {
    public var pressed:Bool = false;
    public var justPressed:Bool = false;
    public var justReleased:Bool = false;
    private var _wasPressed:Bool = false;

    public function new(x:Float, y:Float, width:Int, height:Int, color:FlxColor) {
        super(x, y);
        makeGraphic(width, height, color);
        this.alpha = 0.00001;
        this.scrollFactor.set(0, 0);
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);
        _wasPressed = pressed;
        pressed = false;

        #if FLX_TOUCH
        for (touch in FlxG.touches.list) if (touch.overlaps(this)) pressed = true;
        #end

        #if FLX_MOUSE
        if (FlxG.mouse.pressed && FlxG.mouse.overlaps(this)) pressed = true;
        #end

        justPressed = (pressed && !_wasPressed);
        justReleased = (!pressed && _wasPressed);

        this.alpha = pressed ? 0.45 : 0.00001;
    }
}
