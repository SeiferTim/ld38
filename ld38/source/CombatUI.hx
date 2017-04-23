package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxGradient;
using flixel.util.FlxSpriteUtil;

class CombatUI extends FlxSubState 
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
	private var names:FlxText;
	private var namesOffset:FlxPoint;
	public var portraits:Array<FlxSprite>;
	public var portraitsOffsets:Array<FlxPoint>;
	public var result:FlxText;
	public var resultOffset:FlxPoint;
	public var button:FlxSprite;
	public var buttonOffset:FlxPoint;
	public var combatIcons:Array<FlxSprite>;
	public var combatOffsets:Array<FlxPoint>;
	public var races:Array<Species>;
	public var pops:Array<Float>;
	
	private var timer:Float = 0;
	private var step:Int = 0;
	private var attacker:Int = -1;
	private var defender:Int = -1;
	
	public var returnCallback:Int->Float->Float->Void;
	
	public function new(RaceA:Species, RaceB:Species, PopA:Float, PopB:Float, Callback:Int->Float->Float->Void) 
	{
		super();
		
		returnCallback = Callback;
		
		if (RaceA.name == "")
			RaceA.makeNameAndPortrait();
			
		if (RaceB.name == "")
			RaceB.makeNameAndPortrait();
			
		races = [RaceA, RaceB];
		pops = [PopA, PopB];
		
		background = new FlxSprite();
		background.makeGraphic(201, 101, FlxColor.TRANSPARENT);
		background.drawRoundRect(0, 0, 200, 100, 8, 8, FlxColor.BLACK, {thickness:1, color: FlxColor.WHITE});
		background.scrollFactor.set();
		add(background);
		
		names = new FlxText();
		names.text = races[0].name + " vs " + races[1].name;
		
		names.width = background.width - 8;
		names.scrollFactor.set();
		namesOffset = FlxPoint.get(4, 4);
		names.setPosition(namesOffset.x, namesOffset.y);
		add(names);
		
		
		portraits = [];
		portraitsOffsets = [];
		combatIcons = [];
		combatOffsets = [];
		
		var p:FlxSprite = new FlxSprite();
		p.loadGraphicFromSprite(races[0].portrait);
		portraitsOffsets.push(FlxPoint.get(20, namesOffset.y + names.height + 2));
		p.scrollFactor.set();
		p.setPosition(portraitsOffsets[0].x, portraitsOffsets[0].y);
		portraits.push(p);
		add(p);
		
		var c:FlxSprite = new FlxSprite();
		c.loadGraphic(AssetPaths.combat_icons__png, true, 32, 32);
		c.scrollFactor.set();
		c.visible = false;
		combatOffsets.push(FlxPoint.get(portraitsOffsets[0].x + (portraits[0].width / 2) - (c.width / 2), portraitsOffsets[0].y + (portraits[0].height / 2) - (c.height / 2)));
		c.setPosition(combatOffsets[0].x, combatOffsets[0].y);
		combatIcons.push(c);
		add(c);
		
		p = new FlxSprite();
		p.loadGraphicFromSprite(races[1].portrait);
		portraitsOffsets.push(FlxPoint.get(background.width - 46, namesOffset.y + names.height + 2));
		p.scrollFactor.set();
		p.setPosition(portraitsOffsets[1].x, portraitsOffsets[1].y);
		portraits.push(p);
		add(p);
		
		c = new FlxSprite();
		c.loadGraphic(AssetPaths.combat_icons__png, true, 32, 32);
		c.scrollFactor.set();
		c.visible = false;
		combatOffsets.push(FlxPoint.get(portraitsOffsets[1].x + (portraits[1].width / 2) - (c.width / 2), portraitsOffsets[1].y + (portraits[1].height / 2) - (c.height / 2)));
		c.setPosition(combatOffsets[1].x, combatOffsets[1].y);
		combatIcons.push(c);
		add(c);
		
		icons = [];
		iconsOffsets = [];
		bars = [];
		barsOffsets = [];
		notches = [];
		notchesOffsets = [];

		var i:FlxSprite = new FlxSprite();
		i.loadGraphic(AssetPaths.ui__png, true, 16, 16);
		i.animation.frameIndex = 4;
		iconsOffsets.push(FlxPoint.get( 4, portraitsOffsets[0].y+ portraits[0].height + 4));
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
		notchesOffsets.push(FlxPoint.get(iconsOffsets[0].x, barsOffsets[0].y + 4 + (16 * (1-races[0].attack))));
		n.setPosition(notchesOffsets[0].x, notchesOffsets[0].y);
		notches.push(n);
		add(n);

		i = new FlxSprite();
		i.loadGraphic(AssetPaths.ui__png, true, 16, 16);
		i.animation.frameIndex = 5;
		iconsOffsets.push(FlxPoint.get(iconsOffsets[0].x + icons[0].width + 4, portraitsOffsets[0].y+ portraits[0].height + 4));
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
		notchesOffsets.push(FlxPoint.get(iconsOffsets[1].x, barsOffsets[1].y + 4 + (16 * (1-races[0].defense))));
		n.setPosition(notchesOffsets[1].x, notchesOffsets[1].y);
		notches.push(n);
		add(n);

		i = new FlxSprite();
		i.loadGraphic(AssetPaths.ui__png, true, 16, 16);
		i.animation.frameIndex = 6;
		iconsOffsets.push(FlxPoint.get(iconsOffsets[1].x + icons[1].width + 4, portraitsOffsets[0].y+ portraits[0].height +4));
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
		notchesOffsets.push(FlxPoint.get(iconsOffsets[2].x, barsOffsets[2].y + 4 + (16 * (1-races[0].dexterity))));
		n.setPosition(notchesOffsets[2].x, notchesOffsets[2].y);
		notches.push(n);
		add(n);
		
		b = new FlxSprite();
		b.makeGraphic(8, 24);
		FlxGradient.overlayGradientOnFlxSprite(b, 6, 22, [0xffffff00, 0xffff0000], 1, 1);
		b.scrollFactor.set();
		barsOffsets.push(FlxPoint.get(barsOffsets[2].x + bars[2].width + 12, barsOffsets[2].y));
		b.setPosition(barsOffsets[3].x, barsOffsets[3].y);
		bars.push(b);
		add(b);

		n = new FlxSprite();
		n.loadGraphic(AssetPaths.notch__png);
		n.scrollFactor.set();
		notchesOffsets.push(FlxPoint.get(barsOffsets[3].x-4, barsOffsets[3].y + 4 + (16 * (1-pops[0]))));
		n.setPosition(notchesOffsets[3].x, notchesOffsets[3].y);
		notches.push(n);
		add(n);
		
		b = new FlxSprite();
		b.makeGraphic(8, 24);
		FlxGradient.overlayGradientOnFlxSprite(b, 6, 22, [0xffffff00, 0xffff0000], 1, 1);
		b.scrollFactor.set();
		barsOffsets.push(FlxPoint.get(barsOffsets[3].x + bars[3].width + 48, barsOffsets[3].y));
		b.setPosition(barsOffsets[4].x, barsOffsets[4].y);
		bars.push(b);
		add(b);

		n = new FlxSprite();
		n.loadGraphic(AssetPaths.notch__png);
		n.scrollFactor.set();
		notchesOffsets.push(FlxPoint.get(barsOffsets[4].x-4, barsOffsets[4].y + 4 + (16 * (1-pops[1]))));
		n.setPosition(notchesOffsets[4].x, notchesOffsets[4].y);
		notches.push(n);
		add(n);
		
		i = new FlxSprite();
		i.loadGraphic(AssetPaths.ui__png, true, 16, 16);
		i.animation.frameIndex = 4;
		iconsOffsets.push(FlxPoint.get(barsOffsets[4].x + bars[4].width + 8, portraitsOffsets[0].y+ portraits[0].height + 4));
		i.setPosition(iconsOffsets[0].x, iconsOffsets[0].y);
		i.scrollFactor.set();
		icons.push(i);
		add(i);

		b = new FlxSprite();
		b.makeGraphic(8, 24);
		FlxGradient.overlayGradientOnFlxSprite(b, 6, 22, [0xffff7f00, 0xff000000], 1, 1);
		b.scrollFactor.set();
		barsOffsets.push(FlxPoint.get(iconsOffsets[3].x + 4, iconsOffsets[3].y + icons[3].height + 2));
		b.setPosition(barsOffsets[5].x, barsOffsets[5].y);
		bars.push(b);
		add(b);

		n = new FlxSprite();
		n.loadGraphic(AssetPaths.notch__png);
		n.animation.frameIndex = 3;
		n.scrollFactor.set();
		notchesOffsets.push(FlxPoint.get(iconsOffsets[3].x, barsOffsets[5].y + 4 + (16 * (1-races[1].attack))));
		n.setPosition(notchesOffsets[5].x, notchesOffsets[5].y);
		notches.push(n);
		add(n);

		i = new FlxSprite();
		i.loadGraphic(AssetPaths.ui__png, true, 16, 16);
		i.animation.frameIndex = 5;
		iconsOffsets.push(FlxPoint.get(iconsOffsets[3].x + icons[3].width + 4, portraitsOffsets[0].y+ portraits[0].height + 4));
		i.setPosition(iconsOffsets[4].x, iconsOffsets[4].y);
		i.scrollFactor.set();
		icons.push(i);
		add(i);

		b = new FlxSprite();
		b.makeGraphic(8, 24);
		FlxGradient.overlayGradientOnFlxSprite(b, 6, 22, [0xff007fff, 0xff000000], 1, 1);
		b.scrollFactor.set();
		barsOffsets.push(FlxPoint.get(iconsOffsets[4].x + 4, iconsOffsets[4].y + icons[4].height + 2));
		b.setPosition(barsOffsets[6].x, barsOffsets[6].y);
		bars.push(b);
		add(b);

		n = new FlxSprite();
		n.loadGraphic(AssetPaths.notch__png);
		n.scrollFactor.set();
		notchesOffsets.push(FlxPoint.get(iconsOffsets[4].x, barsOffsets[6].y + 4 + (16 * (1-races[1].defense))));
		n.setPosition(notchesOffsets[6].x, notchesOffsets[6].y);
		notches.push(n);
		add(n);

		i = new FlxSprite();
		i.loadGraphic(AssetPaths.ui__png, true, 16, 16);
		i.animation.frameIndex = 6;
		iconsOffsets.push(FlxPoint.get(iconsOffsets[4].x + icons[4].width + 4, portraitsOffsets[0].y+ portraits[0].height +4));
		i.setPosition(iconsOffsets[5].x, iconsOffsets[5].y);
		i.scrollFactor.set();
		icons.push(i);
		add(i);

		b = new FlxSprite();
		b.makeGraphic(8, 24);
		FlxGradient.overlayGradientOnFlxSprite(b, 6, 22, [0xffff007f, 0xff000000], 1, 1);
		b.scrollFactor.set();
		barsOffsets.push(FlxPoint.get(iconsOffsets[5].x + 4, iconsOffsets[5].y + icons[5].height + 2));
		b.setPosition(barsOffsets[7].x, barsOffsets[7].y);
		bars.push(b);
		add(b);

		n = new FlxSprite();
		n.loadGraphic(AssetPaths.notch__png);
		n.scrollFactor.set();
		notchesOffsets.push(FlxPoint.get(iconsOffsets[5].x, barsOffsets[7].y + 4 + (16 * (1-races[1].dexterity))));
		n.setPosition(notchesOffsets[7].x, notchesOffsets[7].y);
		notches.push(n);
		add(n);
		
		x = (FlxG.width / 2) - (background.width / 2);
		y = (FlxG.height / 2) - (background.height / 2);
		
		timer = 1;
		step = 0;
		
	}
	
	private function set_x(Value:Float):Float
	{
		if (x != Value)
		{
			x = Value;
			background.x = x;
			for (i in 0...portraits.length)
			{
				portraits[i].x = portraitsOffsets[i].x + x;
			}
			names.x = Std.int(x + (background.width/2) - (names.width/2));
			for (i in 0...icons.length)
			{
				icons[i].x = iconsOffsets[i].x + x;
				
			}
			for (i in 0...bars.length)
			{
				bars[i].x = barsOffsets[i].x + x;
				notches[i].x = notchesOffsets[i].x + x;
			}
			for (i in 0...combatIcons.length)
			{
				combatIcons[i].x = combatOffsets[i].x + x;
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
			for (i in 0...portraits.length)
			{
				portraits[i].y = portraitsOffsets[i].y + y;
			}
			names.y = namesOffset.y + y;
			for (i in 0...icons.length)
			{
				icons[i].y = iconsOffsets[i].y + y;
				
			}
			for (i in 0...bars.length)
			{
				bars[i].y = barsOffsets[i].y + y;
				notches[i].y = notchesOffsets[i].y + y;
			}
			for (i in 0...combatIcons.length)
			{
				combatIcons[i].y = combatOffsets[i].y + y;
			}
		}
		return y;
	}

	
	
	override public function update(elapsed:Float):Void 
	{
		timer -= elapsed;
		if (timer <= 0)
		{
			
		
			switch (step) 
			{
				case 0: // who's turn? pop * dex >
					if (races[0].dexterity * pops[0] >= races[1].dexterity * pops[1])
					{
						attacker = 0;
						defender = 1;
					}
					else
					{
						attacker = 1;
						defender = 0;
					}
					
					// first race attacks, we show results, then we wait a second before continuing
					
					attack(attacker, defender);
					
					timer = 2;
					step = 1;
				case 1:
					combatIcons[defender].visible = false;
					
					if (pops[defender] >= .1)
					{
						// the defending player is still alive, they attack back...
						attack(defender, attacker);
						timer = 2;
						step = 2;
					}
					else
					{
						// the attacker defeated the defender!
						combatIcons[defender].animation.frameIndex = 1;
						combatIcons[defender].visible = true;
						timer = 3;
						step = 3;
					}
					
				case 2:
					combatIcons[attacker].visible = false;
					if (pops[attacker] >= .1)
					{
						// we keep going!
						step = 0;
					}
					else
					{
						// attacker has been defeated!
						combatIcons[attacker].animation.frameIndex = 1;
						combatIcons[attacker].visible = true;
						timer = 3;
						step = 3;
					}
				case 3:
					//...and we're done!
					var w:Int = pops[0] > pops[1] ? 0 : 1;
					var l:Int = pops[0] > pops[1] ? 1 : 0;
					closeCallback = returnCallback.bind(w, pops[w], pops[l]);
					close();
					
				default:
					
			}
		
		}
		super.update(elapsed);
	}
	
	private function attack(Attacker:Int, Defender:Int):Void
	{
		var dmg:Float = Math.max(.1, (((races[Attacker].attack + pops[Attacker]) / 2) * .5) - (((races[Defender].defense + pops[Defender]) / 2) * .5));
		pops[Defender] = Math.max(0,pops[defender] - dmg);
		combatIcons[Defender].animation.frameIndex = 0;
		combatIcons[Defender].visible = true;
		FlxG.camera.shake(0.01, 0.1);
		notchesOffsets[3 + Defender].y = barsOffsets[2].y + 4 + (16 * (1 - pops[Defender]));
		
		
		notches[3 + Defender].y = notchesOffsets[3 + Defender].y + y;
	}
	
}