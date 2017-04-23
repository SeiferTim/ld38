package;

class Biome 
{

	public var id:String = "";
	public var x:Int = 0;
	public var y:Int = 0;
	public var env:Int = 0;
	public var temp:Float = 0;
	public var water:Float = 0;
	public var veg:Float = 0;
	public var population:Float = 0;
	public var species:Species = null;
	public var seen:Bool = false;
	public var owned:Bool = false;
	
	public function new(Id:String, Temp:Float, Water:Float, Veg:Float, X:Int, Y:Int)
	{
		id = Id;
		x = X;
		y = Y;
		temp = Temp;
		water = Water;
		veg = Veg;
		
		env = Data.getEnv(temp, water, veg);
		
		population = 0;
		
	}
	
	public function updatePop():Void
	{
		if (species != null)
		{
			var tDiff:Float = Math.abs(temp - species.temp);
			var wDiff:Float = Math.abs(water - species.water);
			var vDiff:Float = Math.abs(veg - species.veg);
			
			var av:Float = (.25 - ((tDiff + wDiff + vDiff) / 3)) * .25;
			//trace(tDiff, wDiff, vDiff, av);
			//trace(av);
			
			population = Math.min(1, population + av);
			
			//trace(population);
			
			if (population < .1)
			{
				population = 0;
				species = null;
				
			}
		}
	}
	
	
	
}