package com.animengine.define {

	/**
	 * @author flashpf
	 */
	public class N_SkillType {
		public static const BACK_JUMP : int = 110100;
		public static const UPPER_SLASH : int = 110101;
		public static const DEVIL_SLASH : int = 110102;
		public static const GORE_CROSS : int = 110103;
		public static const HILL_BREAKER : int = 110104;
		public static const IN_DEVIL_ESCRIME : int = 111103;
		public static const IN_DEVIL_ESCRIME_1 : int = 1111031;
		public static const IN_DEVIL_ESCRIME_2 : int = 1111032;
		public static const IN_DEVIL_ESCRIME_3 : int = 1111033;
		public static const BLOODLUST : int = 111201;

		public static function getType(value : String) : int {
			var type : int;
			switch(value) {
				case "后跳":
					type = BACK_JUMP;
					break;
				case "上挑":
					type = UPPER_SLASH;
					break;
				case "鬼斩":
					type = DEVIL_SLASH;
					break;
				case "十字斩":
					type = GORE_CROSS;
					break;
				case "崩山":
					type = HILL_BREAKER;
					break;
				case "里鬼":
					type = IN_DEVIL_ESCRIME;
					break;
				case "里鬼_1":
					type = IN_DEVIL_ESCRIME_1;
					break;
				case "里鬼_2":
					type = IN_DEVIL_ESCRIME_2;
					break;
				case "里鬼_3":
					type = IN_DEVIL_ESCRIME_3;
					break;
				case "噬魂手":
					type = BLOODLUST;
					break;
				default:
					type = N_ActionType.NONE;
					break;
			}
			return type;
		}

		public static function getName(type : int) : String {
			var name : String;
			switch(type) {
				case BACK_JUMP:
					name = "后跳";
					break;
				case UPPER_SLASH:
					name = "上挑";
					break;
				case DEVIL_SLASH:
					name = "鬼斩";
					break;
				case GORE_CROSS:
					name = "十字斩";
					break;
				case HILL_BREAKER:
					name = "崩山";
					break;
				case IN_DEVIL_ESCRIME:
					name = "里鬼";
					break;
				case IN_DEVIL_ESCRIME_1:
					name = "里鬼_1";
					break;
				case IN_DEVIL_ESCRIME_2:
					name = "里鬼_2";
					break;
				case IN_DEVIL_ESCRIME_3:
					name = "里鬼_3";
					break;
				case BLOODLUST:
					name = "噬魂手";
					break;
			}
			return name;
		}

		public static function isDevilLink(type : int) : Boolean {
			if (type == IN_DEVIL_ESCRIME) {
				return true;
			}
			if (type == IN_DEVIL_ESCRIME_1) {
				return true;
			}
			if (type == IN_DEVIL_ESCRIME_2) {
				return true;
			}
			return false;
		}
	}
}
