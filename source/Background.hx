import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;

class Background extends FlxGroup {

    var layers:Array<BackgroundLayer>;

    public function new(maxSize:Int = 2)
    {
        super(5);

        layers = new Array<BackgroundLayer>();
        addLayer(AssetPaths.bg_night_clear__png, 1280, 724, 0.5);
        addLayer(AssetPaths.mountains__png, 1280, 724, 0.75);
        addLayer(AssetPaths.bg_texture_snow__png, 1280, 724, 1.0);

    }

    private function addLayer(name:String, width:Int, height:Int, scale:Float){
        var bg:BackgroundLayer = new BackgroundLayer(5, scale, name,
                width, height);
        add(bg);

        layers.push(bg);
    }

    override public function update():Void {
        for(layer in layers){
            layer.update();
        }
    }
}
