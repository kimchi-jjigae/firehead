import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;

class BackgroundLayer extends FlxGroup {

    var activebg:FlxSprite;
    var secondarybg:FlxSprite;

    private var bgWidth:Float;

    public var moveScale:Float;

    private var lastX:Float = 0;

    public function new(maxSize:Int = 2, scale:Float, image:String, width:Int, height:Int) {
        super(maxSize);

        bgWidth = width;
        moveScale = scale;

        var bgnight:FlxSprite = new FlxSprite();
        bgnight.loadGraphic(image, true, width, height);
        add(bgnight);

        activebg = bgnight;

        bgnight = new FlxSprite();
        bgnight.loadGraphic(image, true, width, height);
        add(bgnight);

        secondarybg = bgnight;
        bgnight.x = bgWidth;
    }

    override public function update():Void {
        
        var dx:Float = lastX - FlxG.camera.scroll.x;

        activebg.x -= (1.0 - moveScale) * dx;

        lastX = FlxG.camera.scroll.x;

        dx = activebg.x - FlxG.camera.scroll.x;

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
