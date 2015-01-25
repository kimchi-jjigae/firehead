package;

import flixel.FlxSprite;

class Thing extends FlxSprite
{
    var animating:Bool;
    public function new(X:Float=0, Y:Float=0, imageName:String, Width:Int, Height:Int, ?animates:Bool = false)
    {
        animating = animates;
        super(X, Y);
        loadGraphic("assets/images/" + imageName, true, Width, Height);
        if(animates)
        {
            animation.add("animation", [0, 1, 2, 3], 4, false);
            animation.play("animation");
        }
    }

    override public function update():Void
    {
        if(animating)
            animation.play("burn");
        super.update();
    }
}
