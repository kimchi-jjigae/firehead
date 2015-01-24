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

import flixel.FlxCamera;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
    var canvas:FlxSprite;
    var snowSystem:SnowSystem;

    var bg:Background;
    var player:Player;
    var npc:NPC;

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();

        canvas = new FlxSprite();
        snowSystem = new SnowSystem();
        
        canvas.makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT, true);

        bg = new Background();
        add(bg);

        player = new Player();
        FlxG.camera.follow(player, FlxCamera.SHAKE_BOTH_AXES, 1);
        add(player);
        add(canvas);

        FlxG.camera.fade(FlxColor.BLACK, .33, true);

        npc = new NPC(150,360);
        add(npc);
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
        canvas.fill(FlxColor.TRANSPARENT);

        for(flake in snowSystem.getSnowflakes())
        {
            canvas.drawCircle(flake.x, flake.y, 3, 0x77A2F1F2);
            canvas.drawCircle(flake.x, flake.y, 1.5, 0xCCEDFEFF);
        }

        snowSystem.update();
		super.update();
	}	
}
