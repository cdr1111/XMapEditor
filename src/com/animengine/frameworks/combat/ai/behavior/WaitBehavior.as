package com.animengine.frameworks.combat.ai.behavior {
	import com.animengine.core.creature.BaseActionType;
	import com.animengine.core.creature.EnityView;
	import com.animengine.frameworks.combat.ai.action.N_ActionType;

	/**
	 * @author bright
	 * @version 20111017
	 */
	public class WaitBehavior extends AIBehavior {
		public function WaitBehavior(value : EnityView) {
			super(value);
			_name = "休息";
			// _color = GColor.LIGHT_GREEN;
			_endTime = 30;
		}

		override public function start() : void {
			super.start();
			if (!_view.action || _view.actionType != BaseActionType.IDLE) {
				_view.actionType = BaseActionType.IDLE;
			}
		}

		override public function execute() : void {
			if (_isEnd) {
				return;
			}
			if (_count > _endTime) {
				end();
			}
			_count++;
		}
	}
}
