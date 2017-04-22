package;
import flash.display.BitmapData;
import flash.geom.Point;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
using flixel.util.FlxSpriteUtil;

class Species
{

	public var portrait:FlxSprite;
	public var level:Int = 0;
	public var attack:Float = 0;
	public var defense:Float = 0;
	public var dexterity:Float = 0;
	public var temp:Float = 0;
	public var water:Float = 0;
	public var veg:Float = 0;

	public function new()
	{

		attack = FlxG.random.float(0, 1);
		defense = FlxG.random.float(0, 1);
		dexterity = FlxG.random.float(0, 1);
		temp = FlxG.random.float(0, 1);
		water = FlxG.random.float(0, 1);
		veg = FlxG.random.float(0, 1);
		
		var raceNo:Int = FlxG.random.int(0, 3);
		var back:FlxSprite = new FlxSprite();
		back.loadGraphic(AssetPaths.race_backs__png, true, 24, 24);
		back.animation.frameIndex = raceNo;
		
		var fore:FlxSprite = new FlxSprite();
		fore.loadGraphic(AssetPaths.race_tops__png, true, 24, 24);
		fore.animation.frameIndex = raceNo;
		
		back.updateFramePixels();
		fore.updateFramePixels();
		var h:Float = FlxG.random.float(0, 360);
		var c:FlxColor = FlxColor.fromHSB(h, 1, 1, 1);
		h += 180;
		while (h > 360)
			h -= 360;
		var cAlt:FlxColor = FlxColor.fromHSB(h, .5, .5, 1);
		
		back.framePixels.threshold(back.framePixels, back.framePixels.rect, new Point(), "==", 0xFFFF0000, c);
		
		FlxG.bitmapLog.add(back.framePixels);
		FlxG.bitmapLog.add(fore.framePixels);
		
		portrait = new FlxSprite();
		portrait.makeGraphic(26, 26, FlxColor.WHITE);
		portrait.drawRect(1, 1, 24, 24, cAlt);
		portrait.stamp(back, 1, 1);
		portrait.stamp(fore, 1, 1);
		
		portrait.dirty = true;
		
		

	}
	
	

}