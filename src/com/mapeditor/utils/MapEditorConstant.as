/* 
	Eb163 Flash RPG Webgame Framework
	@author eb163.com
	@email game@eb163.com
	@website www.eb163.com
 */
package com.mapeditor.utils
{
	import flash.filesystem.File;
	
	public class MapEditorConstant
	{
		//地图格类型 空白低点 最后会根据设置 转换为相应不可移动或者可移动区域
		public static const CELL_TYPE_SPACE:int = -1;
		
		//地图格类型 路点
		public static const CELL_TYPE_ROAD:int = 0;
		//地图格类型 障碍
		public static const CELL_TYPE_HINDER:int = 1;
		//地图元件库图片目录
//		public static const COMPONENT_LIB_HOME:File  = File.documentsDirectory.resolvePath(MAIN_PATH + "resource/");
		//主目录
		public static const MAP_HOME:String = File.applicationDirectory.nativePath  +  "/../resource/data/maps/";
		//库图片路径
		public static const MAP_IMAGE_PATH:String = File.applicationDirectory.nativePath  +  "/../resource/images/maps/";
		//主路径
		public static const MAIN_PATH:String = "MapEdit/";
		//主路径
		public static const RESOURCE_PATH:String = "MapEdit/resource";
	}
}