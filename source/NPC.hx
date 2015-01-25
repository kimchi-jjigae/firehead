import flixel.FlxSprite;

class NPC extends FlxSprite {
    public function new(X:Float=0, Y:Float=0)
    {
        super(X, Y);
        loadGraphic(AssetPaths.walkingeskimo__png, true, 140, 186);
        offset.x = 70;
        offset.y = 186;
        scale.x = scale.y = 0.4;

        animation.add("default", [0, 1, 2, 3, 4], 20, false);
    }

    override public function update():Void {
    }
}
