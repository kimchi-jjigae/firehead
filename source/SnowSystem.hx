package;

import flixel.util.FlxPoint;
import flixel.util.FlxRandom;

class SnowSystem
{
    var snowflakes:Array<FlxPoint>;
    var gravity:Float;

    public function new(position:Float, width:Float)
    {
        gravity = 1.1;
        snowflakes = new Array<FlxPoint>();
        for(i in 0...10)
        {
            var newPoint = new FlxPoint(FlxRandom.floatRanged(position, position + width), FlxRandom.floatRanged(-40, 0));
            snowflakes.push(newPoint);
        }
    }

    public function getSnowflakes():Array<FlxPoint>
    {
        return snowflakes;
    }

    public function update():Void
    {
        for(flake in snowflakes)
        {
            flake.y += gravity;
        }
    }
}
