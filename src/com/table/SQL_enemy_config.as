package com.table
{
	import com.ultizen.game.engine.table.TblItem;
	public class SQL_enemy_config extends TblItem
	{
		public static const NAME:String = "enemy_config";
		public var arrDefine:Array = ["enemy_id","image_id","enemy_name","type","camp","level","hp","hp_grow","physics_attack","physics_attack_grow","physics_defence","physics_defence_grow","skill_attack","skill_attack_grow","skill_defence","skill_defence_grow","skill_id","enemy_ai"];
		public var enemy_id:Number;
		public var image_id:String;
		public var enemy_name:String;
		public var type:int;
		public var camp:int;
		public var level:int;
		public var hp:int;
		public var hp_grow:int;
		public var physics_attack:int;
		public var physics_attack_grow:int;
		public var physics_defence:int;
		public var physics_defence_grow:int;
		public var skill_attack:int;
		public var skill_attack_grow:int;
		public var skill_defence:int;
		public var skill_defence_grow:int;
		public var skill_id:String;
		public var enemy_ai:String;
	}
}