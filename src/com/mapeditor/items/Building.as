/* 
	Eb163 Flash RPG Webgame Framework
	@author eb163.com
	@email game@eb163.com
	@website www.eb163.com
 */
package com.mapeditor.items
{
	import com.animengine.core.animation.BitmapAnimation;
	/**
	 *笔刷 
	 * @author mzhou
	 * 
	 */	
	public class Building extends BaseDisplayObject
	{
		private var _id:int;
		public var _dispAnm:BitmapAnimation;
		public var imgId:int;
		public var index:int = 0;
		public var type:int = 0;
		public var source:String;
		public var tId:String;
		public function Building(pid:int)
		{
			_id = pid;
		}
		private function loadComplete():void
		{
		}
		public function reset(dispAnm:BitmapAnimation):void{
			if(numChildren > 0)
				removeChildAt(0);
			if(null == dispAnm) return;
			
			_dispAnm = dispAnm.clone();
			if(!contains(_dispAnm))
				addChild(_dispAnm);
		}
		public function get id():int
		{
			return _id;
		}

		public function set id(value:int):void
		{
			_id = value;
		}
	}
}