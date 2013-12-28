package com.table
{
	import com.ultizen.game.engine.table.TblItem;
	public class SQL_npc_config extends TblItem
	{
		public static const NAME:String = "npc_config";
		public var arrDefine:Array = ["npc_id","image_id","map_id","npc_name","npc_dialogue","npc_function"];
		public var npc_id:Number;
		public var image_id:String;
		public var map_id:int;
		public var npc_name:String;
		public var npc_dialogue:String;
		public var npc_function:int;
	}
}