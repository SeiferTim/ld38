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
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import openfl.display.BitmapDataChannel;
import openfl.filters.ColorMatrixFilter;

class PlayState extends FlxState
{
	public var fog:FlxTilemap;
	public var fogData:Array<Int>;
	public var map:BitmapData;
	public var biomes:Map<String, Biome>;
	public var bigMap:FlxTilemap;
	public var camFocus:FlxSprite;
	public var raceUI:RaceUI;
	public var race:Species;
	public var playerControl:Bool = false;
	public var selector:TileFocus;
	public var biomeUI:BiomeUI;
	public var migrateFrom:String="";
	public var migrateTo:String = "";
	public var outIcon:FlxSprite;
	
	override public function create():Void
	{
		race = new Species();
		
		Data.loadEnvironments();
		
		map = new BitmapData(40, 40, false, 0xff000000);
		map.perlinNoise(40, 40, 5,FlxG.random.int(), false, false, BitmapDataChannel.RED | BitmapDataChannel.BLUE | BitmapDataChannel.GREEN, false);
		map.applyFilter(map, map.rect, new Point(), MatrixUtil.setContrast((FlxG.random.int(0,5)*10)));
		
		FlxG.bitmapLog.add(map);
		
		var c:FlxColor;
		var b:Biome;
		var tmp:Float;
		var mapData:Array<Int> = [];
		var home:FlxPoint = FlxPoint.get(FlxG.random.int(3, 37), FlxG.random.int(3, 37));
		
		biomes = new Map<String, Biome>();
		fogData = new Array<Int>();
		
		
		
		for (y in 0...40)
		{
			for (x in 0...40)
			{
				c = map.getPixel32(x, y);
				
				tmp = (Math.abs(y - 20) / 20);
				
				b = new Biome(Std.string(x) + "-" + Std.string(y), (c.redFloat + (1-tmp)) / 2, c.blueFloat, c.greenFloat, x, y);
				if (x == home.x && y == home.y)
				{
					b.population = .5;
					b.species = race;
					fogData.push(6);
					b.owned = true;
					b.seen = true;
				}
				else
				{
					if (FlxG.random.bool(30))
					{
						b.population =  FlxMath.bound( Math.abs(FlxG.random.floatNormal(0, 0.333)), 0, 1);
						if (b.population >= .1)
						{
							b.species = new Species();
							
						}
						else
							b.population = 0;
					}
					
					if ((((x == home.x -1 || x == home.x + 1)  && y == home.y ) || ((y == home.y - 1 || y == home.y + 1) && x == home.x)))
					{
						fogData.push(1);
						b.seen = true;
					}
					else
					{
						fogData.push(0);
					}
				}
				mapData.push(b.env);
				map.setPixel32(x, y, Data.EnvironmentColors.get(b.env));
				biomes.set(b.id, b);
				
			}
		}
		
		FlxG.bitmapLog.add(map);
		
		fog = new FlxTilemap();
		fog.loadMapFromArray(fogData, 40, 40, AssetPaths.fog__png, 24, 24, FlxTilemapAutoTiling.OFF, 0, 0, 0);
		fog.x = 12;
		fog.y = 12;
		
		
		bigMap = new FlxTilemap();
		bigMap.loadMapFromArray(mapData, 40, 40, AssetPaths.biomes__png, 24, 24,FlxTilemapAutoTiling.OFF,0,0,0);
		bigMap.x = 12;
		bigMap.y = 12;
		add(bigMap);
		add(fog);
		
		camFocus = new FlxSprite();
		camFocus.makeGraphic(2, 2, FlxColor.RED);
		camFocus.screenCenter();
		//add(camFocus);
		
		FlxG.camera.follow(camFocus, FlxCameraFollowStyle.TOPDOWN);
		FlxG.camera.setScrollBoundsRect(0, 0, 24 * 41, 24 * 41, true);
		
		raceUI = new RaceUI(race);
		
		biomeUI = new BiomeUI(this);
		
		var start:FlxPoint = getTileCenter(Std.int(home.x), Std.int(home.y));
		camFocus.x = start.x - 1;
		camFocus.y = start.y - 1;
		FlxG.camera.update(0);
		
		outIcon = new FlxSprite();
		outIcon.loadGraphic(AssetPaths.out_symbol__png);
		outIcon.visible = false;
		add(outIcon);
		
		selector = new TileFocus(this);
		selector.setTarget(Std.int(home.x), Std.int(home.y));
		add(selector);
		
		
		add(biomeUI);
		
		add(raceUI);
		
		popCycle(true);
		
		playerControl = true;
		
		super.create();
	}
	
