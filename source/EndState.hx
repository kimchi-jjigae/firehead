package;

import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

import flixel.tweens.FlxTween;

/**
 * A FlxState which can be used for the game's menu.
 */
class EndState extends FlxState
{

    var text:FlxText;

	/**
	 * Function that is called up when to state is created to set it up. 
	 */

    private var readTime:Float = 2.1;
	override public function create():Void
	{

        FlxG.mouse.visible = false;

        // Vector fonts look like complete ass in this
        text = new FlxText(0, 20, 400, "Something Something You Won The Hearts of Everyone, Nice.");
        text.setFormat("assets/fonts/MoonFlower.ttf", 50, FlxColor.WHITE, 0, 0);
       
        text.alignment = "center";
        text.x = (FlxG.stage.stageWidth - text.width) * 0.5;
        text.y = (FlxG.stage.stageHeight - text.height) * 0.5 - 30;
        text.alpha = 0;

        FlxTween.tween(text, { alpha:1.0 }, readTime, {complete:fadeOutThingy});

		super.create();
        add(text);
	}
	
    private function fadeOutThingy(tween:FlxTween):Void {
        FlxTween.tween(text, { alpha:0.0 }, readTime * 2, {complete:showUsTheDude});
    }

    private var guyDude:IntroDude;
    private function showUsTheDude(tween:FlxTween):Void {

    }

    private function goToGame(tween:FlxTween):Void {

    }

	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
    private var bajs:Float = 0;
	override public function update():Void
	{
        bajs += 0.05;
		super.update();

        if(guyDude != null){
            guyDude.y = FlxG.height / 2  + Math.sin(bajs) * 5;
        }
	}	
}
