package com.animengine.net.loader {
	import flash.display.Loader;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getTimer;

	/**
	 * 图形资源管理器
	 * @author Halley
	 */
	public class ResManager {
		public static var imageCache : Dictionary;
		public static var VerisonClass : *;
		private var _callLaterDic : Dictionary;
		private var _urlLoader : URLLoader;
		private var _currentRequest : URLRequest;
		private var _currentReqObj : Object;
		private var _invokeUrlQueue : Vector.<Object>;
		private var _pause : Boolean;
		private var sortFun : Function;
		private var startTime : uint;
		public var currentSpeed : Number = 0;
		public var useShift : Boolean;
		public var currentBytesLoaded : Number;
		public var currentBytesTotal : Number;

		public function ResManager() {
			// if (VerisonClass == null)	VerisonClass = getDefinitionByName("Verison");
			imageCache = new Dictionary();
			_callLaterDic = new Dictionary();
			_invokeUrlQueue = new Vector.<Object>();
			_urlLoader = new URLLoader();
			_currentRequest = new URLRequest();
			_urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			_urlLoader.addEventListener(Event.COMPLETE, onDataLoadComplete);
			_urlLoader.addEventListener(ProgressEvent.PROGRESS, onProgress);
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_urlLoader.addEventListener(Event.OPEN, onOpen);
		}

		private function onOpen(event : Event) : void {
			currentBytesLoaded = 0;
			currentBytesTotal = 0;
			startTime = getTimer();
		}

		private function onProgress(event : ProgressEvent) : void {
			currentBytesLoaded = event.bytesLoaded;
			currentBytesTotal = event.bytesTotal;
			var elapsedTime : uint = getTimer() - startTime;
			if (elapsedTime != 0)
				currentSpeed = event.bytesLoaded / elapsedTime;
			else
				currentSpeed = event.bytesLoaded;
		}

		/*
		public static function getInstance():ResManager
		{
		if ( _instance == null )
		_instance = new ResManager();
		return _instance;
		}*/
		private function closeCurrentInvok() : void {
			try {
				_urlLoader.close();
			} catch(e : Error) {
			}
			_currentRequest.url = null;
		}

		/**
		 * 取消调用
		 * @param field 要取消的类型
		 * @param value 要取消的值
		 * @param functionVO 对应的回调函数
		 */
		public function cancelInvok(field : String, value : *, functionVO : FunctionVO = null) : void {
			if (_currentReqObj && _currentReqObj[field] == value) {
				if (deleteCurrentCallLater(_currentReqObj.url, _currentReqObj.depth, functionVO)) {
					closeCurrentInvok();
				}
			}
			var eachObj : Object;
			for ( var i : int = _invokeUrlQueue.length - 1; i >= 0; i--) {
				eachObj = _invokeUrlQueue[i];
				if (eachObj[field] == value) {
					if (sortFun != null) {
						delete _callLaterDic[eachObj.depth];
					} else {
						if (functionVO) {
							var result : Boolean = deleteCurrentCallLater(_currentReqObj.url, _currentReqObj.depth, functionVO);
							if (!result) return;
						} else delete _callLaterDic[eachObj.url];
					}
					_invokeUrlQueue.splice(i, 1);
				}
			}
		}

		public function makeUrlLoaded(url : String) : void {
			imageCache[url] = true;
		}

		public function get length() : uint {
			return _invokeUrlQueue.length;
		}

		public function cancelAllInvok() : void {
			try {
				_urlLoader.close();
			} catch(e : Error) {
			}
			_currentRequest.url = null;
			_currentReqObj = null;
			_invokeUrlQueue = new Vector.<Object>();
			_callLaterDic = new Dictionary();
		}

		/**
		 * 获取图片信息
		 * @param url 资源地址
		 * @param fun 回调函数（当资源加载完成后触发）
		 * @param args 参数数组，回调函数内的参数数组
		 * @param oder 是否按顺序下载
		 * @param depth 优先级
		 * @param sortFun 排序函数
		 * @param classType 生成资源的类型,ByteArray是原生二进制，Class是加载到当前域
		 * @param needPushCallLater 是否如果有回调的话叠加
		 * @return 如果有资源，返回TRUE，如果没有，返回URL引用
		 */
		public function getRes(url : String, fun : Function, args : Array = null, classType : Class = null, oder : Boolean = true, depth : uint = 0, sortFun : Function = null, needPushCallLater : Boolean = true) : ResResult {
			var result : ResResult = new ResResult(false);
			this.sortFun = sortFun;
			if (imageCache[url] && sortFun == null) {
				execute(fun, imageCache[url], args);
				result.hasRes = true;
				return result;
			} else {
				var functionVO : FunctionVO;
				if (fun != null) {
					functionVO = new FunctionVO(fun, args);
					result.callBack = functionVO;
				}
				var callLaterKey : * = (sortFun != null ? depth : url);
				if (_callLaterDic[callLaterKey] == null) {
					_callLaterDic[callLaterKey] = [];
					if (functionVO) {
						if (needPushCallLater || _callLaterDic[callLaterKey].length == 0)
							_callLaterDic[callLaterKey].push({funs:functionVO, url:url, depth:depth});
					}
					if (oder) {
						if (_currentRequest.url != url) {
							if (_currentReqObj && _currentReqObj.url == url) {
//								AnimationEdit.main.traceTxt.text = url+"当前url是一致的，但却在重复加载！！！！！！";
								trace("当前url是一致的，但却在重复加载！！！！！！");
								trace(_currentReqObj.url);
							}
							_invokeUrlQueue.unshift({url:url, depth:depth, classType:classType});
							flushInvokeQueue();
						}
					} else {
						throw new Error("暂时不支持");
					}
				} else {
					if (functionVO && (needPushCallLater || _callLaterDic[callLaterKey].length == 0))
						_callLaterDic[callLaterKey].push({funs:functionVO, url:url, depth:depth});
					if (useShift && _currentRequest.url != url) {
						var l : uint = _invokeUrlQueue.length;
						var eachObj : Object;
						for (var i : int = 0; i < l; i++) {
							eachObj = _invokeUrlQueue[i];
							if (eachObj.url == url) {
								_invokeUrlQueue.splice(i, 1);
								_invokeUrlQueue.unshift(eachObj);
								break;
							}
						}
					}
				}
			}
			return result;
		}

		private function flushInvokeQueue() : void {
			if ( !pause && _currentRequest.url == null ) {
				if ( _invokeUrlQueue.length ) {
					if (useShift) _currentReqObj = _invokeUrlQueue.shift();
					else _currentReqObj = _invokeUrlQueue.pop();
					var url : String = _currentReqObj.url;
					// _currentRequest.url = VerisonClass.getVersionUrl(url);
					_currentRequest.url = url;
					if (imageCache[url] != null) {
						call(url, _currentReqObj.depth);
						_currentRequest.url = null;
						flushInvokeQueue();
					} else {
						if (_currentRequest.url && _currentRequest.url.indexOf("\/.jxr") != -1) {
							_currentRequest.url = null;
							return;
						}
						_urlLoader.load(_currentRequest);
					}
				} else {
					currentSpeed = 0;
				}
			}
		}

		public static function parse(bytes : ByteArray, classType : Class = null) : * {
			var w : int = bytes.readInt();
			var h : int = bytes.readInt();
			if (classType == null) classType = BitmapData;
			var bmd : BitmapData = new classType(w, h);
			var bmdBytes : ByteArray = new ByteArray();

			bmdBytes.writeBytes(bytes, bytes.position, bytes.bytesAvailable);
			bmdBytes.uncompress();
			bmd.setPixels(bmd.rect, bmdBytes);
			return bmd;
		}

		private function onDataLoadComplete(event : Event) : void {
			var url : String = _currentReqObj.url;
			var depth : uint = _currentReqObj.depth;
			var parms : *;
			var isAsyn : Boolean;
			var classType : * = _currentReqObj.classType;
			var bytes : ByteArray = event.target.data;
			if (bytes) {
				// ResMonitor.instance.inspect(url, bytes.length);
			}
			if (classType == Class || classType == BitmapData) {
				isAsyn = true;
				var loader : Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function(event : IOErrorEvent) : void {
					// Debugger.error( "加载到当前域失败" );
				});
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(event : Event) : void {
					if (classType == BitmapData) {
						var bmd : BitmapData = Bitmap(loader.content).bitmapData;
						imageCache[url] = bmd;
						call(url, depth, bmd);
					} else {
						imageCache[url] = true;
						call(url, depth);
					}
				});
				var loaderContext : LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain );
				loaderContext.allowCodeImport = false;
				loaderContext.allowLoadBytesCodeExecution = true;
				if ("imageDecodingPolicy" in loaderContext)
					loaderContext["imageDecodingPolicy"] = "onLoad";
				loader.loadBytes(bytes, loaderContext);
			} else {
				imageCache[url] = parse(bytes, _currentReqObj.classType);
				parms = imageCache[url];
			}
			_currentRequest.url = null;
			flushInvokeQueue();
			if (!isAsyn)
				call(url, parms);
		}

		/**
		 * @return 返回是否真的不需要任何回调了
		 */
		private function deleteCurrentCallLater(url : String, depth : uint, functionVO : FunctionVO = null) : Boolean {
			// trace( "deleteCurrentCallLater ", url,depth );
			if (sortFun == null) {
				if (!_callLaterDic[url]) return true;
				var vec : Vector.<Object> = Vector.<Object>(_callLaterDic[url]);
				if (vec.length <= 1 || functionVO == null) {
					delete _callLaterDic[url];
					return true;
				} else {
					var eachObj : Object;
					var i : uint;
					for ( i = 0;i < vec.length;i++) {
						eachObj = vec[i];
						if (eachObj.funs == functionVO) {
							vec.splice(i, 1);
						}
					}
				}
			} else delete _callLaterDic[depth];

			if (functionVO)
				return false;
			return true;
		}

		private function call(url : String, depth : uint, parms : * = null) : void {
			// trace( "_currentRequestObj.depth:" + depth, url );
			var funs : Array;
			if (sortFun == null) funs = _callLaterDic[url];
			else funs = _callLaterDic[depth];
			for each (var obj : Object in funs) {
				var eachFunVO : * = obj.funs;
				execute(eachFunVO.fun, parms, eachFunVO.args);
			}
			deleteCurrentCallLater(url, depth);
		}

		private function onIOError(event : IOErrorEvent) : void {
			// Debugger.error("加载资源失败：" + event.text);
			if (_currentReqObj) {
				// Debugger.error("org url:" + _currentReqObj.url);
			}
			// Debugger.error("url:" + _currentRequest.url );
			deleteCurrentCallLater(_currentRequest.url, _currentReqObj.depth);
			_currentRequest.url = null;
			flushInvokeQueue();
		}

		private function execute(fun : Function, parms : *, args : *) : void {
			if (fun != null) {
				if (args != null) {
					var argsArray : Array = args;
					if (parms != null)
						argsArray.unshift(parms);
					fun.apply(fun, argsArray);
				} else {
					fun(parms);
				}
			}
		}

		public function get pause() : Boolean {
			return _pause;
		}

		public function set pause(value : Boolean) : void {
			_pause = value;
			if (!_pause) {
				// var t1:int = getTimer();
				if (sortFun != null)
					_invokeUrlQueue.sort(sortFun);
				flushInvokeQueue();
				// trace( "render cost:" + String( getTimer() - t1 ) );
			}
		}
	}
}