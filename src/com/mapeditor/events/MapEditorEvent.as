/* 
	Eb163 Flash RPG Webgame Framework
	@author eb163.com
	@email game@eb163.com
	@website www.eb163.com
 */
package com.mapeditor.events
{
	import flash.events.Event;
	
	public class MapEditorEvent extends Event
	{
		public static const NEWMAPINFO_SUBMIT:String = "new_map_info_submit";//新地图信息提交
		public static const NEW_IMAGELIB_SUBMIT:String = "new_imageLib_submit";//新目录信息提交
//		public static const EDIT_BUILD_SUBMIT:String = "edit_build_submit";//编辑建筑
//		public static const EDIT_BUILD_COMP:String = "edit_build_comp";//编辑建筑
		
		private var _mapName:String;
		private var _mapWidth:Number;
		private var _mapHeight:Number;
		private var _cellWidth:Number;
		private var _cellHeight:Number;
		private var _mapImageFilePath:String;
		private var _newName:String;
		private var _mapSource:String;
		private var _loadType:String;
//		private var _nowBuildXML:XML;
		
		private var _sectionNumber:Number;
		private var _eachWidth:String;
		private var _preloadX:int;
		private var _preloadY:int;
		
		public function MapEditorEvent(type:String = null,bubbles:Boolean = false,cancelAble:Boolean = false)
		{
			var eventType:String = type||NEWMAPINFO_SUBMIT;
			super(type,bubbles,cancelAble);
		}
		
		public function get mapName():String{
			return _mapName;
		}
		
		public function set mapName(mapName:String):void{
			_mapName = mapName; 
		}
		
		public function get mapWidth():Number{
			return _mapWidth;
		}
		
		public function set mapWidth(mapWidth:Number):void{
			_mapWidth = mapWidth; 
		}
		
		public function get mapHeight():Number{
			return _mapHeight;
		}
		
		public function set mapHeight(mapHeight:Number):void{
			_mapHeight = mapHeight; 
		}
		
		public function get cellWidth():Number{
			return _cellWidth;
		}
		
		public function set cellWidth(cellWidth:Number):void{
			_cellWidth = cellWidth; 
		}
		
		public function get cellHeight():Number{
			return _cellHeight;
		}
		
		public function set cellHeight(cellHeight:Number):void{
			_cellHeight = cellHeight; 
		}
		
		public function get mapImageFilePath():String{
			return _mapImageFilePath;
		}
		
		public function set mapImageFilePath(mapImageFilePath:String):void{
			_mapImageFilePath = mapImageFilePath; 
		}
		
		public function get newName():String{
			return _newName;
		}
		
		public function set newName(newName:String):void{
			_newName = newName; 
		}
		
		public function get loadType():String{
			return _loadType;
		}
		
		public function set loadType(loadType:String):void{
			_loadType = loadType; 
		}
		public function get preloadX():int{
			return _preloadX;
		}
		
		public function set preloadX(val:int):void{
			_preloadX = val; 
		}
		
		public function get preloadY():int{
			return _preloadY;
		}
		
		public function set preloadY(val:int):void{
			_preloadY = val; 
		}
		public function get eachWidth():String
		{
			return _eachWidth;
		}

		public function set eachWidth(value:String):void
		{
			_eachWidth = value;
		}

		public function get sectionNumber():Number
		{
			return _sectionNumber;
		}

		public function set sectionNumber(value:Number):void
		{
			_sectionNumber = value;
		}

		public function get mapSource():String
		{
			return _mapSource;
		}

		public function set mapSource(value:String):void
		{
			_mapSource = value;
		}

		
	}
}