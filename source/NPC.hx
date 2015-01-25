import flixel.FlxObject;
import flixel.tweens.FlxTween;
import flixel.FlxSprite;
import flixel.util.FlxPoint;

class NPC extends FlxSprite {
    
    public var runningAway:Bool;

    public function new(X:Float=0, Y:Float=0)
    {
        super(X, Y);
        runningAway = false;
        loadGraphic(AssetPaths.walkingeskimo__png, true, 140, 186);
        offset.x = 70;
        offset.y = 186;
        scale.x = scale.y = 0.4;

        animation.add("default", [0, 1, 2, 3, 4], 20, false);
        setFacingFlip(FlxObject.RIGHT, true, false);
    }

    override public function update():Void 
    {
        if(runningAway)
        {
            //velocity = new FlxPoint(1, 0);
        }

        super.update();
    }

    //Makes the NPC scamper away. Callb is called once the NPC has ran away.
    public function runAway(callb:Void->Void):Void {
        animation.play("default");
        facing = FlxObject.RIGHT;
        FlxTween.tween(this, { x:x + 1500 }, 2, { complete: function(twn:FlxTween) {
            callb();
            this.visible = false;
        }});
    }

    public function faceLeft(yes:Bool = true):Void {
        if(yes){
            facing = FlxObject.LEFT;
        }else{
            facing = FlxObject.RIGHT;
        }
    }

    public function jumpScaredly(times:Int, callback:Void->Void):Void {
        callBack = callback;
        jumps = times;
        jump(null);
    }

    private var callBack:Void->Void;
    private var jumps:Int;
    private var jumpSpeed:Float = 0.05;
    private function jump(twn:FlxTween):Void {
        var jumpadd:Float = Math.random() * 5;
        FlxTween.tween(this, { y:y - 20 - jumpadd }, jumpSpeed, { complete: function(twn:FlxTween) {
            if(jumps-- > 0){
                FlxTween.tween(this, { y:y + 20 + jumpadd}, jumpSpeed, {complete:jump});
            }else {
                FlxTween.tween(this, { y:y + 20 + jumpadd}, jumpSpeed, {complete:finishJumps} );
            }
        }});
    }

    private function finishJumps(twn:FlxTween):Void {
        if(callBack != null){
            callBack();
        }
    }
}
