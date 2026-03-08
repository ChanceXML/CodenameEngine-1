package mobile.controls;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import flixel.FlxCamera;
import funkin.options.Options;

class HitBox extends FlxSpriteGroup {

    public var hitboxCamera:FlxCamera;

    public var buttonLeft:HitboxButton;
    public var buttonDown:HitboxButton;
    public var buttonUp:HitboxButton;
    public var buttonRight:HitboxButton;

    public function new() {
        super();

        var w:Int = Std.int(FlxG.width / 4);
        var h:Int = FlxG.height;

        hitboxCamera = new FlxCamera(0, 0, FlxG.width, FlxG.height);
        hitboxCamera.scroll.set(0, 0);
        hitboxCamera.bgColor = 0x00000000;

        add(buttonLeft  = new HitboxButton(0, 0, w, h, 0xFFC24B99, hitboxCamera));
        add(buttonDown  = new HitboxButton(w, 0, w, h, 0xFF00FFFF, hitboxCamera));
        add(buttonUp    = new HitboxButton(w * 2, 0, w, h, 0xFF12FA05, hitboxCamera));
        add(buttonRight = new HitboxButton(w * 3, 0, w, h, 0xFFF9393F, hitboxCamera));

        for(button in [buttonLeft, buttonDown, buttonUp, buttonRight])
            button.cameras = [hitboxCamera];

        scrollFactor.set();

        FlxCamera.defaultCameras = [FlxG.camera];
    }

    public function setupCamera():Void {
        if(!FlxG.cameras.list.contains(hitboxCamera))
            FlxG.cameras.add(hitboxCamera);
    }

    public static function BACK():Bool {
        return #if android FlxG.android.justReleased.BACK #else false #end;
    }
}

class HitboxButton extends FlxSprite {
    public var onDown:HitboxCallback = {callback: null};
    public var onUp:HitboxCallback = {callback: null};
    public var onOut:HitboxCallback = {callback: null};

    public var isPressed:Bool = false;
    private var _wasPressed:Bool = false;

    public var hitboxCamera:FlxCamera;

    public function new(x:Float, y:Float, width:Int, height:Int, color:FlxColor, hitboxCamera:FlxCamera) {
        super(x, y);
        makeGraphic(width, height, color);
        alpha = 0.00001;
        antialiasing = false;
        this.hitboxCamera = hitboxCamera;
    }

    override public function update(elapsed:Float) {
        _wasPressed = isPressed;
        isPressed = false;

        #if FLX_TOUCH
        for (touch in FlxG.touches.list) {
            var localX = hitboxCamera.getWorldPosition().x + touch.screenX / hitboxCamera.zoom;
            var localY = hitboxCamera.getWorldPosition().y + touch.screenY / hitboxCamera.zoom;
            if (localX >= x && localX <= x + width && localY >= y && localY <= y + height) {
                isPressed = true;
                break;
            }
        }
        #end

        #if FLX_MOUSE
        var localX = hitboxCamera.getWorldPosition().x + FlxG.mouse.screenX / hitboxCamera.zoom;
        var localY = hitboxCamera.getWorldPosition().y + FlxG.mouse.screenY / hitboxCamera.zoom;
        if (localX >= x && localX <= x + width && localY >= y && localY <= y + height && FlxG.mouse.pressed)
            isPressed = true;
        #end

        if (isPressed && !_wasPressed && onDown.callback != null)
            onDown.callback();
        if (!isPressed && _wasPressed && onUp.callback != null)
            onUp.callback();
        if (!isPressed && _wasPressed && onOut.callback != null)
            onOut.callback();

        alpha = isPressed ? Options.hitboxOpacity : 0.00001;

        super.update(elapsed);
    }
}

typedef HitboxCallback = {
    var callback:Void->Void;
}