	public function moveCamera(Dest:FlxPoint):Void
	{
		playerControl = false;
		var dest:FlxPoint = getTileCenter(Std.int(Dest.x), Std.int(Dest.y));
		dest.x--;
		dest.y--;
		
		if (biomeUI.shown)
		{
			if (dest.y >= biomeUI.y)
			{
				dest.y = biomeUI.y + Std.int((dest.y - biomeUI.y) / 2); 
			}
			else
			{
				dest.y = dest.y + Std.int(((biomeUI.y + biomeUI.background.height) - dest.y) / 2);
			}
		}
		
		FlxTween.linearMotion(camFocus, camFocus.x, camFocus.y, dest.x, dest.y, .33, true, {ease:FlxEase.sineInOut, onComplete: function(_) {
			playerControl = true;
		}});
	}
	
	
	public function getTileCenter(X:Int, Y:Int):FlxPoint
	{
		return FlxPoint.get(12 + (X * 24) + 12, 12 + (Y * 24) + 12);
	}

	private function updateCamMove(elapsed:Float):Void
	{
		if (playerControl)
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
	}
	
	public function showOutIcon(X:Int, Y:Int):Void
	{
		var d:FlxPoint = getTileCenter(X, Y);
		outIcon.x = d.x - 12;
		outIcon.y = d.y - 12;
		outIcon.visible = true;
	}
	
	public function hideOutIcon():Void
	{
		outIcon.visible = false;
	}
	
	public function migrate():Void
	{
		biomeUI.hide();
		var b1:Biome = biomes.get(migrateFrom);
		var b2:Biome = biomes.get(migrateTo);
		var p1:Float;
		var p2:Float;
		if (b2.owned)
		{
			p1 = b1.population / 2;
			p2 = b2.population;
			if (p2 + p1 > 1)
			{
				p1 = 1 - p2;
			}
			b2.population += p1;
			b1.population -= p1;
			revealSeen(b2.x, b2.y);
			popCycle();
		}
		else if (b2.population >= .1)
		{
			openSubState(new CombatUI(b1.species, b2.species, b1.population / 2, b2.population, returnFromCombat));
		}
		else
		{
			p1 = b1.population / 2;
			b1.population -= p1;
			b2.population = p1;
			b2.species = race;
			b2.owned = true;
			revealSeen(b2.x, b2.y);
			popCycle();
		}
		
	}
	
	public function revealSeen(X:Int, Y:Int):Void
	{
		var b3:Biome;
		if (X - 1 >= 0)
		{
			b3 = biomes.get(Std.string(X - 1) + "-" + Std.string(Y));
			b3.seen = true;
		}
		if (X + 1 < 40)
		{
			b3 = biomes.get(Std.string(X + 1) + "-" + Std.string(Y));
			b3.seen = true;
		}
		if (Y - 1 >= 0)
		{
			b3 = biomes.get(Std.string(X) + "-" + Std.string(Y-1));
			b3.seen = true;
		}
		if (Y + 1 < 40)
		{
			b3 = biomes.get(Std.string(X) + "-" + Std.string(Y+1));
			b3.seen = true;
		}
	}
	
	public function returnFromCombat(Winner:Int, EndPopW:Float, EndPopL:Float):Void
	{
		var b1:Biome = biomes.get(migrateFrom);
		var b2:Biome = biomes.get(migrateTo);
		
		if (Winner == 0)
		{
			b1.population -= (b1.population / 2);
			b2.owned = true;
			b2.species = race;
			b2.population = EndPopW;
			revealSeen(b2.x, b2.y);
		}
		else
		{
			b1.population -= (b1.population / 2);
			b2.population = EndPopL;
		}
		popCycle();
	}

	override public function update(elapsed:Float):Void
	{
		updateCamMove(elapsed);
		
		
		super.update(elapsed);
		
		if (playerControl)
		{
			if (FlxG.mouse.justReleased && FlxG.mouse.overlaps(bigMap))
			{
				var selected:FlxPoint = FlxPoint.get(Std.int((FlxG.mouse.x - 12) / 24), Std.int((FlxG.mouse.y - 12) / 24));
				
				var b:Biome = biomes.get(Std.string(selected.x) + "-" + Std.string(selected.y));
				if (b.seen)
					biomeUI.show(b);
				else
					biomeUI.hide();
				selector.setTarget(Std.int(selected.x), Std.int(selected.y));
			}
		}
		
		
	}
	
	public function popCycle(?isFirst:Bool = false):Void
	{
		migrateFrom = migrateTo = "";
		outIcon.visible = false;
		for (b in biomes)
		{
			if (!(isFirst && b.owned))
			{
				if (b.population > 0)
				{
					b.updatePop();
					if (b.owned && b.population == 0)
					{
						b.owned = false;
					}
				}
			}
			
		}
		if (!isFirst)
		{
			updateMaps();
		}
	}
	
	public function updateMaps():Void
	{
		var b:Biome;
		for (y in 0...40)
		{
			for (x in 0...40)
			{
				b = biomes.get(Std.string(x) + "-" + Std.string(y));
				
				if (b.seen)
				{
					if (b.owned)
					{
						fogData[(y * 40) + x] = Std.int((b.population * 10) + 1);
					}
					else
					{
						fogData[(y * 40) + x] = 1;
					}
				}
				else
				{
					fogData[(y * 40) + x] = 0;
				}
				fog.setTile(x, y, fogData[(y * 40) + x]);
			}
		}
	}
}
