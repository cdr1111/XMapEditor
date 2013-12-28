package com.animengine.core.animation {
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;

	/**
	 * @author Halley
	 */
	public class BitmapFrameData {
		/**
		 * 这一帧上的代码
		 */
		public var functions : Vector.<Function>;
		/**
		 * 这一帧的方位大小
		 */
		public var rectangle : Rectangle;
		private var _reverseRectangle : Rectangle;
		/**
		 * 运行时要NEW的位图数据
		 */
		public var targetBitmapClass : Class;
		/**
		 * 位图数据弱引用
		 */
		private var _bitmapDataRef : WeakReference;
		/**
		 * 位图数据弱引用
		 */
		private var _reverseBitmapDataRef : WeakReference;
		/**
		 * 图片的真实宽
		 */
		public var picWidth : Number;
		public var offsetX : int = 0;
		public var offsetY : int = 0;
		/**
		 * 鼠标响应区域
		 */
		// private var _hitArea:Sprite;
		public function get reverseRectangle() : Rectangle {
//			if (_reverseRectangle == null) {
//				picWidth = 800;
//				if (rectangle == null) rectangle = new Rectangle(0, 0, 800, 800);
//				_reverseRectangle = rectangle.clone();
//				_reverseRectangle.x = picWidth - _reverseRectangle.x - _reverseRectangle.width;
//			}
			return _reverseRectangle;
		}

		/**
		 * 执行所有函数
		 */
		public function execute() : void {
			if (functions == null) return;
			for each (var fun:Function in functions) {
				fun();
			}
		}

		public function get bitmapData() : BitmapData {
			if (_bitmapDataRef == null) _bitmapDataRef = new WeakReference();

			if (_bitmapDataRef.value == null) {
				if (targetBitmapClass) {
					_bitmapDataRef.value = new targetBitmapClass();
				}
			}
			return _bitmapDataRef.value;
		}

		public function get reverseBitmapData() : BitmapData {
			if (_reverseBitmapDataRef == null) _reverseBitmapDataRef = new WeakReference();

			if (_reverseBitmapDataRef.value == null) {
				if (bitmapData) {
					var matrix : Matrix = new Matrix();
					matrix.a = -1;
					matrix.tx = bitmapData.width;
					var reverseBitmapdata : BitmapData = new BitmapData(bitmapData.width, bitmapData.height, bitmapData.transparent, 0x00000000);
					reverseBitmapdata.draw(bitmapData, matrix);
					_reverseBitmapDataRef.value = reverseBitmapdata;
				}
			}
			return _reverseBitmapDataRef.value;
		}

		public function set bitmapData(value : BitmapData) : void {
			if (_bitmapDataRef == null) _bitmapDataRef = new WeakReference();
			_bitmapDataRef.value = value;
		}

		public function dispose() : void {
			if (_bitmapDataRef.value) _bitmapDataRef.value.dispose();
			_bitmapDataRef = null;
		}
	}
}
