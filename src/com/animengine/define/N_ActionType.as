package com.animengine.define {

	/**
	 * 动作状态类型
	 * 
	 * @author bright
	 * @version 20120419
	 */
	public final class N_ActionType {
		private static var _list : Array = ["呼吸", "战斗呼吸", "行走", "跑动", "跑攻", "飞行", "跳跃", "跳攻", "后退", "浮空", "掉落", "反弹", "站起", "被吸", "死亡", "攻击", "连击_0", "连击_1", "连击_2", "射击", "滚击", "砸地"];
		public static const NONE : int = -1;
		public static const BREATHE : int = 0;
		public static const COMBAT_BREATHE : int = 1;
		public static const WALK : int = 2;
		public static const RUN : int = 3;
		public static const RUN_ATK : int = 4;
		public static const FLY : int = 5;
		public static const JUMP : int = 6;
		public static const JUMP_ATK : int = 7;
		public static const BACK : int = 8;
		public static const AIR : int = 9;
		public static const DROP : int = 10;
		public static const BOUNCE : int = 11;
		public static const STAND : int = 12;
		public static const SUCKED : int = 13;
		public static const DEAD : int = 14;
		public static const ATK : int = 15;
		public static const LINK_0 : int = 16;
		public static const LINK_1 : int = 17;
		public static const LINK_2 : int = 18;
		public static const SHOOT : int = 19;
		public static const ROLL_ATK : int = 20;
		public static const ATK_FLOOR : int = 21;

		public static function getType(value : String) : int {
			var type : int = _list.indexOf(value);
			if (type == -1) {
				type = N_SkillType.getType(value);
			}
			return type;
		}

		public static function getName(value : int) : String {
			if (_list[value] != null) {
				return _list[value];
			} else {
				return N_SkillType.getName(value);
			}
		}

		public static function isLinkAtk(type : int) : Boolean {
			if (type == LINK_0) {
				return true;
			} else if (type == LINK_1) {
				return true;
			} else if (type == LINK_2) {
				return true;
			}
			return false;
		}
	}
}
