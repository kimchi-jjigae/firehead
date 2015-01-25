// TODO
// Player seems to be spawning in the same place regardless of the Y coordinate - INVESTIGATE

package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxPoint;
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
    
    var text:FlxText;

    var layers:LayerManager;
    var player:Player;
    var npc:NPC;
    var ageSequence:Ages;
    var bonfire:Thing;
    var ashHeap:Thing;
    var placeManager:Map<String, Place>;


    // var legs:Legs;
    var timer:FlxTimer;

    var torch:Torch;

    var placeList:Array<Place>;
    var npcList:Array<NPC>;

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
        placeList = new Array<Place>();
        npcList = new Array<NPC>();

		super.create();

        FlxG.sound.playMusic("music_1");

        snowSetup();
        spriteSetup();

        FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER, 1);
        FlxG.camera.fade(FlxColor.BLACK, 2, true);


        npc = new NPC(150,360);
        layers.getForegroundLayer().add(npc);

        // ageSequence = new Ages(140, 340);
        // layers.getForegroundLayer().add(ageSequence);

        placeManager = new Map<String, Place>();
        placeManager.set("01_darkness", new Place(0, 1));

        // FlxG.sound.playMusic("music_1");

        placeManager.set("01_darkness", new Place(0, 100));
        placeManager.set("02_introtext", new Place(200, 100));

        registerPlaces();

	}

	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}


    public function turnIntoDay():Void {
        layers.day();
        torch.turnIntoDay();
        layers.makeMountainsHappy();
    }

    public function turnIntoNight():Void {
        layers.night();
        torch.turnIntoNight();
        layers.makeMountainsSad();
    }

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
        canvas.x = FlxG.camera.scroll.x;
        canvas.fill(FlxColor.TRANSPARENT);

        if(FlxG.keys.anyPressed(["N"])){
            turnIntoNight();
        }

        if(FlxG.keys.anyPressed(["M"])){
            turnIntoDay();
        }

        // Just testing crap - IGNORE
        // if (Math.abs(npc.x - player.x) <= .2) {
        //     // text = new FlxText(150, 300, 200, "Test");
        //     // text.color = 0xFFFF66;
        //     // add(text);
        //     // player.scale.x = 0.5;
        //     // player.scale.y = 0.5;
        // }
        // else if (text != null && Math.abs(npc.x - player.x) >= 20) {
        //     // text.destroy();
        //     // trace("Test");
        // }

        // if(FlxG.keys.justPressed.ENTER) {
        //     text = new FlxText(150, 300, 200, "Test");
        //     text.color = 0xFFFF66;
        //     add(text);
        //     new FlxTimer(2, shrinkFlame, 1);
        //     // timer.start();
        //     // text.destroy();
        // }

        torch.setPos(player.x + player.width * 0.5, player.y + player.height * 0.5);
        
        snowUpdate();

        placeUpdate();

		super.update();
	}	

    private function snowSetup()
    {
        canvas = new FlxSprite();
        canvas.makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT, true);

        snowSystem = new SnowSystem(0, 200);
    }

    private function spriteSetup()
    {
        layers = new LayerManager();
        add(layers);

        // text = new FlxText(150, 300, 200, "Test");
        // text.color = 0xFFFF66;
        // add(text);

        // legs = new Legs(90,370);

        player = new Player(-200, 340);
        layers.getForegroundLayer().add(player);
        layers.getForegroundLayer().add(canvas);
        //layers.getForegroundLayer().add(legs);

        npcList.push(new NPC(150, 360));
        npcList.push(new NPC(2500, 360));
        npcList.push(new NPC(1000, 360));
        for(npc in npcList)
        {
            layers.getForegroundLayer().add(npc);
        }

        bonfire = new Thing(2000, 320, "bonfire.png", 66, 52);
        layers.getForegroundLayer().add(bonfire);

        ashHeap = new Thing(500, 350, "ash.png", 60, 36);
        layers.getForegroundLayer().add(ashHeap);

        torch = new Torch();
        add(torch);
    }

    private function snowUpdate()
    {
        snowSystem.setWindSpeed(player.velocity.x * 0.0001);

        for(flake in snowSystem.getSnowflakes())
        {
            canvas.drawCircle(flake.x - canvas.x - 1.5, flake.y - 1.5, 1.5, 0x77A2F1F2);
            canvas.drawCircle(flake.x - canvas.x - 0.75, flake.y - 0.75, 1.0, 0xCCEDFEFF);
        }

        snowSystem.update();
    }

    private function npcUpdate()
    {
        for(npc in npcList)
        {
            if (Math.abs(npc.x - player.x) <= 20) {
                npc.runningAway = true;
            }
        }
    }

    public function registerPlace(p:Place):Place {
        placeList.push(p);
        placeList.sort(function(a:Place, b:Place) {
            return (a.xPosition < b.xPosition)?-1:1;
        });
        return p;
    }

    public function placeUpdate():Void {
        if(placeList.length > 0){
            if(placeList[0].xPosition < FlxG.camera.target.x) {
                if(placeList[0].happenFunc != null){
                    placeList[0].happenFunc();
                    placeList.remove(placeList[0]);
                }
            }
        }
    }

            /* sorry just keeping this here for reference
            if(FlxG.keys.justPressed.ENTER) {
                text = new FlxText(150, 300, 200, "Test");
                text.color = 0xFFFF66;
                add(text);
                new FlxTimer(5, destroyText, 1);
                // timer.start();
                // text.destroy();
            }
            */

    public function registerPlaces():Void { // make sure these are in order!

        // initial text?
        registerPlace(new Place(500, 10, function() {
            text = new FlxText(player.x + 10, player.y - 20, 200, "?");
                text.color = 0xFFFF66;
                add(text);
        }));

        registerPlace(new Place(400, 10, function() {
            //player.grow();
        }));

        registerPlace(new Place(600, 10, function() {
            torch.setPos(600, 300);
        }));

        registerPlace(new Place(700, 10, function() {
            //torch.setPos(800, 300);
        }));

        // bonfire - starting to get small
        registerPlace(new Place(1400, 10, function() {
            player.scale.set(0.8, 0.8);
            //torch.scale.set(0.8, 0.8);
        }));

        // bonfire - getting smaller
        registerPlace(new Place(1600, 10, function() {
            player.scale.set(0.5, 0.5);
            //torch.scale.set(0.5, 0.5);
        }));

        // bonfire - dying!
        registerPlace(new Place(1800, 10, function() {
            player.scale.set(0.3, 0.3);
            //torch.scale.set(0.3, 0.3);
        }));

        // bonfire at 2000
        registerPlace(new Place(2000, 10, function() {
            trace("hej\n");
            turnIntoDay();
        }));
        
    }

    // private function changeText(Timer:FlxTimer):Void {
    //     text = new FlxText(150, 300, 200, "I'm new!");
    //     text.color = 0xFFFF66;
    //     add(text);
    // }

    // private function destroyText(Timer:FlxTimer):Void {
    //     text.destroy();
    // }

    private function shrinkFlame(Timer:FlxTimer):Void {
        player.scale.x = 0.5;
        player.scale.y = 0.5;
    }
}
