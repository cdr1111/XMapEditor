package com.resManager
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author
	 */
	public class MSG 
	{
		/**
		 *单利句柄
		 */
		private static var instance:MSG = null;
		/**
		 * 是否完成了消息呼叫
		 */
		private var lock:Boolean=true;
		/**
		 * 移除列表
		 */
		private var delist:Object = { };
		/**
		 * 是否需要清理
		 */
		private var isDel:Boolean = false;
		/**
		 * 实体句柄
		 */
		private var handle:Dictionary = null;
		
		public function MSG(access:Private) 
		{
			if(access==null)
			{
					throw new Error("not access the Class");
			}
			handle = new Dictionary(true);
		}
		/**
		 *获取实例 
		 * @return 
		 */
		public static function getinstance():MSG
		{
			if (instance==null)
			{
				instance=new MSG(new Private());
			}
			return instance;
		}
		/**
		 * 监听消息
		 * @param       msg 消息名
		 * @param       action  处理方法
		 * @param       tag 单通道触发标签
		 * @param       mode 是否接收消息
		 */
		public function listens(msg:String,action:Function,tag:*=null,mode:Boolean=true):void
		{
			if(handle[msg]==undefined){
				handle[msg]=[{call:action,mode:mode,del:false,tag:tag}];
				return;
			}
			for(var i:int=0;i<handle[msg].length;i++){
				if(handle[msg][i].call==action) return;
			}
			handle[msg].push({call:action,mode:mode,del:false,tag:tag});
		}
		/**
		 * 派遣消息
		 * @param       msg 消息名
		 * @param       tag 单通道标签
		 * @param       ... rest 参数
		 */
		public function dispatch(msg:String,tag:*=null,... rest):void
		{
			if (handle[msg] == undefined || handle[msg].length<=0) return;
			lock = false;
			for(var i:int=0;i<handle[msg].length;i++)
			{
				if (tag == null)
				{
					if (handle[msg][i].mode && handle[msg][i].del == false && handle[msg][i].tag == null) handle[msg][i].call.apply(NaN, rest);
				}else {
					if (handle[msg][i].mode && handle[msg][i].del == false && handle[msg][i].tag == tag) {
						rest.push(tag);
						handle[msg][i].call.apply(NaN, rest);
					}
				}
			}
			lock = true;
			if (isDel) clear();
			
		}
		/**
		 * 移除消息
		 * @param       msg
		 */
		public function remove(msg:String,action:Function):void
		{
			if (handle[msg] == undefined) return;
			if(handle[msg].length>0){
				for(var i:int=0;i<handle[msg].length;i++){
					if(handle[msg][i].call==action)
					{
						handle[msg][i].mode = false;
						handle[msg][i].del = true;
						break;
					}
				}
			}
			if (lock == false) {
				isDel = true;
				delist[msg] = null;
				return;
			}
			clear();
		}
		public function clear():void
		{
			var key:String = "";
			for (key in delist) {
				if (handle[key] == null || handle[key].length <= 0) continue;
				for (var $i:int = 0; $i < handle[key].length; $i++ ) {
					if (handle[key][$i].del) {
						handle[key][$i].tag = null;
						handle[key][$i].call = null;
						delete handle[key][$i].del;
						delete handle[key][$i].mode;
						delete handle[key][$i].call;
						delete handle[key][$i].tag;
						handle[key][$i] = null;
						handle[key].splice($i, 1);
						$i--;
					}
				}
				if (handle[key].length == 0) {
					handle[key] = null;
					delete handle[key]
				}
				delete delist[key];
			}
		}
	}

}class Private{}