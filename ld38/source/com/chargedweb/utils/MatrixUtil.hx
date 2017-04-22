////////////////////////////////////////////////////////////////////////////////
//
//  Copyright 2010 Julius Loa | jloa@chargedweb.com
//  All Rights Reserved.
//  license: GNU {http://www.opensource.org/licenses/gpl-2.0.php}
//  notice: just keep the header plz
//
////////////////////////////////////////////////////////////////////////////////

package com.chargedweb.utils;

import flash.filters.ColorMatrixFilter;

/**
 * Matrix utility class
 * @version 1.0
 * so far added:
 * - brightness
 * - contrast
 * - saturation
 */
class MatrixUtil
{
	/**
	 * sets brightness value available are -100 ~ 100 @default is 0
	 * @param 		value:int	brightness value
	 * @return		ColorMatrixFilter
	 */
	public static function setBrightness(value:Float):ColorMatrixFilter
	{
		value = value*(255/250);
		
		var m:Array<Float> = new Array<Float>();
		m = m.concat([1, 0, 0, 0, value]);	// red
		m = m.concat([0, 1, 0, 0, value]);	// green
		m = m.concat([0, 0, 1, 0, value]);	// blue
		m = m.concat([0, 0, 0, 1, 0]);		// alpha
		
		return new ColorMatrixFilter(m);
	}
	
	/**
	 * sets contrast value available are -100 ~ 100 @default is 0
	 * @param 		value:int	contrast value
	 * @return		ColorMatrixFilter
	 */
	public static function setContrast(value:Float):ColorMatrixFilter
	{
		value /= 100;
		var s:Float = value + 1;
		var o:Float = 128 * (1 - s);
		
		var m:Array<Float> = new Array<Float>();
		m = m.concat([s, 0, 0, 0, o]);	// red
		m = m.concat([0, s, 0, 0, o]);	// green
		m = m.concat([0, 0, s, 0, o]);	// blue
		m = m.concat([0, 0, 0, 1, 0]);	// alpha
		
		return new ColorMatrixFilter(m);
	}
	
	/**
	 * sets saturation value available are -100 ~ 100 @default is 0
	 * @param 		value:int	saturation value
	 * @return		ColorMatrixFilter
	 */
	public static function setSaturation(value:Float):ColorMatrixFilter
	{
		var lumaR:Float = 0.212671;
		var lumaG:Float = 0.71516;
		var lumaB:Float = 0.072169;
		
		var v:Float = (value/100) + 1;
		var i:Float = (1 - v);
		var r:Float = (i * lumaR);
		var g:Float = (i * lumaG);
		var b:Float = (i * lumaB);
		
		var m:Array<Float> = new Array<Float>();
		m = m.concat([(r + v), g, b, 0, 0]);	// red
		m = m.concat([r, (g + v), b, 0, 0]);	// green
		m = m.concat([r, g, (b + v), 0, 0]);	// blue
		m = m.concat([0, 0, 0, 1, 0]);			// alpha
		
		return new ColorMatrixFilter(m);
	}
}

