package;
import flixel.util.FlxColor;
import openfl.Assets;

class Data 
{	
	
	public static var loaded:Bool = false;
	
	public static inline var BIO_TEMP:Int 			= 0;
	public static inline var BIO_WATER:Int 			= 1;
	public static inline var BIO_VEG:Int 			= 2;
	
	public static var Environments:Map<String, Int>;
	public static var EnvironmentNames:Map<Int, String>;
	public static var EnvironmentColors:Map<Int, FlxColor>;
	
	public static function loadEnvironments():Void
	{
		if (loaded)
			return;
		loaded = true;
		
		Environments = new Map<String, Int>();
		EnvironmentNames = new Map<Int, String>();
		EnvironmentColors = new Map<Int, FlxColor>();
		
		var biomeData:String = Assets.getText(AssetPaths.biomes__txt);
		var splitData:Array<String> = biomeData.split("\r\n");
		var splitSplit:Array<String>;
		
		for (i in 0...splitData.length)
		{
			splitSplit = splitData[i].split(",");
			Environments.set(splitSplit[0] + splitSplit[1] + splitSplit[2], i);
			EnvironmentNames.set(i, splitSplit[3]);
			EnvironmentColors.set(i, FlxColor.fromString("#" + splitSplit[4]));
		}
		
		
		
	}
	
	public static function getEnv(Temp:Float, Water:Float, Veg:Float):Int
	{
		var search:String="";
		
		if (Temp > .75)
			search = "1";
		else if (Temp >= .25 && Temp <= .75)
			search = "0";
		else if (Temp >= 0 && Temp < .25)
			search = "-1";
		
		if (Water > .75)
			search += "1";
		else if (Water >= .25 && Water <= .75)
			search += "0";
		else if (Water >= 0 && Water < .25)
			search += "-1";
		
		if (Veg > .75)
			search += "1";
		else if (Veg >= .25 && Veg <= .75)
			search += "0";
		else if (Veg >= 0 && Veg < .25)
			search += "-1";
			
		return Environments.get(search);
	}
	
	
}