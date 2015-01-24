import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;

class LayerManager extends FlxGroup {

    var layers:Array<FlxGroup>;
    
    private var foreground:FlxGroup;

    public function new(maxSize:Int = 2)
    {
        super(10);
        layers = new Array<FlxGroup>();
        addLayer(AssetPaths.bg_night_clear__png, 1280, 724, 0.1);
        addLayer(AssetPaths.mountains__png, 1280, 724, 0.4);
        addLayer(AssetPaths.bg_texture_snow__png, 1280, 724, 1.0);
        

        foreground = new FlxGroup();

        add(foreground);
        layers.push(foreground);
        

        addLayer(AssetPaths.coolface__png, 1280, 724, 1.75);
    }

    public function getForegroundLayer():FlxGroup {
        return foreground;
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
