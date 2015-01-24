package ;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxAngle;
import flixel.FlxG;
import flixel.text.FlxText;

class Player extends FlxSprite
{
    public var speed:Float = 200;

    public function new(X:Float=0, Y:Float=0) 
    {
        super(X, Y);
        // makeGraphic(16, 16, FlxColor.BLUE);
        loadGraphic(AssetPaths.stand_still_200__png, true, 52, 39);
        setFacingFlip(FlxObject.LEFT, false, false);
        setFacingFlip(FlxObject.RIGHT, true, false);
        animation.add("lr", [3, 4, 3, 5], 6, false);
        animation.add("u", [6, 7, 6, 8], 6, false);
        animation.add("d", [0, 1, 0, 2], 6, false);
        drag.x = drag.y = 1600;
        acceleration.y = 0;
        // y = 360;
    }

    private function movement():Void {
        var _up:Bool = false;
        var _down:Bool = false;
        var _left:Bool = false;
        var _right:Bool = false;

       _up = FlxG.keys.anyPressed(["UP", "W"]);
       _down = FlxG.keys.anyPressed(["DOWN", "S"]);
        _left = FlxG.keys.anyPressed(["LEFT", "A"]);
        _right = FlxG.keys.anyPressed(["RIGHT", "D"]);

        if (_up && _down) 
            _up = _down = false;
        if (_left && _right)
            _left = _right = false;

        if (_up || _down || _left || _right) {
            var mA:Float = 0;
            if (_up) {
                mA = -90;
                if (_left)
                    mA -= 45;
                else if (_right) 
                    mA += 45;
                facing = FlxObject.UP;
            }
            else if (_down) {
                mA = 90;
                if (_left)
                    mA += 45;
                else if (_right)
                    mA -= 45;
                facing = FlxObject.DOWN;
            }
            else if (_left) {
                mA = 180;
                facing = FlxObject.LEFT;
            }
            else if (_right) {
                mA = 0;
                facing = FlxObject.RIGHT;
            }

            FlxAngle.rotatePoint(speed, 0, 0, 0, mA, velocity);

            if ((velocity.x != 0 || velocity.y != 0) && touching == FlxObject.NONE) {
                switch(facing) {
                    case FlxObject.LEFT, FlxObject.RIGHT:
                        animation.play("lr");
                    case FlxObject.UP:
                        animation.play("u");
                    case FlxObject.DOWN:
                        animation.play("d");
                }
            }
        }
    }

    public function grow(amount:Float = 1.0):Void {
        
    }

    // private function dialogue():Void{
    //     var _actionbutton:Bool = false;

    //     _actionbutton = FlxG.keys.anyPressed(["ENTER", "E"]);

    //     if (_actionbutton) {
    //         add(new FlxText(10, 10, 100, "Hello, World!"));
    //     }
    // }

    override public function update():Void 
    {
        movement();
        super.update();
    }
}
