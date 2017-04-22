package;

import com.chargedweb.utils.MatrixUtil;
import flash.display.BitmapData;
import flash.geom.Point;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.input.FlxKeyManager;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.tile.FlxBaseTilemap.FlxTilemapAutoTiling;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import openfl.display.BitmapDataChannel;
import openfl.filters.ColorMatrixFilter;

class PlayState extends FlxState
{
	public var map:BitmapData;
	public var biomes:Array<Biome>;
	public var bigMap:FlxTilemap;
	public var camFocus:FlxSprite;
	
	override public function create():Void
	{
		
		Data.loadEnvironments();
		
		map = new BitmapData(40, 40, false, 0xff000000);
		map.perlinNoise(40, 40, 5,FlxG.random.int(), false, false, BitmapDataChannel.RED | BitmapDataChannel.BLUE | BitmapDataChannel.GREEN, false);
		map.applyFilter(map, map.rect, new Point(), MatrixUtil.setContrast((FlxG.random.int(0,5)*10)));
		
		FlxG.bitmapLog.add(map);
		
		var c:FlxColor;
		var b:Biome;
		var tmp:Float;
		var mapData:Array<Int> = [];
		
		biomes = new Array<Biome>();
		for (y in 0...40)
		{
			for (x in 0...40)
			{
				c = map.getPixel32(x, y);
				
				tmp = (Math.abs(y - 20) / 20);
				
				b = new Biome();
				b.temp = (c.redFloat + (1-tmp)) / 2;
				b.water = c.blueFloat;
				b.veg = c.greenFloat;
				b.env = Data.getEnv(b.temp, b.water, b.veg);
				mapData.push(b.env);
				map.setPixel32(x, y, Data.EnvironmentColors.get(b.env));
				
			}
		}
		
		FlxG.bitmapLog.add(map);
		
		bigMap = new FlxTilemap();
		bigMap.loadMapFromArray(mapData, 40, 40, AssetPaths.biomes__png, 24, 24,FlxTilemapAutoTiling.OFF,0,0,0);
		bigMap.x = 12;
		bigMap.y = 12;
		add(bigMap);
		
		
		camFocus = new FlxSprite();
		camFocus.makeGraphic(2, 2, FlxColor.RED);
		camFocus.screenCenter();
		add(camFocus);
		
		FlxG.camera.follow(camFocus, FlxCameraFollowStyle.TOPDOWN);
		FlxG.camera.setScrollBoundsRect(0, 0, 24 * 41, 24 * 41, true);
		
		var race:Species = new Species();
		
		race.portrait.scrollFactor.set();
		race.portrait.x = 8;
		race.portrait.y = 8;
		add(race.portrait);
		
		
		super.create();
	}
	

	private function updateCamMove(elapsed:Float):Void
	{
		var u:Bool = FlxG.keys.anyPressed([UP, W]);
		var d:Bool = FlxG.keys.anyPressed([DOWN, S]);
		var l:Bool = FlxG.keys.anyPressed([LEFT, A]);
		var r:Bool = FlxG.keys.anyPressed([RIGHT, D]);
		
		if (u && d)
			u = d = false;
		if (l && r)
			l = r = false;
		
		if (u)
			camFocus.y = Math.max(FlxG.height / 4, camFocus.y - (100 * elapsed));
		else if (d)
			camFocus.y = Math.min(FlxG.worldBounds.height - (FlxG.height / 4), camFocus.y + (100 * elapsed));
		
		if (l)
			camFocus.x = Math.max(FlxG.width / 4, camFocus.x - (100 * elapsed));
		else if (r)
			camFocus.x = Math.min(FlxG.worldBounds.width - (FlxG.width / 4), camFocus.x + (100 * elapsed));
			
	}
	

	override public function update(elapsed:Float):Void
	{
		updateCamMove(elapsed);
		
		super.update(elapsed);
		
	}
}
