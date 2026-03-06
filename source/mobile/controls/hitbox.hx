package mobile.controls;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.input.touch.FlxTouch;
import flixel.group.FlxGroup;

class hitboxes extends FlxGroup {
    public var hitboxes:Array<FlxSprite>;
    public var noteImage:FlxSprite;

    public function new() {
        super();
        hitboxes = [];
        setupHitboxes();
        setupNoteImage();
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

    private function setupNoteImage():Void {
        noteImage = new FlxSprite(0, 0, "assets/images/hitbox.png");
        noteImage.setSize(1280, 720);
        add(noteImage);
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
