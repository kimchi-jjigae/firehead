package;

import flixel.FlxSprite;

class Object extends FlxSprite
{
    public function new(X:Float=0, Y:Float=0, imageName:String, Width:Int, Height:Int)
    {
        super(X, Y);
        loadGraphic("assets/" + imageName, true, Width, Height);
    }
}
