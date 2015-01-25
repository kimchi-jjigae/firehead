package;

import flixel.FlxG;
import flixel.util.FlxPoint;
import flixel.util.FlxRandom;

class SnowSystem
{
    var snowflakes:Array<FlxPoint>;
    var drags:Array<Float>;
    var gravity:Float;
    var windSpeed:Float;

    public function new(position:Float, width:Float)
    {
        gravity = 1.1;
        windSpeed = 0;
        snowflakes = new Array<FlxPoint>();
        drags = new Array<Float>();
        for(i in 0...50)
        {
            var newPoint = new FlxPoint(FlxRandom.floatRanged(position - FlxG.width * 0.5, position + FlxG.width * 0.5), FlxRandom.floatRanged(375, 0));
            drags.push(FlxRandom.floatRanged(0.9, 1.0));
            snowflakes.push(newPoint);
        }
    }

    public function getSnowflakes():Array<FlxPoint>
    {
        return snowflakes;
    }

    public function setWindSpeed(speed:Float):Void {
        windSpeed += speed;
    }

    public function update():Void
    {
        windSpeed *= 0.99;
        var i:Int = 0;
        for(flake in snowflakes)
        {
            flake.y += drags[i] * gravity;
            flake.x += drags[i] * windSpeed;

            i ++;

            if(flake.y > 375 || 
                Math.abs(flake.x - FlxG.camera.target.x) > FlxG.width * 0.6) {
                flake.y = 100 - Math.random() * 500;
                flake.x = FlxG.camera.target.x + FlxRandom.floatRanged(-FlxG.width, FlxG.width);
            }
        }
    }
}
