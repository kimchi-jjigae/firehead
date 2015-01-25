package;

class Place
{
    public var inactivated:Bool;
    private var scaleMultiplier:Float;
    public var xPosition:Float;
    public var width:Float;

    //This is what happens when you stand in place.
    public var happenFunc:Void->Void = null;

    public function new(pos:Float, w:Float, callback:Void->Void = null) {
        inactivated = false;
        scaleMultiplier = 1;
        xPosition = pos * scaleMultiplier;
        width = w * scaleMultiplier;
        happenFunc = callback;
    }
}
