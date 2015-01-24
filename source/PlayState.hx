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

    var layers:LayerManager;
    var player:Player;
    var npc:NPC;

    var placeManager:Map<String, Place>;

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();

        canvas = new FlxSprite();
        snowSystem = new SnowSystem(0, 200);
        
        canvas.makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT, true);

        layers = new LayerManager();
        add(layers);

        player = new Player();
        FlxG.camera.follow(player, FlxCamera.SHAKE_BOTH_AXES, 1);
        

        layers.getForegroundLayer().add(player);
        layers.getForegroundLayer().add(canvas);

        FlxG.camera.fade(FlxColor.BLACK, .33, true);

        npc = new NPC(150,360);
        layers.getForegroundLayer().add(npc);

        placeManager = new Map<String, Place>();
        placeManager.set("01_darkness", new Place(0, 1));
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
        canvas.x = FlxG.camera.target.x - FlxG.width * 0.5;
        canvas.fill(FlxColor.TRANSPARENT);

        snowSystem.setWindSpeed(player.velocity.x * 0.0001);

        for(flake in snowSystem.getSnowflakes())
        {
            canvas.drawCircle(flake.x - canvas.x, flake.y, 3, 0x77A2F1F2);
            canvas.drawCircle(flake.x - canvas.x, flake.y, 1.5, 0xCCEDFEFF);
        }

        for(place in placeManager)
        {
            if(!place.inactivated)
            {
                if((player.x >= place.xPosition) && 
                   (player.x <= place.xPosition + place.width))
                {
                    // do shit here
                    //Lib.utils.shit("really much", function(){ alsoFart(101); });
                }
            }
        }

        snowSystem.update();
		super.update();
	}	
}
