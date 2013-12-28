package com.animengine.frameworks.combat.ai.behavior {
	import com.animengine.core.creature.EnityView;

	import flash.events.EventDispatcher;

	/**
	 * AI动作
	 * 
	 * @author wingox
	 * @version 20120418
	 */
	public class AIBehavior extends EventDispatcher {
		protected var _view : EnityView;
		protected var _name : String;
		protected var _color : int;
		protected var _count : uint;
		protected var _endTime : int;
		protected var _isEnd : Boolean;
		protected var _state : uint;

		public function AIBehavior(value : EnityView) : void {
			_view = value;
			_isEnd = false;
			init();
		}

		public function get name() : String {
			return _name;
		}

		public function get color() : uint {
			return _color;
		}

		protected function init() : void {
		}

		public function set endTime(value : int) : void {
			_endTime = value;
		}

		public function start() : void {
			_isEnd = false;
			_count = 0;
		}

		public function execute() : void {
//			throw new LogError("AIAction.execute:execute is abstract!");
		}

		public function end() : void {
			_isEnd = true;
		}

		public function get isEnd() : Boolean {
			return _isEnd;
		}

		public function dispose() : void {
		}
	}
}
