package;

import flixel.FlxSprite;

class Thing extends FlxSprite
{
    public function new(X:Float=0, Y:Float=0, imageName:String, Width:Int, Height:Int)
    {
        super(X, Y);
        loadGraphic("assets/images/" + imageName, true, Width, Height);
        animation.add("burn", [0, 1, 2, 3], 4, false);
        animation.play("burn");
    }

    override public function update():Void
    {
        animation.play("burn");
        super.update();
    }
}
