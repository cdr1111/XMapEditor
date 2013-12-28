package com.table
{
	import com.ultizen.game.engine.table.IConfiger;
	import com.ultizen.game.engine.table.TblManager;
	

	/**
	 * 全局配置文件初始化
	 * @author ******
	 *
	 */
	public class InitTbl implements IConfiger
	{
		protected var csvFiles:Array = 
			[
				{ Class : SQL_enemy_config },
				{ Class : SQL_npc_config },
//				{ Class : SQL_stage_config },
			];
		
		public function InitTbl( )
		{
		}
		public function initConfigers():void
		{
			var obj:Object;
			for( var i:int = 0; i < csvFiles.length; i++ )
			{
				obj = csvFiles[i];
				TblManager.Instance().Create(obj.Class, obj.Class.NAME);
			}
		}
	}
}

