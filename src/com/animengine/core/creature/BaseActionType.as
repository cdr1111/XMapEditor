package com.animengine.core.creature {
	/**
	 * @author Sampson
	 */
	public class BaseActionType {
		public static const NULL : uint = 0;
		public static const  IDLE : uint = 1;
		public static const  WALK : uint = 2;
		public static const  RUN : uint = 3;
		public static const  FALL_DOWN : uint = 4;
		//		public static const  GET_UP : uint = 5;
		public static const  ATK : uint = 6;
		public static const  JUMP : uint = 7;
		public static const  RUN_ATK : uint = 8;
		public static const  BE_HIT : uint = 9;
		public static const  AIR : uint = 10;
		public static const  DROP : uint = 11;
		public static const  BOUNCE : uint = 12;
		public static const  STAND : uint = 13;
		public static const  DEAD : uint = 14;
		public static const  SKILL_1 : uint = 15;
		public static const  SKILL_2 : uint = 16;
		public static const  SKILL_3 : uint = 17;
		public static const  SKILL_4 : uint = 18;
		public static const  SKILL_5 : uint = 19;
		public static const  SKILL_6 : uint = 20;
		public static const  JUMP_ATK : uint = 21;
		
		public static const  SUPER_SKILL : uint = 22;//法阵
		
		public static const ATKS : Array = [ATK, JUMP, RUN_ATK, SKILL_1, SKILL_2, SKILL_3, SKILL_4, SKILL_5, SKILL_6, JUMP_ATK];
		
		// 9-beHit被击
		// 10-air击飞（空中上升)
		// 11-drop空中掉落
		// 12-bounce掉落后反弹
		// 13-stand起身
		// 14-dead死亡
		
		
		
		public static const CHANGE_DIR:uint = 23;
		
		
		public static function isAtk(type : uint) : Boolean {
			return ATKS.indexOf(type) >= 0;
		}
	}
}
