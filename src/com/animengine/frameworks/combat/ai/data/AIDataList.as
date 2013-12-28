package com.animengine.frameworks.combat.ai.data {
	import flash.utils.Dictionary;

	/**
	 * @author flashpf
	 */
	public class AIDataList {
		private static var _hards : Dictionary = new Dictionary();
		private static var _ranks : Dictionary = new Dictionary();
		private static var _traits : Dictionary = new Dictionary();
		private static var _levelCost : AIData = new AIData();

//		private static function parseHards(value : Array) : void {
//			var cost : AIData;
//			for each (var item:Object in value) {
//				cost = new AIData();
//				cost.parseObj(item);
//				_hards[HardType.getType(item.hardName)] = cost;
//			}
//		}
//
//		private static function parseRank(value : Array) : void {
//			var cost : AIData;
//			for each (var item:Object in value) {
//				cost = new AIData();
//				cost.parseObj(item);
//				_ranks[RankType.getType(item.rankName)] = cost;
//			}
//		}
//
//		private static function parseTrait(value : Array) : void {
//			var cost : AIData;
//			for each (var item:Object in value) {
//				cost = new AIData();
//				cost.parseObj(item);
//				_traits[TraitType.getType(item.traitName)] = cost;
//			}
//		}
//
//		private static function parseLevel(value : Object) : void {
//			_levelCost.parseObj(value);
//		}
//
//		public static function parseObj(value : Object) : void {
//			parseHards(value.hards);
//			parseRank(value.rank);
//			parseTrait(value.trait);
//			parseLevel(value.level[0]);
//		}
//
//		public static function initData(cost : AIData, data : MonsterData, hard : int) : void {
//			cost.reset();
//			var hardCost : AIData = _hards[hard];
//			cost.add(hardCost);
//			var rankCost : AIData = _ranks[data.rankType];
//			cost.add(rankCost);
//			var traitCost : AIData = _traits[data.traitType];
//			cost.add(traitCost);
//			cost.add(_levelCost, data.level / 5);
//		}
	}
}
