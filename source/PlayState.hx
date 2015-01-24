package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
    private var snowSystem:SnowSystem;
    private var physics:Physics;

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();

        var canvas = new FlxSprite();
        canvas.makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT, true);
        add(canvas);

        var iter = snowSystem.getSnowflakes().iterator();
        // Actual iteration bellow
        for(flake in iter)
        {
           canvas.drawCircle(flake.x, flake.y, 5, FlxColor.BLUE);
        }
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
	override public function update():Void
	{
        //canvas.fill(FlxColor.TRANSPARENT);
		super.update();
	}	
}
