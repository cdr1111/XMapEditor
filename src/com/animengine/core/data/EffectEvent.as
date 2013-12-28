package com.animengine.core.data{
	import com.animengine.core.creature.EnityView;
	
	import flash.events.Event;

	/**
	 * @author Sampson
	 */
	public class EffectEvent extends Event {
		public static const LAUNCH_EFFECT : String = "LAUNCH_EFFECT";
		public var launcher : EnityView;
		public var effects : Array;

		public function EffectEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}

		override public function clone() : Event {
			var e : EffectEvent = new EffectEvent(this.type);
			e.launcher = this.launcher;
			e.effects = this.effects;
			return e;
		}
	}
}
