package;
import flash.display.BitmapData;
import flash.geom.Point;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import markov.namegen.Generator;
import markov.namegen.NameGenerator;
using flixel.util.FlxSpriteUtil;

class Species
{

	public var portrait:FlxSprite;
	public var color:FlxColor;
	public var attack:Float = 0;
	public var defense:Float = 0;
	public var dexterity:Float = 0;
	public var temp:Float = 0;
	public var water:Float = 0;
	public var veg:Float = 0;
	public var name:String = "";

	public function new()
	{

		attack = FlxG.random.float(0, 1);
		defense = FlxG.random.float(0, 1);
		dexterity = FlxG.random.float(0, 1);
		temp = FlxG.random.float(0, 1);
		water = FlxG.random.float(0, 1);
		veg = FlxG.random.float(0, 1);

		var raceNo:Int = FlxG.random.int(0, 8);
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
		color = c;
		h += 180;
		while (h > 360)
			h -= 360;
		var cAlt:FlxColor = FlxColor.fromHSB(h, .5, .5, 1);

		back.framePixels.threshold(back.framePixels, back.framePixels.rect, new Point(), "==", 0xFFFF0000, c);

	/*	FlxG.bitmapLog.add(back.framePixels);
		FlxG.bitmapLog.add(fore.framePixels);
*/

		var gen:NameGenerator = new NameGenerator([
					"aardvark", "aardwolf", "albatross", "alligator", "alpaca", "anaconda", "angelfish", "anglerfish", "ant", "anteater", "antelope", "antlion", "ape", "aphid", "armadillo", "asp", "ass", "baboon",
					"badger", "baldeagle", "bandicoot", "barnacle", "barracuda", "basilisk", "bass", "bat", "bear", "beaver", "bedbug", "bee", "beetle", "bird", "bison", "blackbird", "blackpanther", "blackwidow",
					"bluebird", "bluejay", "bluewhale", "boa", "boar", "bobcat", "bonobo", "buffalo", "butterfly", "buzzard", "camel", "capybara", "caribou", "carp", "cat", "caterpillar", "catfish", "catshark",
					"centipede", "chameleon", "cheetah", "chickadee", "chicken", "chimpanzee", "chinchilla", "chipmunk", "clam", "clownfish", "cobra", "cockroach", "cod", "condor", "coral",
					"cougar", "cow", "coyote", "crab", "crane", "cranefly", "crayfish", "cricket", "crocodile", "crow", "cuckoo", "damselfly", "deer", "dingo", "dog", "dolphin", "donkey",
					"dormouse", "dove", "dragonfly", "duck", "dungbeetle", "eagle", "earthworm", "earwig", "echidna", "eel", "egret", "elephant", "elephantseal", "elk", "emu", "ermine", "falcon",
					"ferret", "finch", "firefly", "fish", "flamingo", "flea", "fly", "fowl", "fox", "frog", "fruitbat", "galliform", "gamefowl", "gazelle", "gecko", "gerbil", "giantpanda",
					"giantsquid", "gibbon", "giraffe", "goat", "goldfish", "goose", "gopher", "gorilla", "grasshopper", "grizzlybear", "groundshark", "groundsloth", "grouse", "guan", "guanaco",
					"guineafowl", "guineapig", "gull", "haddock", "halibut", "hammerheadshark", "hamster", "hare", "hawk", "hedgehog", "hermitcrab", "heron", "herring", "hippopotamus", "hornet",
					"horse", "hoverfly", "hummingbird", "humpbackwhale", "hyena", "iguana", "jackal", "jaguar", "jay", "jellyfish", "kangaroo", "kingfisher", "kiwi", "koala", "koi", "komodo",
					"krill", "ladybug", "lamprey", "lark", "leech", "lemming", "lemur", "leopard", "limpet", "lion", "lizard", "llama", "lobster", "locust", "loon", "louse", "lynx", "macaw",
					"mackerel", "magpie", "mammal", "manatee", "mantaray", "marmoset", "marmot", "meadowlark", "meerkat", "mink", "minnow", "mite", "mockingbird", "mole", "mollusk", "mongoose",
					"monitor", "monkey", "moose", "mosquito", "moth", "mouse", "mule", "narwhal", "newt", "nightingale", "octopus", "orangutan", "orca", "ostrich", "otter", "owl", "ox", "panda",
					"panther", "parakeet", "parrot", "partridge", "peacock", "peafowl", "pelican", "penguin", "perch", "peregrine", "pheasant", "pig", "pigeon", "pike", "piranha", "platypus",
					"polarbear", "pony","porcupine","porpoise","possum","prairiedog","prawn","prayingmantis","primate","puffin","puma","python","quail","rabbit","raccoon","rat","rattlesnake",
					"raven", "redpanda", "reindeer", "reptile", "rhinoceros", "roadrunner", "rodent", "rook", "rooster", "salamander", "salmon", "scorpion", "seahorse", "sealion", "seaslug",
					"seasnail",	"shark", "sheep", "shrew", "shrimp", "silkworm", "silverfish", "skink", "skunk", "sloth", "slug", "snail", "snake", "snipe", "sole", "sparrow", "spermwhale",
					"spider", "spidermonkey", "squid", "squirrel", "starfish", "stingray", "stoat", "stork", "swallow", "swan", "swift", "swordfish", "swordtail", "tarantula", "termite", "thrush",
					"tiger", "tigershark", "toad", "tortoise", "toucan", "treefrog", "trout", "tuna", "turkey", "turtle", "tyrannosaurus", "vampirebat", "viper", "vole", "vulture", "wallaby",
					"walrus", "wasp", "waterbuffalo", "weasel", "whale", "whitefish", "wildcat", "wildebeest", "wolf", "wolverine", "wombat", "woodpecker", "yak", "zebra",
					"axolotl", "olm", "dragon", "fire", "earth", "water", "air", "void", "sun", "tree", "cloud", "rock", "stone", "crystal", "ice",
					"amaranth", "amber", "amethyst", "apricot", "aquamarine", "azure", "babyblue", "beige", "black", "blue", "bluegreen", "blush", "bronze", "brown", "burgundy", "byzantium",
					"carmine", "cerise", "cerulean", "champagne", "chocolate", "cobaltblue", "coffee", "copper", "coral", "crimson", "cyan", "desertsand", "electricblue", "emerald",
					"erin", "gold", "gray", "green", "harlequin", "indigo", "ivory", "jade", "junglegreen", "lavender", "lemon", "lilac", "lime", "magenta", "magentarose", "maroon", "mauve",
					"navyblue", "ocher", "olive", "orange", "orchid", "peach", "pear", "periwinkle", "persianblue", "pink", "plum", "prussianblue", "puce", "purple", "raspberry", "red",
					"redviolet", "rose", "ruby", "salmon", "sangria", "sapphire", "scarlet", "silver", "slategray", "springbud", "springgreen", "tan", "taupe", "teal", "turquoise", "violet",
					"viridian", "white", "yellow"
				], 2, 0.001);
				
		name = null;
		while (name == null)
			name = gen.generateName(5, 16);
		var firstChar:String = name.substr(0, 1); 
		var restOfString:String = name.substr(1, name.length); 
    
		name = firstChar.toUpperCase() + restOfString.toLowerCase();
		
		
		portrait = new FlxSprite( );
		portrait.makeGraphic(26, 26, FlxColor.WHITE ,true, name);
		portrait.drawRect(1, 1, 24, 24, cAlt);
		portrait.stamp(back, 1, 1);
		portrait.stamp(fore, 1, 1);
		

		portrait.dirty = true;
	}

}