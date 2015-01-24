package;

import flixel.FlxG;
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
        for(i in 0...50)
        {
            var newPoint = new FlxPoint(FlxRandom.floatRanged(position - FlxG.width * 0.5, position + FlxG.width * 0.5), FlxRandom.floatRanged(375, 0));
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
            flake.x += gravity * 0.3;
            if(flake.y > 375 || 
                Math.abs(flake.x - FlxG.camera.target.x) > FlxG.width * 0.5) {
                flake.y = 50 + Math.random() * 50;
                flake.x = FlxG.camera.target.x + FlxRandom.floatRanged(-FlxG.width, FlxG.width);
            }
        }
    }
}
