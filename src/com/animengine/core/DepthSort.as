package com.animengine.core {
	import com.mapeditor.items.Building;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	/**
	 * DepthSort 深度排序(二分算法优化)
	 * 
	 * @author bright
	 * @version 20111202
	 */
	public final class DepthSort {
		private var _layer : Sprite;

		/**
		 * 比较深度
		 * @private
		 */
		private function compare(source : DisplayObject, target : DisplayObject) : int {
			if (source.y >= target.y) {
				return 1;
			}
//			if (source.y < target.y) {
//				return -1;
//			}
			return -1;
		}

		/**
		 * 二分查找
		 * @private
		 */
		private function getIndex(value : DisplayObject, left : int, right : int) : int {
			var result : int;
			while (left <= right) {
				var mid : int = (left + right) >> 1;
				result = compare(value, _layer.getChildAt(mid));
				if (result > 0) {
					left = mid + 1;
				} else {
					right = mid - 1;
				}
			}
			return left;
		}

		public function DepthSort(layer : Sprite) {
			_layer = layer;
		}

		/**
		 * reset 使用二分查找重置深度
		 * 
		 * @param value DisplayObject
		 */
		public function reset(value : DisplayObject) : int {
			var index : int = _layer.getChildIndex(value);
			if (value.parent != _layer) {
				return index;
			}
			for(var i:int = 0; i<_layer.numChildren; ++i)
			{
				var build:Building = _layer.getChildAt(i) as Building;
				if(build && build.id != -1  && build.visible && build != value)
				{
					if (compare(value, build) == -1) 
						_layer.swapChildren(value, build);
				}
			}
			return _layer.getChildIndex(value);
		}

		public function toString() : String {
			var result : String = "";
			var item : DisplayObject;
			for (var i : int = 0;i < _layer.numChildren;i += 1) {
				item = _layer.getChildAt(i);
				result += i + ":" + item.x + ":" + item.y + "\n";
			}
			return result;
		}
	}
}
