package;

import flixel.util.FlxPoint;
import flixel.util.FlxRandom;

class SnowSystem
{
    var snowflakes:Array<FlxPoint>;
    public function new()
    {
        snowflakes = new Array<FlxPoint>();
        for(i in 0...10)
        {
            var newPoint = new FlxPoint(FlxRandom.floatRanged(0, 640), FlxRandom.floatRanged(0, 50));
            snowflakes.push(newPoint);
        }
    }

    public function getSnowflakes():Array<FlxPoint>
    {
        return snowflakes;
    }
}
