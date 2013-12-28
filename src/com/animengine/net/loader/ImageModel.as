package com.animengine.net.loader{
	import com.animengine.core.animation.BitmapFrameData;
	import com.animengine.core.animation.WrapperedAnimation;
	import com.animengine.core.data.RenderData;
	import com.animengine.define.Config;
	import com.resManager.manage.Explorer;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;

	/**
	 * @author Sampson
	 */
	public class ImageModel extends EventDispatcher {
		private static var _instance : ImageModel ;
		private var animManager : ResManager;
		public var animCache : Dictionary;
		public static const RESTYPE_ANIM : uint = 0;
		public static const RESTYPE_BITMAP_DATA : uint = 1;
		public static const RESTYPE_RENDER_DATA : uint = 2;

		public function ImageModel() {
			animManager = new ResManager();

			animCache = new Dictionary();
		}

		public static function get instance():ImageModel
		{
			if(null == _instance )
				_instance = new ImageModel();
			return _instance;
		}

		public function getAnimRes(key:String, fun : Function, args : Array = null, resType : uint = 0) : ResResult {
			return getRes(animManager, key, fun, args, resType);
		}

		public function getRes(manager : ResManager, key:String, fun : Function, 
							   args : Array, resType : uint = 0, oder : Boolean = true,
								depth : uint = 0, sortFun : Function = null) : ResResult {
			if (args == null) args = [];
			// if (Login.isTengxun) packId = getTxPackId(packId, groupId, imageId);
//			var key : String = String(packId) + "_" + String(groupId) + "_" + String(imageId);

			var renderData : RenderData = animCache[key];
//			var url : String = Config.swfPath + key + ".swf";
			if (renderData != null && sortFun == null) {
				execGetResWithArgs(fun, args, resType, renderData, key);
				return new ResResult(true);
			} else {
//				var callBack : Function = function() : void {
					renderData = animCache[key];
					if (renderData == null) {
						var frames : Vector.<BitmapFrameData> = new Vector.<BitmapFrameData>();
						var frameLength : uint;
						
						frameLength = 40;
						renderData = new RenderData(400, 400, 125, frames);

						var className : String;
						var bmdClass : Class;
						var bmdFrameData : BitmapFrameData;
						className = "bmd_" + key;
						for (var i : int = 0; i < frameLength; i++) {
							if (!ApplicationDomain.currentDomain.hasDefinition(className + "_" + i))
							bmdClass = Explorer.getinstance().getClass(key, className + "_" + i);//bmd_302_1_1_0
							if(null == bmdClass)
							{
								continue;
							}
							bmdFrameData = new BitmapFrameData();
							bmdFrameData.targetBitmapClass = bmdClass;
							frames.push(bmdFrameData);
						}
						animCache[key] = renderData;
					}
					execGetResWithArgs(fun, args, resType, renderData, key);
				};
			return null;
//				return manager.getRes(key, callBack, null, Class, oder, depth, sortFun);
//			}
		}

		private function execGetResWithArgs(fun : Function, args : Array, resType : uint, renderData : RenderData, key : String) : void {
			if (fun == null) return;
			var target : *;
			switch(resType) {
				case RESTYPE_ANIM:
					target = createAnim(renderData, key);
					break;
				case RESTYPE_BITMAP_DATA:
					target = renderData.frames[0].bitmapData;
					break;
				case RESTYPE_RENDER_DATA:
					target = renderData;
					break;
			}

			args.unshift(target);
			fun.apply(fun, args);
			args.shift();
		}

		public function createAnim(renderData : RenderData, name : String) : WrapperedAnimation {
			var anim : WrapperedAnimation = new WrapperedAnimation();
			anim.renderBySelf = true;
			anim.renderSpeed = renderData.renderSpeed;
			anim.setFrames(renderData.frames);
			anim.name = name;
			// anim.wrapperWidth = imageVO.wrapperWidth;
			// anim.wrapperHeight = imageVO.wrapperHeight;
			return anim;
		}

		public function createFrameDatas(fac : Class) : Vector.<BitmapFrameData> {
			var frames : Vector.<BitmapFrameData> = new Vector.<BitmapFrameData>();
			var mc : * = new fac();
			var totalFrames : int;
			if (mc is MovieClip) {
				totalFrames = mc.totalFrames;
				for (var i : int = 1; i <= totalFrames; i++) {
					mc.gotoAndStop(i);
					frames.push(getBitmapData(mc, "idle" + i));
				}
			}
			return frames;
		}

		public function getBitmapData(obj : DisplayObjectContainer, className : String) : BitmapFrameData {
			var bmd : BitmapFrameData;
			var bounds : Rectangle = obj.getRect(obj);
			bounds.x = Math.round(bounds.x);
			bounds.y = Math.round(bounds.y);
			bmd = new BitmapFrameData();
			if (ApplicationDomain.currentDomain.hasDefinition(className)) {
				bmd.targetBitmapClass = getDefinitionByName(className) as Class;
			}
			// bmd.bitmapData = new BitmapData(bounds.width, bounds.height, true, 0x00);
			// bmd.bitmapData.draw(obj, new Matrix(1, 0, 0, 1, -bounds.x, -bounds.y));
			bmd.rectangle = bounds;
			return bmd;
		}
	}
}
