package com.animengine.util{
	/**
	 * @author Sampson
	 */
	public class ArrayUtil {
		public static function split(content : String, spliter : String) : Array {
			if (!content || !spliter)
				return new Array();
			var result : Array = content.split(spliter);
			for (var i : int = 0; i < result.length; i++) {
				result[i] = parseInt(result[i]);
			}
			return result;
		}
	}
}
