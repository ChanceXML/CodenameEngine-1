package mobile.controls;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.input.touch.FlxTouch;
import flixel.group.FlxGroup;

class hitbox extends FlxGroup {
    public var hitboxes:Array<FlxSprite>;
    public var hintImage:FlxSprite;

    public function new() {
        super();
        hitboxes = [];
        setupHitboxes();
        setupHintImage();
    }

    private function setupHitboxes():Void {
        var hitWidth = 480;
        var hitHeight = 1080;
        var yPos = 0;

        for (i in 0...4) {
            var box = new FlxSprite(i * hitWidth, yPos);
            box.makeGraphic(hitWidth, hitHeight, 0x00000000);
            hitboxes.push(box);
            add(box);
        }
    }

    private function setupHintImage():Void {
        hintImage = new FlxSprite(0, 0, "assets/images/mobile/hitbox_hint.png");
        hintImage.setSize(1280, 720); 
        hintImage.alpha = 0.5;       
        add(hintImage);       
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);
        handleTouches();
    }

    private function handleTouches():Void {
        for (i in 0...hitboxes.length) sendInput(i, false);

        for (touch in FlxG.touches.list) {
            for (i in 0...hitboxes.length) {
                if (hitboxes[i].overlapsPoint(touch.screenPosition)) {
                    sendInput(i, true); 
                }
            }
        }
    }

    private function sendInput(index:Int, pressed:Bool):Void {
        switch(index) {
            case 0: FlxG.keys.setPressed("LEFT", pressed);
            case 1: FlxG.keys.setPressed("DOWN", pressed);
            case 2: FlxG.keys.setPressed("UP", pressed);
            case 3: FlxG.keys.setPressed("RIGHT", pressed);
        }
    }
}
