package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

/**
 * The scene with the falling snow and the wood heap
 */
class SnowState extends FlxState
{

    var text:FlxText;

    /**
     * Function that is called up when to state is created to set it up. 
     */
    override public function create():Void
    {
        text = new FlxText(0, 0, 200, "Press Something to Play I Guess");
       
        text.x = (FlxG.stage.stageWidth - text.width) * 0.5;
        text.alignment = "center";
        text.size = 20;
        super.create();
        add(text);
        
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
        super.update();
        /*
        if(FlxG.keys.justReleased.SPACE)
        {
            FlxG.switchState(new PlayState());
        }
        */
    }   
}