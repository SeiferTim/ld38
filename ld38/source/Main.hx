package;

import axollib.DissolveState;
import flixel.FlxG;
import flixel.FlxGame;
import openfl.Lib;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		FlxG.autoPause = false;
		addChild(new FlxGame(240, 180, DissolveState));
	}
}
