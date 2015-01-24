import flixel.FlxSprite;

class Background extends FlxSprite {
    public function new(X:Float=0, Y:Float=0)
    {
        super(X, Y);
        loadGraphic(AssetPaths.bgnight__png, true, 1280, 724);
    }
}