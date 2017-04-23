package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.input.keyboard.FlxKey;
import flixel.text.FlxText;
import flixel.util.FlxColor;
using flixel.util.FlxSpriteUtil;

class GameOver extends FlxSubState
{

	public function new() 
	{
		super();
		
		var background:FlxSprite = new FlxSprite();
		background.makeGraphic(101, 65, FlxColor.TRANSPARENT);
		background.drawRoundRect(0, 0, 100, 64, 8, 8, FlxColor.BLACK, {thickness:1, color: FlxColor.WHITE});
		background.scrollFactor.set();
		background.screenCenter();
		add(background);
		
		var text:FlxText = new FlxText();
		text.text = "EXTINCTION!\n\nPress X Key";
		text.scrollFactor.set();
		text.screenCenter();
		add(text);
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (FlxG.keys.anyJustReleased([X]))
		{
			FlxG.resetGame();
		}
		
		super.update(elapsed);
	}
	
}