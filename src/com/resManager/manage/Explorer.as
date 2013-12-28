package com.resManager.manage
{
	
	import com.resManager.MSG;
	import com.resManager.com.loading.BulkLoader;
	import com.resManager.com.loading.BulkProgressEvent;
	import com.resManager.com.loading.loadingtypes.LoadingItem;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	/**
	 * 资源管理器
	 * ...
	 * @author
	 */
	public class Explorer 
	{
		/**
		 * 消息--加载完成
		 */
		public static const EXPLORER_COMPLETE:String="explorer_complete";
		/**
		 *全局载完成
		 */
		public static const EXPLORER_FRIST_INIT:String = "explorer_frist_init";
		/**
		 * 超级列表加载完成
		 */
		public static const EXPLORER_SUPER_INIT:String = "explorer_super_init";
        
        public static const EXPLORER_QUEUE_LOADED_COMPLETE:String = 'explorer_queue_loaded_complete';
        
		/**
		 * 文件加载完成
		 */
		public static const LOADER_COMPLETE:String = "loader_complete";
		/**
		 * 组项加载完成
		 */
		public static const EXPLORER_GROUP_ITEM_COMPLETE:String = "explorer_group_item_complete";
		/**
		 * 组加载完成
		 */
		public static const EXPLORER_GROUP_COMPLETE:String = "explorer_group_complete";
		/**
		 * 当前加载进度
		 */
		public static const EXPLORER_LOAD_PROGRESS:String = "explorer_load_progress";
		/**
		 * 全局加载进度
		 */
		public static const EXPLORER_ALL_LOAD_PROGRESS:String = "explorer_all_load_progress";
		/**
		 * 选择后的服务器IP
		 */
		public static var serverip:String = "../../../client/resource";
		/**
		 * 当前HTTP域
		 */
		private var http:String;
		/**
		 *单利句柄
		 */
		private static var instance:Explorer = null;
		
		//加載工具
		private var _loader:BulkLoader = new BulkLoader( "Loader" );
		/**
		 * 是否初始化状态
		 */
		private var isinit:Boolean=false;
		private var _config:XML;
		/**
		 *加载列表 
		 */
		private var loadList:Array=[];
		/**
		 * 加载key
		 */
		private var loadKey:Object={};
		/**
		 *betimes列表
		 */
		private var runTimesList:Object={};
		/**
		 * 是否已经列表格式化
		 */
		private var islistFormat:Boolean=false;
		/**
		 *当前加载的对象句柄 
		 */
//		private var lObj:Object;
		/**
		 * 是否再加载
		 */
		private var isRun:Boolean=false;
		/**
		 *资源集合 
		 */
		private var resources:Object={};
		/**
		 * 是否已加载完优先队列
		 */
		private var isFrist:Boolean=false;
		/**
		 * 是否已加载config
		 */
		private var isConfig:Boolean=false;
		/**
		 * 是否组模式
		 */
		private var isGroup:Boolean = false;
		/**
		 * 加载的总数量
		 */
		private var count:int = 0;
		/**
		 * 当前剩余数量
		 */
		private var currentCount:int = 0;
		
		private var superTopList:Array = [];
		
		private var isSuper:Boolean = false;
        
        private var _queueLoader:Dictionary;

		public function Explorer(access:Private)
		{
			if(access == null)
			{
				throw new Error("not access the Class");
			}
		}
		/**
		 * 获取实例
		 */
		public static function getinstance():Explorer
		{
			if ( instance == null )
			{
				instance=new Explorer(new Private());
			}
			return instance;	
		}
		/**
		 * 初始化
		 */
		public function init():void
		{
			if(isinit) return;
			isinit=true;
            _queueLoader = new Dictionary();
		}
		/**
		 * 启动资源管理器
		 */
		public function start( ):void
		{
			init();

			http = "../../resource";
			serverip = "../../resource";
			var configPath:String = "../../resource/config.xml";
			if(serverip!=="")
			{
				var item:LoadingItem = addItem( configPath, BulkLoader.TYPE_TEXT );
				item.addEventListener( Event.COMPLETE, doRun, false, 0, true);
				_loader.start();
			}
		}
		
		//public static const context:LoaderContext = new LoaderContext(false, new ApplicationDomain(ApplicationDomain.currentDomain));
		private function addItem(path:String, _type:String, _id:String = null, _preventCache:Boolean = true):LoadingItem
		{
//			var loaderContext : LoaderContext = new LoaderContext(false, new ApplicationDomain(ApplicationDomain.currentDomain));
//			loaderContext.allowCodeImport = false;
//			loaderContext.allowLoadBytesCodeExecution = true;
			return _loader.add(path,{id: _id, type:_type, preventCache:_preventCache /*, context:loaderContext*/});
		}
//		/**
//		 * 专门提供给其他编辑器使用的
//		 * 启动资源管理器
//		 */
//		public function LoadItem(id:String = ""):void
//		{
//			var configPath:String = "../../";
//			if(id!=="")
//			{
//				var item:LoadingItem = _loader.add( configPath+id, { type:BulkLoader.TYPE_MOVIECLIP, preventCache:true } );
//				_loader.addEventListener(BulkProgressEvent.COMPLETE, doOver);
//				_loader.start();
//			}
//		}
//		private function doOver(evt:BulkProgressEvent):void
//		{
//			_loader.removeEventListener(BulkProgressEvent.COMPLETE, doOver);
//			MSG.getinstance().dispatch("completeOver1");
//		}
		
		/**
		 * 专门提供给其他编辑器使用的
		 * 启动资源管理器
		 */
		public function appointPathToLoad(configPath:String = ""):void
		{
			init();
			if(configPath!=="")
			{
				serverip = configPath;
				var item:LoadingItem = addItem( configPath+"/config.xml", BulkLoader.TYPE_TEXT);
				item.addEventListener( Event.COMPLETE, doRun, false, 0, true);
				_loader.start();
			}
		}

		/**
		 * 启动加载
		 * @param db 加载的数据
		 */
		private function doRun(evt:Event):void
		{
			if(isConfig==false)
			{
				isConfig = true;
				var item:LoadingItem = evt.target as LoadingItem;
//				var byteArr:ByteArray = item.content;
//				byteArr.uncompress();
				_config = new XML(item.content);
				// 初始化xml配置文件
				listFormat();
				addFirstList();
			}
		}
		/**
		 * 列表格式化
		 * 
		 */
		private function listFormat():void
		{
			var temxml:XMLList = null;
			var i:int=0;
			if(islistFormat==false){
//				temxml = config.top.children();
//				for(i=0;i<temxml.length();i++)
//				{
//					if (temxml[i].@id.toString() == "ipconfig")
//					{
//						superTopList.push(	{
//									id:temxml[i].@id.toString(),
//									type:temxml[i].@type.toString(),
//									path:(serverip+temxml[i].@path.toString()),
//									data:null
//									});
//						continue;
//					}
//					loadList.push({
//						id:temxml[i].@id.toString(),
//						type:temxml[i].@type.toString(),
//						path:(serverip+temxml[i].@path.toString()),
//						data:null
//					});
//				}
				temxml = config.children();
				for(i=0;i<temxml.length();i++)
				{
					//runTimesList[temxml[i].@id.toString()] = {
					loadList[temxml[i].@id.toString()] = {
						id:temxml[i].@id.toString(),
						type:temxml[i].@restype.toString(),
						path:(serverip+temxml[i].@path.toString()),
						data:null
					};
				}
				islistFormat=true;
			}
		}
		/**
		 * 超级列队加载
		 */
		private function addFirstList():void
		{
			var isLoadTop:Boolean = false;
			for each( var obj:Object in superTopList )
			{
				isLoadTop = true;
				addItem( obj.path, getType(obj.type), obj.id);
			}
			if( false == isLoadTop )
			{
				loadFirstList();
				return;
			}
			_loader.addEventListener(BulkProgressEvent.COMPLETE, onSuperTopComplete);
			_loader.addEventListener(BulkProgressEvent.PROGRESS, onInitProgress);
		}
		/**
		 * 列队加载
		 */
		private function loadFirstList():void
		{
			for each( var obj:Object in loadList )
			{
				addItem( obj.path, getType(obj.type), obj.id);
			}
			_loader.addEventListener(BulkProgressEvent.COMPLETE, onInitLoaded);
			_loader.addEventListener(BulkProgressEvent.PROGRESS, onInitProgress);
		}
		/**
		 *优先加载队列 
		 * @param evt
		 */		
		private function onSuperTopComplete(evt:BulkProgressEvent):void
		{
			_loader.removeEventListener(BulkProgressEvent.PROGRESS, onInitProgress);
			_loader.removeEventListener(BulkProgressEvent.COMPLETE, onSuperTopComplete);
			if (isSuper)  return;
			
			MSG.getinstance().dispatch(EXPLORER_SUPER_INIT);
			isSuper = true;
			
			loadFirstList();
		}
		/**
		 *加載完成优先的队列 
		 * @param evt
		 * 
		 */		
		private function onInitLoaded(evt:BulkProgressEvent):void
		{
			_loader.removeEventListener(BulkProgressEvent.PROGRESS, onInitProgress);			
			_loader.removeEventListener(BulkProgressEvent.COMPLETE, onInitLoaded);
			
			isFrist = true;
			MSG.getinstance().dispatch( EXPLORER_FRIST_INIT );
		}
		/**
		 *进度 
		 * @param evt
		 * 
		 */		
		private function onInitProgress(evt:BulkProgressEvent):void
		{
			MSG.getinstance().dispatch(EXPLORER_ALL_LOAD_PROGRESS,null,evt.itemsTotal+"|"+evt.itemsLoaded);
		} 
		
		private function onRuntimeComplete(evt:Event):void
		{
			var item:LoadingItem = evt.target as LoadingItem;
			if (item.task == null) {
				MSG.getinstance().dispatch(Explorer.EXPLORER_COMPLETE,null, item._id);
			}else {
				MSG.getinstance().dispatch(Explorer.EXPLORER_COMPLETE, item.task, item._id);
			}
		}
		
		private function getType( objType:String ):String
		{
			switch(objType)
			{
				case "swf":
					return BulkLoader.TYPE_MOVIECLIP;
				case "gimg":
					return BulkLoader.TYPE_IMAGE;
				case "gbin":
					return BulkLoader.TYPE_BINARY;
				case "txt":
					return BulkLoader.TYPE_TEXT;
				case "xml":
					return BulkLoader.TYPE_XML;
				case "gsound":
					return BulkLoader.TYPE_SOUND;
			}
			
			return BulkLoader.TYPE_TEXT;
		}
		
		/**
		 *动态加载 
		 * @param id 对应的资源id
		 */
		private function runTimeLoad(id:String, task:* = null, priority:int=0):com.resManager.com.loading.loadingtypes.LoadingItem
		{
			var obj:Object = runTimesList[id];
			if (obj == null )
			{
				trace("Loader:资源配置里无法找到"+id);
				return null;
			}

			var item:LoadingItem = addItem( obj.path, getType(obj.type), id, Boolean(priority));
			item.task = task;
			item.addEventListener(Event.COMPLETE, onRuntimeComplete, false, 0, true); 
			return item;
		}
		
		/**
		 * 返回二进制数据
		 * @param	id
		 * @return
		 */
		public function getBin(id:String, task:* = null, priority:int=0):ByteArray
		{
			if(null == id || id.length == 0) return null;
//			id = id.toLocaleLowerCase();
			
			var item:LoadingItem = _loader.getLoadedItem(id);	
			if(null == item )
			{
				runTimeLoad(id,task,priority);
				return null;
			}
			
			if ((item._content is ByteArray) == false) throw("类型错误");
			item._content.position = 0;
			return (item._content);
		}
		/**
		 * 返回文本数据
		 * @param	id
		 * @return
		 */
		public function getText(id:String, task:* = null, priority:int=0):String
		{
			//if (istop == false) throw new Error("Explorer top not complete");
			if(null == id || id.length == 0) return null;
//			id = id.toLocaleLowerCase();
			var item:LoadingItem = _loader.getLoadedItem(id);	
			if(null == item )
			{
				runTimeLoad(id,task,priority);
				return null;
			}
			if ((item._content is String) == false) throw("类型错误");
			return (item._content);
		}
		/**
		 * 返回文本数据
		 * @param	id
		 * @return
		 */
		public function getXml(id:String, task:* = null, priority:int=0):XML
		{
			//if (istop == false) throw new Error("Explorer top not complete");
			if(null == id || id.length == 0) return null;
//			id = id.toLocaleLowerCase();
			var item:LoadingItem = _loader.getLoadedItem(id);	
			if(null == item )
			{
				runTimeLoad(id,task,priority);
				return null;
			}
			if ((item._content is XML) == false) throw("类型错误");
			return (item._content);
		}
		/**
		 * 返回img对象
		 * @param	id
		 * @return
		 */
		public function getImg(id:String, task:* = null, priority:int=0):Bitmap
		{
			//if (istop == false) throw new Error("Explorer top not complete");
			if(null == id || id.length == 0) return null;
//			id = id.toLocaleLowerCase();
			
			var item:LoadingItem = _loader.getLoadedItem(id);	
			if(null == item )
			{
				runTimeLoad(id,task,priority);
				return null;
			}
			
			if ((item._content is Bitmap) == false) throw("类型错误");
			return (item._content);
		}
		
		public function getDefinition(id:String, className:String):Class
		{
			return getClass(id, className );
		}
		/**
		 * 返回类引用
		 * @param	id 文件名
		 * @param	className 文件內的類名字
		 * @return
		 */
		public function getClass(id:String, className:String, task:* = null, priority:int=0):Class
		{
			//if (istop == false) throw new Error("Explorer top not complete");
			if(null == id || id.length == 0) return null;
//			id = id.toLocaleLowerCase();
			
			var item:LoadingItem = _loader.getLoadedItem(id);	
			if(null == item )
			{
				runTimeLoad(id,task,priority);
				return null;
			}
			return item.getDefinitionByName(className) as Class;
		}
		/**
		 * 返回swf資源內容
		 * @param	id 文件名
		 * @return
		 */
		public function getMovieClip(id:String, task:* = null, priority:int=0):MovieClip
		{
			//if (istop == false) throw new Error("Explorer top not complete");
			if(null == id || id.length == 0) return null;
//			id = id.toLocaleLowerCase();
			
			var item:LoadingItem = _loader.getLoadedItem(id);	
			if(null == item )
			{
				runTimeLoad(id,task,priority);
				return null;
			}
			if ((item._content is MovieClip) == false) throw("类型错误");
			return (item._content);
		}
		/**
		 * 返回类對象實體
		 * @param	id 文件名
		 * @param	className 文件內的類名字
		 * @return
		 */
		public function getObject(id:String, className:String, task:* = null, priority:int=0):Object
		{
			//if (istop == false) throw new Error("Explorer top not complete");
			if(null == id || id.length == 0) return null;
//			id = id.toLocaleLowerCase();
			
			var item:LoadingItem = _loader.getLoadedItem(id);	
			if(null == item )
			{
				runTimeLoad(id,task,priority);
				return null;
			}
			
			var cls:Class = item.getDefinitionByName(className) as Class;	
			if(null == cls)
			{
				throw("文件中沒有找到這個名字的類!");
				return null;
			}
			
			return (new cls());
		}
		
		/**
		 * 返回类引用
		 * @param	id
		 * @param	className
		 * @return
		 */
		public function hasItem(id:String):Boolean
		{
			//if (istop == false) throw new Error("Explorer top not complete");
			if(null == id || id.length == 0) return false;
//			id = id.toLocaleLowerCase();
			
			var item:LoadingItem = _loader.getLoadedItem(id);	
			if(null == item )
			{
				return false;
			}
			
			return true;
		}
		
		/**
		 * 返回声音文件
		 * @param	id
		 * @param	className
		 * @return
		 */
		public function getSound(id:String, task:* = null, priority:int=0):Sound
		{
			//if (istop == false) throw new Error("Explorer top not complete");
			if(null == id || id.length == 0) return null;
//			id = id.toLocaleLowerCase();
			
			var item:LoadingItem = _loader.getLoadedItem(id);	
			if(null == item )
			{
				item =  runTimeLoad(id,task,priority);
				return null == item ? null : item._content;
			}
			
			return item._content as Sound;
		}
		
		/**
		 * 删除资源 
		 * @param id
		 * 
		 */
		public function remove(id:String):Boolean
		{
			//if (istop == false) throw new Error("Explorer top not complete");
			if(null == id || id.length == 0) return false;
//			id = id.toLocaleLowerCase();
			
			return _loader.remove( id );
		}

		/**
		 * 资源配置文件
		 */
		public function get config():XML
		{
			return _config;
		}

    }
	

}class Private{}