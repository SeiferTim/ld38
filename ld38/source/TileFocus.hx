package;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
using flixel.util.FlxSpriteUtil;


class TileFocus extends FlxSprite 
{

	public var parent:PlayState;
	public var target:FlxPoint;
	
	public function new(Parent:PlayState) 
	{
		super();
		parent = Parent;
		loadGraphic(AssetPaths.selector__png);
		visible = false;
	}
	
	public function setTarget(X:Int, Y:Int):Void
	{
		target = FlxPoint.get(X, Y);
		visible = true;
		x = ((X + 1) * 24) - (width/2);
		y = ((Y + 1) * 24) - (height / 2);
		flicker(0, .2);
		parent.moveCamera(target);
	}
	
	public function clearTarget():Void
	{
		stopFlickering();
		visible = false;
		target.put();
		target = null;
	}
	
}