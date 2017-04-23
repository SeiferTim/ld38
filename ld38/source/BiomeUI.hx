package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxGradient;
using flixel.util.FlxSpriteUtil;

class BiomeUI extends FlxGroup 
{
	public var x(default, set):Float;
	public var y(default, set):Float;
	private var background:FlxSprite;
	private var icons:Array<FlxSprite>;
	private var iconsOffsets:Array<FlxPoint>;
	private var bars:Array<FlxSprite>;
	private var barsOffsets:Array<FlxPoint>;
	private var notches:Array<FlxSprite>;
	private var notchesOffsets:Array<FlxPoint>;
	private var name:FlxText;
	private var nameOffset:FlxPoint;
	public var shown(default, set):Bool = true;
	public var parent:PlayState;
	public var migrateOut:FlxSprite;
	public var migrateIn:FlxSprite;
	public var migrateOutOffset:FlxPoint;
	public var migrateInOffset:FlxPoint;
	public var picked:FlxPoint;

	public function new(Parent:PlayState) 
	{
		super();
		
		parent = Parent;
		
		background = new FlxSprite();
		background.makeGraphic(65, 85, FlxColor.TRANSPARENT);
		background.drawRoundRect(0, 0, 64, 84, 8, 8, FlxColor.BLACK, {thickness:1, color: FlxColor.WHITE});
		//background.scrollFactor.set();
		add(background);
		
		name = new FlxText();
		name.text = "";
		//name.scrollFactor.set();
		nameOffset = FlxPoint.get(4, 4);
		name.setPosition(nameOffset.x, nameOffset.y);
		add(name);
		
		icons = [];
		iconsOffsets = [];
		bars = [];
		barsOffsets = [];
		notches = [];
		notchesOffsets = [];
		
		var i:FlxSprite = new FlxSprite();
		i.loadGraphic(AssetPaths.ui__png, true, 16, 16);
		i.animation.frameIndex = 0;
		iconsOffsets.push(FlxPoint.get( 4, nameOffset.y+ name.height + 4));
		i.setPosition(iconsOffsets[0].x, iconsOffsets[0].y);
		//i.scrollFactor.set();
		icons.push(i);
		add(i);

		var b:FlxSprite = new FlxSprite();
		b.makeGraphic(8, 24);
		FlxGradient.overlayGradientOnFlxSprite(b, 6, 22, [0xffff0000, 0xff00ffff], 1, 1);
		//b.scrollFactor.set();
		barsOffsets.push(FlxPoint.get(iconsOffsets[0].x + 4, iconsOffsets[0].y + icons[0].height + 2));
		b.setPosition(barsOffsets[0].x, barsOffsets[0].y);
		bars.push(b);
		add(b);

		var n:FlxSprite = new FlxSprite();
		n.loadGraphic(AssetPaths.notch__png);
		//n.scrollFactor.set();
		notchesOffsets.push(FlxPoint.get(iconsOffsets[0].x, barsOffsets[0].y + 4 + (16 * 0)));
		n.setPosition(notchesOffsets[0].x, notchesOffsets[0].y);
		notches.push(n);
		add(n);

		i = new FlxSprite();
		i.loadGraphic(AssetPaths.ui__png, true, 16, 16);
		i.animation.frameIndex = 1;
		iconsOffsets.push(FlxPoint.get(iconsOffsets[0].x + icons[0].width + 4, nameOffset.y+ name.height + 4));
		i.setPosition(iconsOffsets[1].x, iconsOffsets[1].y);
		//i.scrollFactor.set();
		icons.push(i);
		add(i);

		b = new FlxSprite();
		b.makeGraphic(8, 24);
		FlxGradient.overlayGradientOnFlxSprite(b, 6, 22, [0xff0000ff, 0xffffff00], 1, 1);
		//b.scrollFactor.set();
		barsOffsets.push(FlxPoint.get(iconsOffsets[1].x + 4, iconsOffsets[1].y + icons[1].height + 2));
		b.setPosition(barsOffsets[1].x, barsOffsets[1].y);
		bars.push(b);
		add(b);

		n = new FlxSprite();
		n.loadGraphic(AssetPaths.notch__png);
		//n.scrollFactor.set();
		notchesOffsets.push(FlxPoint.get(iconsOffsets[1].x, barsOffsets[1].y + 4 + (16 * 0)));
		n.setPosition(notchesOffsets[1].x, notchesOffsets[1].y);
		notches.push(n);
		add(n);

		i = new FlxSprite();
		i.loadGraphic(AssetPaths.ui__png, true, 16, 16);
		i.animation.frameIndex = 2;
		iconsOffsets.push(FlxPoint.get(iconsOffsets[1].x + icons[1].width + 4, nameOffset.y+ name.height +4));
		i.setPosition(iconsOffsets[2].x, iconsOffsets[2].y);
		//i.scrollFactor.set();
		icons.push(i);
		add(i);

		b = new FlxSprite();
		b.makeGraphic(8, 24);
		FlxGradient.overlayGradientOnFlxSprite(b, 6, 22, [0xff00ff00, 0xffff00ff], 1, 1);
		//b.scrollFactor.set();
		barsOffsets.push(FlxPoint.get(iconsOffsets[2].x + 4, iconsOffsets[2].y + icons[2].height + 2));
		b.setPosition(barsOffsets[2].x, barsOffsets[2].y);
		bars.push(b);
		add(b);

		n = new FlxSprite();
		n.loadGraphic(AssetPaths.notch__png);
		//n.scrollFactor.set();
		notchesOffsets.push(FlxPoint.get(iconsOffsets[2].x, barsOffsets[2].y + 4 + (16 * 0)));
		n.setPosition(notchesOffsets[2].x, notchesOffsets[2].y);
		notches.push(n);
		add(n);
		
		migrateOut = new FlxSprite();
		migrateOut.loadGraphic(AssetPaths.migrate_buttons__png, true, 16, 16);
		migrateOut.animation.frameIndex = 0;
		migrateOutOffset = FlxPoint.get(4, bars[0].y + bars[0].height + 2);
		migrateOut.x = migrateOutOffset.x;
		migrateOut.y = migrateOutOffset.y;
		add(migrateOut);
		
		migrateIn = new FlxSprite();
		migrateIn.loadGraphic(AssetPaths.migrate_buttons__png, true, 16, 16);
		migrateIn.animation.frameIndex = 1;
		migrateInOffset = FlxPoint.get(background.width - 20, bars[0].y + bars[0].height + 2);
		migrateIn.x = migrateInOffset.x;
		migrateIn.y = migrateInOffset.y;
		add(migrateIn);
		
		shown = false;
	}
	
