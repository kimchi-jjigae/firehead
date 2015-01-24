package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using flixel.util.FlxSpriteUtil;

import flixel.FlxCamera;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
    var canvas:FlxSprite;
    var snowSystem:SnowSystem;
    
    // var physics:Physics;
    var text:FlxText;

    var layers:LayerManager;
    var player:Player;
    var npc:NPC;
    var timer:FlxTimer;

    var torch:Torch;

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

        // text = new FlxText(150, 300, 200, "Test");
        // text.color = 0xFFFF66;
        // add(text);

        player = new Player(81,340);
        FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER, 1);
        

        layers.getForegroundLayer().add(player);
        layers.getForegroundLayer().add(canvas);

        FlxG.camera.fade(FlxColor.BLACK, 2, true);

        npc = new NPC(150,360);
        layers.getForegroundLayer().add(npc);

        placeManager = new Map<String, Place>();
        // FlxG.sound.playMusic("music_1");
        placeManager.set("01_darkness", new Place(0, 100));
        placeManager.set("02_introtext", new Place(200, 100));

        torch = new Torch();
        add(torch);
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
        canvas.x = FlxG.camera.scroll.x;
        canvas.fill(FlxColor.TRANSPARENT);

        snowSystem.setWindSpeed(player.velocity.x * 0.0001);

        if(FlxG.keys.anyPressed(["N"])){
            layers.night();
        }

        if(FlxG.keys.anyPressed(["M"])){
            layers.day();
        }

        for(flake in snowSystem.getSnowflakes())
        {
            canvas.drawCircle(flake.x - canvas.x - 1.5, flake.y - 1.5, 3, 0x77A2F1F2);
            canvas.drawCircle(flake.x - canvas.x - 0.75, flake.y - 0.75, 1.5, 0xCCEDFEFF);
        }

        var placeIter = placeManager.keys();
        for(key in placeIter)
        {
            var place = placeManager.get(key);
            if(!place.inactivated)
            {
                if((player.x >= place.xPosition) && 
                   (player.x <= place.xPosition + place.width))
                {
                    runPlaceFunction(key);
                }
                else
                {
                    // do shit here
                    //Lib.utils.shit("really much", function(){ alsoFart(101); });
                }
            }
            else
            {
            }
        }

        if (Math.abs(npc.x - player.x) <= 20) {
            text = new FlxText(150, 300, 200, "Test");
            text.color = 0xFFFF66;
            add(text);
        }
        else if (text != null && Math.abs(npc.x - player.x) >= 20) {
            // text.destroy();
            // trace("Test");
        }

        if(FlxG.keys.justPressed.ENTER) {
            text = new FlxText(150, 300, 200, "Test");
            text.color = 0xFFFF66;
            add(text);
            new FlxTimer(5, destroyText, 1);
            // timer.start();
            // text.destroy();
        }

        snowSystem.update();
		super.update();
	}	


    public function registerPlace(p:Place):Place {
        return null;
    }

    public function runPlaceFunction(place:String)
    {
        if(place == "01_darkness")
        {
            //trace("you're in darkness\n");
        }
        else if(place == "02_introtext")
        {
            //trace("you're reading text\n");
        }
    }

    private function changeText(Timer:FlxTimer):Void {
        text = new FlxText(150, 300, 200, "I'm new!");
        text.color = 0xFFFF66;
        add(text);
    }

    private function destroyText(Timer:FlxTimer):Void {
        text.destroy();
    }
}
