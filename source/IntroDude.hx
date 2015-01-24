import flixel.FlxSprite;


class IntroDude extends FlxSprite {

    public function new(x:Float = 0, y:Float = 0){
        super(x, y);
        loadGraphic(AssetPaths.ages__png, true, 52, 39);

    }
}
