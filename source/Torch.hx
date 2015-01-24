import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.group.FlxGroup;

import flash.display.BlendMode;

//This class should have some light stuff to light up the world I'm tired
class Torch extends FlxGroup
{
    private var darkPart:FlxSprite;
    private var torchPart:FlxSprite;

    public function new(max:Int = 2){
        super(max);

        darkPart = new FlxSprite();
        darkPart.makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT, false);
        darkPart.scrollFactor.x = darkPart.scrollFactor.y = 0;
        darkPart.blend = BlendMode.MULTIPLY;
        add(darkPart);

        torchPart = new FlxSprite();
        torchPart.loadGraphic(AssetPaths.glow2__png, true, FlxG.width, FlxG.height);
        //torchPart.loadGraphic(AssetPaths.glow__png, true, 662, 618);
        torchPart.offset.x = 331;
        torchPart.offset.y = 309;
        //torchPart.scale.x = 0.4;
        //torchPart.scale.y = 0.4;

        add(torchPart);
    }

    public function render():Void {
        //darkPart.fill(0xff000000);
    }

    override public function update():Void {
        darkPart.x = FlxG.camera.scroll.x - 25;
        darkPart.y = FlxG.camera.scroll.y - 25;

        torchPart.x = FlxG.camera.target.x;
        torchPart.y = FlxG.camera.target.y;
    }
}
