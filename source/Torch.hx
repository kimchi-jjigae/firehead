import flixel.FlxTween;
import flixel.util.FlxPoint;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.group.FlxSpriteGroup;

import flash.display.BlendMode;

//This class should have some light stuff to light up the world I'm tired
class Torch extends FlxSpriteGroup
{
    private var darkPart:FlxSprite;
    private var torchPart:FlxSprite;
    private var dampStamp:FlxSprite;

    public function new(max:Int = 2){
        super(max);

        darkPart = new FlxSprite();
        dampStamp = new FlxSprite();
        darkPart.makeGraphic(FlxG.width, FlxG.height, 0xff111111, true);
        dampStamp.makeGraphic(FlxG.width, FlxG.height, 0xff444444, true);
        darkPart.scrollFactor.x = darkPart.scrollFactor.y = 0;
        darkPart.blend = BlendMode.MULTIPLY;
        scrollFactor.x = scrollFactor.y = 0;

        darkPart.x = -2;
        add(darkPart);

        torchPart = new FlxSprite();
        torchPart.loadGraphic(AssetPaths.glowie__png, true, 512, 512);
        torchPart.offset.x = 256;
        torchPart.offset.y = 256;

        torchPart.scale.x = 0.7;
        torchPart.scale.y = 0.7;

        torchPart.blend = BlendMode.SCREEN;

        //add(torchPart);
    }

    public function setLightPos(x:Float, y:Float):Void {
        
    }

    override public function update():Void {
        torchPart.x = FlxG.camera.target.x;
        torchPart.y = FlxG.camera.target.y;

        var screenXY:FlxPoint = torchPart.getScreenXY();
        darkPart.stamp(dampStamp, 0, 0);

        darkPart.stamp(torchPart,
                Std.int(screenXY.x - torchPart.width / 2),
                Std.int(screenXY.y - torchPart.height / 2));
    }
}