	private function set_x(Value:Float):Float
	{
		if (x != Value)
		{
			x = Value;
			background.x = x;
			name.x = nameOffset.x + x;
			for (i in 0...icons.length)
			{
				icons[i].x = iconsOffsets[i].x + x;
				bars[i].x = barsOffsets[i].x + x;
				notches[i].x = notchesOffsets[i].x + x;
			}
			migrateIn.x = migrateInOffset.x + x;
			migrateOut.x = migrateOutOffset.x + x;
		}

		return x;
	}

	private function set_y(Value:Float):Float
	{
		if (y != Value)
		{
			y = Value;
			background.y = y;
			name.y = nameOffset.y + y;
			for (i in 0...icons.length)
			{
				icons[i].y = iconsOffsets[i].y + y;
				bars[i].y = barsOffsets[i].y + y;
				notches[i].y = notchesOffsets[i].y + y;
			}
			migrateIn.y = migrateInOffset.y + y;
			migrateOut.y = migrateOutOffset.y + y;
		}
		return y;
	}

	private function set_shown(Value:Bool):Bool
	{
		if (shown != Value)
		{
			shown = Value;
			background.visible = shown;
			name.visible = shown;
			for (i in 0...icons.length)
			{
				icons[i].visible = shown;
				bars[i].visible = shown;
				notches[i].visible = shown;
			}
		}
		return shown;
	}

	override public function update(elapsed:Float):Void
	{

		if (migrateOut.visible)
		{
			if (FlxG.mouse.overlaps(migrateOut))
			{
				migrateOut.animation.frameIndex = 2;
				if (FlxG.mouse.justReleased)
				{
					
					parent.migrateFrom = Std.string(picked.x) + "-" + Std.string(picked.y);
					parent.migrateTo = "";
					parent.showOutIcon(Std.int(picked.x), Std.int(picked.y));
					FlxG.mouse.reset();
				}
				
			}
			else
				migrateOut.animation.frameIndex = 0;
		}
		
		if (migrateIn.visible)
		{
			if (FlxG.mouse.overlaps(migrateIn))
			{
				migrateIn.animation.frameIndex = 3;
				if (FlxG.mouse.justReleased)
				{
					parent.migrateTo = Std.string(picked.x) + "-" + Std.string(picked.y);
					FlxG.mouse.reset();
				}
			}
			else
				migrateIn.animation.frameIndex = 1;
		}
		
		super.update(elapsed);
	}

	public function show(B:Biome):Void
	{
		
		picked = FlxPoint.get(B.x, B.y);
		
		name.text = Data.EnvironmentNames.get(B.env);
		notchesOffsets[0].y =  barsOffsets[0].y + 4 + (16 * (1-B.temp));
		notchesOffsets[1].y =  barsOffsets[1].y + 4 + (16 * (1-B.water));
		notchesOffsets[2].y =  barsOffsets[2].y + 4 + (16 * (1-B.veg));
		
		var tile:FlxPoint = parent.getTileCenter(B.x, B.y);
		var d:FlxPoint = FlxPoint.get(tile.x - (background.width/2), tile.y - 14 - background.height);
		if (d.x < 0)
		{
			d.x = 0;
		}
		else if (d.x > FlxG.worldBounds.width - background.width)
		{
			d.x = FlxG.worldBounds.width - background.width;
		}
		if (d.y < 0)
		{
			d.y = tile.y + 14;
		}
		
		x = d.x;
		y = d.y;
		
		migrateIn.visible = migrateOut.visible = false;
		
		if (B.owned)
			migrateOut.visible = true;
		
		if (B.seen && parent.migrateFrom != "")
		{
			var to:Biome = parent.biomes.get(parent.migrateFrom);
			if (((to.x == B.x - 1 || to.x == B.x + 1) && to.y == B.y) || ((to.y == B.y -1 || to.y == B.y + 1) && to.x == B.x))
			{
				migrateIn.visible = true;
			}
		}
		
		shown = true;
	}
	
	public function hide():Void
	{
		shown = false;
		migrateIn.visible = migrateOut.visible = false;
	}
}