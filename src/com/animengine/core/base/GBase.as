package com.animengine.core.base {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.Dictionary;

	public class GBase extends Sprite {
		public static const SHOW : String = "show";
		public static const HIDE : String = "hide";
		/**
		 * @private
		 * 基础定义
		 */
		protected var _base : GBaseData;
		/**
		 * @private
		 * 控件宽度
		 */
		protected var _width : int;
		/**
		 * @private
		 * 控件高度
		 */
		protected var _height : int;
		/**
		 * @private
		 * 是否启用
		 */
		protected var _enabled : Boolean;
		/**
		 * @private
		 * 数据源
		 */
		protected var _source : *;
		/**
		 * 关联对象map
		 */
		protected var _relationDic : Dictionary;

		private function addToStageHandler(event : Event) : void {
			parent.addEventListener(Event.RESIZE, resizeHandler);
			layout();
			onShow();
			dispatchEvent(new Event(SHOW));
		}

		private function removeFromStageHandler(event : Event) : void {
			parent.removeEventListener(Event.RESIZE, resizeHandler);
			onHide();
			dispatchEvent(new Event(HIDE));
		}

		private function resizeHandler(event : Event) : void {
			onResize();
		}

		/**
		 * @private
		 * 初如化控件
		 */
		protected function init() : void {
			moveTo(_base.x, _base.y);
			_width = _base.width;
			_height = _base.height;
			alpha = _base.alpha;
			visible = _base.visible;
			create();
			layout();
		}

		/**
		 * @private
		 * 创建
		 */
		protected function create() : void {
		}

		/**
		 * @private
		 * 布局
		 */
		protected function layout() : void {
		}

		/**
		 * @private
		 * 替换皮肤
		 * 
		 * @param source 源皮肤
		 * @param target 目标皮肤
		 */
		protected function replace(source : Sprite, target : Sprite) : Sprite {
			if (source == null || source.parent == null || target == null || source == target) {
				return source;
			}
			var index : int = source.parent.getChildIndex(source);
			var parent : DisplayObjectContainer = source.parent;
			source.parent.removeChild(source);
			parent.addChildAt(target, index);
			return target;
		}

		/**
		 * @private
		 * 当显示时
		 */
		protected function onShow() : void {
		}

		/**
		 * @private
		 * 当隐藏时
		 */
		protected function onHide() : void {
		}

		/**
		 * @private
		 * 当启用状态改变时-需要子类扩展
		 */
		protected function onEnabled() : void {
		}

		protected function onResize() : void {
		}

		/**
		 * 构造函数
		 * 
		 * @param base 控件基础定义
		 * @see gear.ui.data.GComponentData
		 */
		public function GBase(base : GBaseData) {
			_base = base;
			init();
			_enabled = true;
			enabled = _base.enabled;
			addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removeFromStageHandler);
		}

		/**
		 * 移动到指定坐标
		 * 
		 * @param newX 新的X坐标
		 * @param newY 新的Y坐标
		 */
		public function moveTo(newX : int, newY : int) : void {
			x = newX;
			y = newY;
		}

		public function set position(value : Point) : void {
			x = value.x;
			y = value.y;
		}

		public function get position() : Point {
			return new Point(x, y);
		}

		/**
		 * setSize 设置尺寸
		 * 
		 * @param w int 宽度
		 * @param h int 高度
		 */
		public function setSize(w : int, h : int) : void {
			var newWidth : int = Math.max(_base.minWidth, Math.min(_base.maxWidth, w));
			var newHeight : int = Math.max(_base.minHeight, Math.min(_base.maxHeight, h));
			if (_width == newWidth && _height == newHeight) {
				return;
			}
			_width = newWidth;
			_height = newHeight;
			layout();
			dispatchEvent(new Event(Event.RESIZE));
		}

		/**
		 * 设置控件宽度
		 * 
		 * @param value 宽度
		 */
		override public function set width(value : Number) : void {
			var newWidth : int = Math.max(_base.minWidth, Math.min(_base.maxWidth, Math.floor(value)));
			if (_width == newWidth) {
				return;
			}
			_width = newWidth;
			layout();
			dispatchEvent(new Event(Event.RESIZE));
		}

		/**
		 * 获得控件宽度
		 * 
		 * @return 		
		 */
		override public function get width() : Number {
			return _width;
		}

		/**
		 * 设置控件高度
		 * @param value 高度
		 */
		override public function set height(value : Number) : void {
			var newHeight : int = Math.max(_base.minHeight, Math.min(_base.maxHeight, Math.floor(value)));
			if (_height == newHeight) {
				return;
			}
			_height = newHeight;
			layout();
			dispatchEvent(new Event(Event.RESIZE));
		}

		/**
		 * 获得控件高度
		 * @return 高度
		 */
		override public function get height() : Number {
			return _height;
		}

		/**
		 * 设置启用状态
		 * 
		 * @param value 启用状态
		 */
		public function set enabled(value : Boolean) : void {
			if (_enabled == value) {
				return;
			}
			_enabled = value;
			mouseEnabled = mouseChildren = _enabled;
			onEnabled();
		}

		/**
		 * 获得启用状态
		 * 
		 * @return 启用
		 */
		public function get enabled() : Boolean {
			return _enabled;
		}

		/**
		 * 显示组件
		 */
		public function show() : void {
			if (_base.parent == null) {
				return;
			}
			if (parent != null) {
				parent.setChildIndex(this, parent.numChildren - 1);
			} else {
				_base.parent.addChild(this);
			}
		}

		/**
		 * 隐藏组件
		 */
		public function hide() : void {
			if (parent == null) {
				return;
			}
			if (_base.parent == null) {
				_base.parent = parent;
			}
			parent.removeChild(this);
		}

		public function switchShow() : void {
			if (parent == null) {
				show();
			} else {
				hide();
			}
		}

		/**
		 * map需要索引的显示对象
		 */
		public function mapChild(key : *, display : DisplayObject) : void {
			if (!_relationDic) {
				_relationDic = new Dictionary(true);
			}
			if (key != null) {
				_relationDic[key] = display;
			}
		}

		/**
		 * 设置数据源
		 * 
		 * @param value 数据源
		 */
		public function set source(value : *) : void {
			_source = value;
		}

		/**
		 * 获得数据源
		 * 
		 * @return 数据源
		 */
		public function get source() : * {
			return _source;
		}

		public function get relationDic() : Dictionary {
			return _relationDic;
		}
	}
}