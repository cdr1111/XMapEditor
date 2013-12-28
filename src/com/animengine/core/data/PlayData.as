package com.animengine.core.data {
	/**
	 * @author flashpf
	 */
	public class PlayData {
		protected var _delay : int;
		protected var _frames : Array;
		protected var _loop : int;
		protected var _change : Function;
		protected var _complete : Function;

		public function PlayData(delay : int = 33, frames : Array = null, loop : int = 1) {
			_delay = delay;
			_frames = frames;
			_loop = loop;
		}

		public function get delay() : int {
			return _delay;
		}

		public function set frames(value : Array) : void {
			_frames = value;
		}

		public function get frames() : Array {
			return _frames;
		}

		public function get loop() : int {
			return _loop;
		}

		public function set change(value : Function) : void {
			_change = value;
		}

		public function get change() : Function {
			return _change;
		}

		public function set complete(value : Function) : void {
			_complete = value;
		}

		public function get complete() : Function {
			return _complete;
		}

		public function parseObj(value : Object) : void {
			_delay = (value.delay != null ? value.delay : 33);
			_frames = (value.frames != null ? value.frames : new Array());
			_loop = (value.loop != null ? value.loop : 1);
		}

		public function set delay(delay : int) : void {
			_delay = delay;
		}

		public function set loop(loop : int) : void {
			_loop = loop;
		}
	}
}
