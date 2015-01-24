package;

class Place
{
    public var inactivated:Bool;
    private var scaleMultiplier:Float;
    public var xPosition:Float;
    public var width:Float;

    public function new(pos:Float, w:Float)
    {
        inactivated = false;
        scaleMultiplier = 1;
        xPosition = pos * scaleMultiplier;
        width = w * scaleMultiplier;
    }
}
