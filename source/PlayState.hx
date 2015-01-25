// TODO
// Player seems to be spawning in the same place regardless of the Y coordinate - INVESTIGATE

package;

import flixel.tweens.FlxTween;
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
import flixel.util.FlxRandom;

using flixel.util.FlxSpriteUtil;

import flixel.FlxCamera;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
    var canvas:FlxSprite;
    var snowSystem:SnowSystem;
    var snowing:Bool;
    var windy:Bool;
    
    var text:FlxText;

    var layers:LayerManager;
    var player:Player;
    var ageSequence:Ages;
    var bonfire:Thing;
    var ashHeap:Thing;
    var ashHeap2:Thing;
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

        // ageSequence = new Ages(140, 340);
        // layers.getForegroundLayer().add(ageSequence);

        placeManager = new Map<String, Place>();
        placeManager.set("01_darkness", new Place(0, 1));

        FlxG.sound.playMusic("music_1");

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
        
        if(snowing)
            snowUpdate();

        placeUpdate();

		super.update();
	}	

    private function snowSetup()
    {
        snowing = false;
        canvas = new FlxSprite();
        canvas.makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT, true);

        snowSystem = new SnowSystem(0, 200);
    }

    private function spriteSetup() {
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

        npcList.push(new NPC(150, 450));

        //Two npcs standing together 
        npcList.push(new NPC(1000, 450));
        npcList[1].faceLeft(false);

        npcList.push(new NPC(1100, 450));

        npcList.push(new NPC(2500, 450));
        npcList.push(new NPC(2600, 450));

        for(npc in npcList){
            layers.getItemLayer().add(npc);
        }

        bonfire = new Thing(2000, 320, "bonfire.png", 66, 52, true);
        //layers.getForegroundLayer().add(bonfire);

        ashHeap = new Thing(1500, 350, "ash.png", 60, 36);
        ashHeap2 = new Thing(3000, 350, "ash.png", 60, 36);
        layers.getItemLayer().add(ashHeap);
        layers.getItemLayer().add(ashHeap2);

        torch = new Torch();
        add(torch);
    }

    private function snowUpdate()
    {
        if(!windy)
            snowSystem.setWindSpeed(player.velocity.x * 0.0001);
        else
            snowSystem.setWindSpeed(FlxRandom.floatRanged(0.012, 0.025));

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

    public function registerPlaces():Void { // keep these are in order!!

        //////////////////
        // START PLACES //
        //////////////////

        // ash pile
        registerPlace(new Place(1500, 10, function() {
            text = new FlxText(1500 + 30, 300, 200, "?");
                text.color = 0xFFFF66;
                add(text);
        }));

        /////////////////
        // SNOWY SCENE //
        /////////////////

        registerPlace(new Place(2400, 10, function() {
            snowing = true;
        }));

        registerPlace(new Place(3200, 10, function() {
            windy = true;
        }));

        // npc gets scared and jumps away!
        registerPlace(new Place(npcList[0].x - 100, 10, function() {
            player.enableControls(false);

            npcList[0].jumpScaredly(1, function(){
                //After npc has jumped, make it run away.
                npcList[0].runAway(function(){
                    player.enableControls(true);
                    player.setPowerScale(0.8);
                });
            });
        }));

        // two npcs get startled and run away!
        registerPlace(new Place(npcList[1].x - 200, 10, function() {
            npcList[1].faceLeft(true);
            npcList[1].jumpScaredly(1, function(){
                //After npc has jumped, make it run away.
                npcList[1].runAway(function(){});

                npcList[2].jumpScaredly(2, function(){
                    //After npc has jumped, make it run away.
                    npcList[2].runAway(function(){
                        player.setPowerScale(0.7);
                    });
                });
            });

        }));

        // turn into day
        registerPlace(new Place(2000, 10, function() {
            turnIntoDay();
            FlxTween.tween(this, { lol:10 } , 3, {complete:endGame});
        }));

        // turn into day
        registerPlace(new Place(2100, 10, function() {
            npcList[3].jumpScaredly(200, function(){});
            npcList[4].jumpScaredly(200, function(){});
        }));

/*
        // bonfire - starting to get small
        registerPlace(new Place(1400, 10, function() {
            player.setPowerScale(0.8);
            //torch.scale.set(0.8, 0.8);
        }));

        // bonfire - getting smaller
        registerPlace(new Place(1600, 10, function() {
            player.setPowerScale(0.5);
            //torch.scale.set(0.5, 0.5);
        }));

        // bonfire - dying!
        registerPlace(new Place(1800, 10, function() {
            player.setPowerScale(0.3);
            //torch.scale.set(0.3, 0.3);
        }));

        // bonfire at 2000
        registerPlace(new Place(2000, 10, function() {
            trace("hej\n");
            player.setPowerScale(1.2);
            //turnIntoDay();
        }));
        */
        
    }

    // private function changeText(Timer:FlxTimer):Void {
    //     text = new FlxText(150, 300, 200, "I'm new!");
    //     text.color = 0xFFFF66;
    //     add(text);
    // }

    // private function destroyText(Timer:FlxTimer):Void {
    //     text.destroy();
    // }

    private function endGame(twn:FlxTween):Void {
        FlxG.camera.fade(FlxColor.BLACK, 2, false,function() {
            FlxG.switchState(new EndState());
        });
    }
    private function shrinkFlame(Timer:FlxTimer):Void {
        player.scale.x = 0.5;
        player.scale.y = 0.5;
    }
    private var lol:Float = 0;
}
