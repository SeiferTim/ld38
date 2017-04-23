package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxGradient;
using flixel.util.FlxSpriteUtil;

class RaceUI extends FlxGroup
{

	public var x(default, set):Float;
	public var y(default, set):Float;

	public var race:Species;
	public var portrait:FlxSprite;
	private var background:FlxSprite;
	private var icons:Array<FlxSprite>;
	private var iconsOffsets:Array<FlxPoint>;
	private var bars:Array<FlxSprite>;
	private var barsOffsets:Array<FlxPoint>;
	private var notches:Array<FlxSprite>;
	private var notchesOffsets:Array<FlxPoint>;
	private var name:FlxText;
	private var nameOffset:FlxPoint;
	private var portraitOffset:FlxPoint;

	public var shown(default, set):Bool=true;

	public function new(Race:Species)
	{
		super();
		race = Race;
		background = new FlxSprite();
		background.makeGraphic(129, 81, FlxColor.TRANSPARENT);
		background.drawRoundRect(0, 0, 128, 80, 8, 8, FlxColor.BLACK, {thickness:1, color: FlxColor.WHITE});
		background.scrollFactor.set();
		add(background);

		portrait = race.portrait;
		portraitOffset = FlxPoint.get(2, 2);
		portrait.setPosition(portraitOffset.x, portraitOffset.y);
		portrait.scrollFactor.set();
		add(portrait);

		name = new FlxText();
		name.text = race.name;
		name.scrollFactor.set();
		nameOffset = FlxPoint.get(portraitOffset.x + portrait.width + 4, 4);
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
		i.animation.frameIndex = 4;
		iconsOffsets.push(FlxPoint.get( 4, portraitOffset.y+ portrait.height + 4));
		i.setPosition(iconsOffsets[0].x, iconsOffsets[0].y);
		i.scrollFactor.set();
		icons.push(i);
		add(i);

		var b:FlxSprite = new FlxSprite();
		b.makeGraphic(8, 24);
		FlxGradient.overlayGradientOnFlxSprite(b, 6, 22, [0xffff7f00, 0xff000000], 1, 1);
		b.scrollFactor.set();
		barsOffsets.push(FlxPoint.get(iconsOffsets[0].x + 4, iconsOffsets[0].y + icons[0].height + 2));
		b.setPosition(barsOffsets[0].x, barsOffsets[0].y);
		bars.push(b);
		add(b);

		var n:FlxSprite = new FlxSprite();
		n.loadGraphic(AssetPaths.notch__png);
		n.animation.frameIndex = 3;
		n.scrollFactor.set();
		notchesOffsets.push(FlxPoint.get(iconsOffsets[0].x, barsOffsets[0].y + 4 + (16 * (1-race.attack))));
		n.setPosition(notchesOffsets[0].x, notchesOffsets[0].y);
		notches.push(n);
		add(n);

		i = new FlxSprite();
		i.loadGraphic(AssetPaths.ui__png, true, 16, 16);
		i.animation.frameIndex = 5;
		iconsOffsets.push(FlxPoint.get(iconsOffsets[0].x + icons[0].width + 4, portraitOffset.y+ portrait.height + 4));
		i.setPosition(iconsOffsets[1].x, iconsOffsets[1].y);
		i.scrollFactor.set();
		icons.push(i);
		add(i);

		b = new FlxSprite();
		b.makeGraphic(8, 24);
		FlxGradient.overlayGradientOnFlxSprite(b, 6, 22, [0xff007fff, 0xff000000], 1, 1);
		b.scrollFactor.set();
		barsOffsets.push(FlxPoint.get(iconsOffsets[1].x + 4, iconsOffsets[1].y + icons[1].height + 2));
		b.setPosition(barsOffsets[1].x, barsOffsets[1].y);
		bars.push(b);
		add(b);

		n = new FlxSprite();
		n.loadGraphic(AssetPaths.notch__png);
		n.scrollFactor.set();
		notchesOffsets.push(FlxPoint.get(iconsOffsets[1].x, barsOffsets[1].y + 4 + (16 * (1-race.defense))));
		n.setPosition(notchesOffsets[1].x, notchesOffsets[1].y);
		notches.push(n);
		add(n);

		i = new FlxSprite();
		i.loadGraphic(AssetPaths.ui__png, true, 16, 16);
		i.animation.frameIndex = 6;
		iconsOffsets.push(FlxPoint.get(iconsOffsets[1].x + icons[1].width + 4, portraitOffset.y+ portrait.height +4));
		i.setPosition(iconsOffsets[2].x, iconsOffsets[2].y);
		i.scrollFactor.set();
		icons.push(i);
		add(i);

		b = new FlxSprite();
		b.makeGraphic(8, 24);
		FlxGradient.overlayGradientOnFlxSprite(b, 6, 22, [0xffff007f, 0xff000000], 1, 1);
		b.scrollFactor.set();
		barsOffsets.push(FlxPoint.get(iconsOffsets[2].x + 4, iconsOffsets[2].y + icons[2].height + 2));
		b.setPosition(barsOffsets[2].x, barsOffsets[2].y);
		bars.push(b);
		add(b);

		n = new FlxSprite();
		n.loadGraphic(AssetPaths.notch__png);
		n.scrollFactor.set();
		notchesOffsets.push(FlxPoint.get(iconsOffsets[2].x, barsOffsets[2].y + 4 + (16 * (1-race.dexterity))));
		n.setPosition(notchesOffsets[2].x, notchesOffsets[2].y);
		notches.push(n);
		add(n);

		i = new FlxSprite();
		i.loadGraphic(AssetPaths.ui__png, true, 16, 16);
		i.animation.frameIndex = 0;
		iconsOffsets.push(FlxPoint.get(iconsOffsets[2].x + icons[2].width + 4, portraitOffset.y+ portrait.height +4));
		i.setPosition(iconsOffsets[3].x, iconsOffsets[3].y);
		i.scrollFactor.set();
		icons.push(i);
		add(i);

		b = new FlxSprite();
		b.makeGraphic(8, 24);
		FlxGradient.overlayGradientOnFlxSprite(b, 6, 22, [0xffff0000, 0xff00ffff], 1, 1);
		b.scrollFactor.set();
		barsOffsets.push(FlxPoint.get(iconsOffsets[3].x + 4, iconsOffsets[3].y + icons[3].height + 2));
		b.setPosition(barsOffsets[3].x, barsOffsets[3].y);
		bars.push(b);
		add(b);

		n = new FlxSprite();
		n.loadGraphic(AssetPaths.notch__png);
		n.scrollFactor.set();
		notchesOffsets.push(FlxPoint.get(iconsOffsets[3].x, barsOffsets[3].y + 4 + (16 * (1-race.temp))));
		n.setPosition(notchesOffsets[3].x, notchesOffsets[3].y);
		notches.push(n);
		add(n);

		i = new FlxSprite();
		i.loadGraphic(AssetPaths.ui__png, true, 16, 16);
		i.animation.frameIndex = 1;
		iconsOffsets.push(FlxPoint.get(iconsOffsets[3].x + icons[3].width + 4, portraitOffset.y+ portrait.height +4));
		i.setPosition(iconsOffsets[4].x, iconsOffsets[4].y);
		i.scrollFactor.set();
		icons.push(i);
		add(i);

		b = new FlxSprite();
		b.makeGraphic(8, 24);
		FlxGradient.overlayGradientOnFlxSprite(b, 6, 22, [0xff0000ff, 0xffffff00], 1, 1);
		b.scrollFactor.set();
		barsOffsets.push(FlxPoint.get(iconsOffsets[4].x + 4, iconsOffsets[4].y + icons[4].height + 2));
		b.setPosition(barsOffsets[4].x, barsOffsets[4].y);
		bars.push(b);
		add(b);

		n = new FlxSprite();
		n.loadGraphic(AssetPaths.notch__png);
		n.scrollFactor.set();
		notchesOffsets.push(FlxPoint.get(iconsOffsets[4].x, barsOffsets[4].y + 4 + (16 * (1-race.water))));
		n.setPosition(notchesOffsets[4].x, notchesOffsets[4].y);
		notches.push(n);
		add(n);

		i = new FlxSprite();
		i.loadGraphic(AssetPaths.ui__png, true, 16, 16);
		i.animation.frameIndex = 2;
		iconsOffsets.push(FlxPoint.get(iconsOffsets[4].x + icons[4].width + 4, portraitOffset.y+ portrait.height +4));
		i.setPosition(iconsOffsets[5].x, iconsOffsets[5].y);
		i.scrollFactor.set();
		icons.push(i);
		add(i);

		b = new FlxSprite();
		b.makeGraphic(8, 24);
		FlxGradient.overlayGradientOnFlxSprite(b, 6, 22, [0xff00ff00, 0xffff00ff], 1, 1);
		b.scrollFactor.set();
		barsOffsets.push(FlxPoint.get(iconsOffsets[5].x + 4, iconsOffsets[5].y + icons[5].height + 2));
		b.setPosition(barsOffsets[5].x, barsOffsets[5].y);
		bars.push(b);
		add(b);

		n = new FlxSprite();
		n.loadGraphic(AssetPaths.notch__png);
		n.scrollFactor.set();
		notchesOffsets.push(FlxPoint.get(iconsOffsets[5].x, barsOffsets[5].y + 4 + (16 * (1-race.veg))));
		n.setPosition(notchesOffsets[5].x, notchesOffsets[5].y);
		notches.push(n);
		add(n);
		
		
		/*trace(race.attack);
		trace(race.defense);
		trace(race.dexterity);
		trace(race.temp);
		trace(race.water);
		trace(race.veg);*/
		
		shown = false;

	}

	private function set_x(Value:Float):Float
	{
		if (x != Value)
		{
			x = Value;
			background.x = x;
			portrait.x = portraitOffset.x + x;
			name.x = nameOffset.x + x;
			for (i in 0...icons.length)
			{
				icons[i].x = iconsOffsets[i].x + x;
				bars[i].x = barsOffsets[i].x + x;
				notches[i].x = notchesOffsets[i].x + x;
			}
		}

		return x;
	}

	private function set_y(Value:Float):Float
	{
		if (y != Value)
		{
			y = Value;
			background.y = y;
			portrait.y = portraitOffset.y + y;
			name.y = nameOffset.y + y;
			for (i in 0...icons.length)
			{
				icons[i].y = iconsOffsets[i].y + y;
				bars[i].y = barsOffsets[i].y + y;
				notches[i].y = notchesOffsets[i].y + y;
			}
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

		var vis:Bool = false;
		if (FlxG.mouse.overlaps(portrait))
		{
			vis = true;
		}
		shown = vis;
		
		super.update(elapsed);
	}

}