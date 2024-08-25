package mobile;

import flixel.FlxG;
import flixel.system.scaleModes.BaseScaleMode;

/**
 * ...
 * @author: Karim Akra
 */
class MobileScaleMode extends BaseScaleMode
{
    public static var allowWideScreen(default, set):Bool = true;
    public static var allowBorderlessScreen(default, set):Bool = false; //Borderless Screen Test

    override function updateGameSize(Width:Int, Height:Int):Void
	{
        if(ClientPrefs.wideScreen && allowWideScreen)
        {
            super.updateGameSize(Width, Height);
        }
        else
        {
            var ratio:Float = FlxG.width / FlxG.height;
            var realRatio:Float = Width / Height;
    
            var scaleY:Bool = realRatio < ratio;
    
            if (scaleY)
            {
                gameSize.x = Width;
                if(!allowBorderlessScreen)
                    gameSize.y = Math.floor(gameSize.x / ratio);
                else
                    gameSize.y = Math.floor(gameSize.x = ratio);
            }
            else
            {
                gameSize.y = Height;
                if(!allowBorderlessScreen)
                    gameSize.x = Math.floor(gameSize.y * ratio);
                else
                    gameSize.x = Math.floor(gameSize.y = ratio);
            }
        }
	}

    override function updateGamePosition():Void
	{
        if(ClientPrefs.wideScreen && allowWideScreen)
		    FlxG.game.x = FlxG.game.y = 0;
        else
            super.updateGamePosition();
	}

    @:noCompletion
    private static function set_allowWideScreen(value:Bool):Bool
    {
        allowWideScreen = value;
        FlxG.scaleMode = new MobileScaleMode();
        return value;
    }
    private static function set_allowBorderlessScreen(value:Bool):Bool
    {
        allowBorderlessScreen = value;
        FlxG.scaleMode = new MobileScaleMode();
        return value;
    }
}