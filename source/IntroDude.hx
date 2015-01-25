import flixel.FlxSprite;
import flixel.FlxObject;

class IntroDude extends FlxSprite {

    public function new(x:Float = 0, y:Float = 0){
        super(x, y);
        offset.x = 35;
        offset.y = 31;
        loadGraphic(AssetPaths.ages__png, true, 70, 63);
        animation.add("default", [0, 1, 2, 3, 4, 5, 6], 3, false);
        setFacingFlip(FlxObject.RIGHT, true, true);

        alpha = 0.0;
    }
}
