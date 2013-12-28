package com.animengine.frameworks.combat.ai.behavior {
	import com.animengine.core.creature.EnityView;
	import com.animengine.frameworks.combat.ai.action.ActionAtk;

	/**
	 * @author bright
	 * @version 20120514
	 */
	public class AtkBehavior extends AIBehavior {
		protected var _atk : ActionAtk;

		public function AtkBehavior(value : EnityView) {
			super(value);
			_name = "攻击";
			// _color = GColor.LIGHT_RED;
		}

		public function set atk(value : ActionAtk) : void {
			_atk = value;
		}

		override public function execute() : void {
			if (_isEnd) {
				return;
			}
			_view.action = _atk;
		}
	}
}
