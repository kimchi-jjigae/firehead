import flixel.FlxSprite;
import flixel.util.FlxPoint;

class NPC extends FlxSprite {
    
    public var runningAway:Bool;

    public function new(X:Float=0, Y:Float=0)
    {
        super(X, Y);
        runningAway = false;
        loadGraphic(AssetPaths.player__png, true, 16, 16);
    }

    override public function update():Void 
    {
        if(runningAway)
        {
            //velocity = new FlxPoint(1, 0);
        }

        super.update();
    }
}
