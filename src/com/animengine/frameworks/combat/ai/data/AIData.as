package com.animengine.frameworks.combat.ai.data {
	/**
	 * @author flashpf
	 */
	public class AIData {
		public var atkCost : int;
		public var againAtkCost : int;
		public var seekCost : int;
		public var moveCost : int;
		public var counterAtkCost : int;
		public var seekEndTime : int;
		public var seeX : int;
		public var seeY : int;

		public function reset() : void {
			atkCost = 0;
			againAtkCost = 0;
			seekCost = 0;
			moveCost = 0;
			counterAtkCost = 0;
			seekEndTime = 0;
			seeX = 0;
			seeY = 0;
		}

		public function add(value : AIData, ratio : int = 1) : void {
			atkCost += value.atkCost * ratio;
			againAtkCost += value.againAtkCost * ratio;
			seekCost += value.seekCost * ratio * ratio;
			moveCost += value.moveCost * ratio;
			counterAtkCost += value.counterAtkCost * ratio;
			seekEndTime += value.seekEndTime * ratio;
			seeX += value.seeX * ratio;
			seeY += value.seeY * ratio;
		}

		public function parseObj(value : Object) : void {
			atkCost = value.atkCost;
			againAtkCost = value.againAtkCost;
			seekCost = value.seekCost;
			moveCost = value.moveCost;
			counterAtkCost = value.counterAtkCost;
			seekEndTime = value.seekEndTime;
			seeX += value.seeX;
			seeY += value.seeY;
		}
	}
}
