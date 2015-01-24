import flixel.FlxSprite;

class NPC extends FlxSprite {
    public function new(X:Float=0, Y:Float=0)
    {
        super(X, Y);
        loadGraphic(AssetPaths.player__png, true, 16, 16);
    }
}