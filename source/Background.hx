import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;

class Background extends FlxGroup {
    var images:Array<FlxSprite>;
    var activebg:FlxSprite;
    var secondarybg:FlxSprite;

    var bgWidth:Float = 1280;

    public function new(maxSize:Int = 3)
    {
        super(maxSize);
        images = new Array<FlxSprite>();
        var bgnight:FlxSprite = new FlxSprite();
        bgnight.loadGraphic(AssetPaths.bg_night_clear__png, true, 1280, 724);
        add(bgnight);
        images.push(bgnight);
        activebg = bgnight;

        bgnight = new FlxSprite();
        bgnight.loadGraphic(AssetPaths.bg_night_clear__png, true, 1280, 724);
        add(bgnight);
        images.push(bgnight);
        bgnight.x = 1280;
        secondarybg = bgnight;
    }

    override public function update():Void {

        var dx:Float =activebg.x - FlxG.camera.target.x  + bgWidth * 0.5;

        if(dx < 0){
            secondarybg.x = activebg.x + bgWidth;
        }else{
            secondarybg.x = activebg.x - bgWidth;
        }

        if(Math.abs(dx) > bgWidth){
            var d:FlxSprite = secondarybg;
            secondarybg = activebg;
            activebg = d;
        }

    }
}
