package com.animengine.core.data{
	import com.animengine.frameworks.combat.hit.N_AtkHit;
	
	import flash.geom.Point;

	/**
	 * @author Sampson
	 */
	public class EffectData {
		public var id : uint;
		public var loop : uint;
		public var type : uint;
//		public var srcID : uint;
		public var frame : uint;
		public var moveTime : uint;
		public var moveSpeed : Point;
		public var moveWithLauncherFlip : Boolean;
		public var layer : String;
		public var hit : N_AtkHit;
	}
}
