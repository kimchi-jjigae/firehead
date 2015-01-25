import flixel.tweens.FlxTween;
import flixel.util.FlxPoint;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.group.FlxSpriteGroup;

import flash.display.BlendMode;

using flixel.util.FlxSpriteUtil;

//This class should have some light stuff to light up the world I'm tired
class Torch extends FlxSpriteGroup
{
    private var darkPart:FlxSprite;
    private var torchPart:FlxSprite;

    public function new(max:Int = 2){
        super(max);

        darkPart = new FlxSprite();
        darkPart.makeGraphic(FlxG.width, FlxG.height, 0xff111111, true);
        darkPart.scrollFactor.x = darkPart.scrollFactor.y = 0;
        darkPart.blend = BlendMode.MULTIPLY;
        scrollFactor.x = scrollFactor.y = 0;

        darkPart.x = -2;
        add(darkPart);

        torchPart = new FlxSprite();
        torchPart.loadGraphic(AssetPaths.glowie__png, true, 512, 512);
        torchPart.offset.x = 256;
        torchPart.offset.y = 256;

        setScale(0.2);
        torchPart.alpha = 0.4;

        torchPart.blend = BlendMode.SCREEN;
    }

    public function turnIntoDay():Void {
        FlxTween.tween(this, { alpha:0.01 }, 1);
    }

    public function turnIntoNight():Void {
        FlxTween.tween(this, { alpha:1.0 }, 1);
    }

    private var lightX:Float = 0; 
    private var lightY:Float = 0;

    public function setPos(x:Float, y:Float):Void {
        //FlxTween.tween(this, { lightX:x, lightY:y }, 5);
        lightX = x;
        lightY = y;
    }

    var torchScale:Float = 0.3;

    public function setScale(scale:Float):Void {
        torchScale = scale;
    }

    private var bajs:Float = 0;
    override public function update():Void {
        bajs += 0.01;
        torchPart.scale.x = torchPart.scale.y = (Math.sin(bajs) * 0.5 + 1.0)*0.2 + torchScale; 

        torchPart.x = lightX; //FlxG.camera.target.x;
        torchPart.y = lightY; //FlxG.camera.target.y;

        var screenXY:FlxPoint = torchPart.getScreenXY();
        darkPart.fill(0xff444444);

        darkPart.stamp(torchPart,
                Std.int(screenXY.x - torchPart.width / 2),
                Std.int(screenXY.y - torchPart.height / 2));
    }

}
