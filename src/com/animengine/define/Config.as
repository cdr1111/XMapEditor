package com.animengine.define {
	import animengine.core.KeySets;
	import com.animengine.core.creature.BaseActionType;
	
	import flash.filesystem.File;

	/**
	 * @author Sampson
	 */
	public class Config {
		public static const resPath : String = File.applicationDirectory.nativePath +  "/resource/";
		
		public static const swfPath : String = resPath + "runtime\\";
//				public static const swfPath : String = resPath + "runtime\\";
		public static const imageScaleRate : Number = 1;
		
		
		public static const BOX_TYPE_HIT:int = 0;//碰撞
//		public static const BOX_TYPE_BODY:int = 1;//身体
		public static const BOX_TYPE_FOCUS:int = 1;//重心
		
		public static const SET_TYPE_BASE:int = 0;//基础
		public static const SET_TYPE_ACT:int = 1;//动作
//				
//		public static function getTypeStr(type:int):String
//		{
//			switch(type)
//			{
//				case BaseActionType.ATK:
//					return "攻击";
//				case BaseActionType.FALL_DOWN:
//					return "跌倒";
//				case BaseActionType.GET_UP:
//					return "浮空";
//				case BaseActionType.JUMP_ATK:
//					return "跳跃";
//				case BaseActionType.IDLE:
//					return "站立";
//				case BaseActionType.WALK:
//					return "行走";
//				case BaseActionType.RUN:
//					return "跑步";
//			}
//			return "呼吸";
//		}
	}
}
