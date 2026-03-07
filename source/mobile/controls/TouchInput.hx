package mobile.controls;

import flixel.group.FlxSpriteGroup;

class TouchInput extends FlxSpriteGroup {
    public var hitbox:Hitbox;

    public function new() {
        super();
        hitbox = new Hitbox();
        add(hitbox);
    }
}
