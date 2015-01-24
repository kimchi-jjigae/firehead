import flixel.FlxSprite;
import flixel.group.FlxGroup;

class Background extends FlxGroup {
    var images:Array<FlxSprite>;
    public function new(maxSize:Int = 3)
    {
        super(maxSize);
        images = new Array<FlxSprite>();
        var bgnight:FlxSprite = new FlxSprite();
        bgnight.loadGraphic(AssetPaths.bgnight__png, true, 1280, 724);
        add(bgnight);
        images.push(bgnight);
    }

    override public function update():Void {
    
    }
}
