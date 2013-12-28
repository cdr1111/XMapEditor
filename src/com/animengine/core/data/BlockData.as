package com.animengine.core.data {
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;

	/**
	 * 障碍定义
	 * 
	 * @author bright
	 * @version 20120420
	 */
	public final class BlockData {
		public var filterView : DisplayObject;
		private var _halfW : int;
		private var _halfH : int;
		private var _source : Rectangle;
		private var _blockRect : Rectangle;
		private var _hitRect : Rectangle;
		private var _x : int;
		private var _y : int;
		private var _z : int;
		private var _flipH : Boolean;

		public function BlockData(halfW : int = 20, halfH : int = 10, source : Rectangle = null) {
			reset(halfW, halfH, source);
			_flipH = true;
		}

		public function reset(halfW : int, halfH : int, source : Rectangle = null) : void {
			_halfW = halfW;
			_halfH = halfH;
			_blockRect = new Rectangle(-halfW, -halfH, halfW * 2, halfH * 2);
			_source = source;
			if (_source != null) {
				_hitRect = _source.clone();
			}
			filterView = null;
		}

		public function set halfW(value : int) : void {
			_halfW = value;
		}

		public function get halfW() : int {
			return _halfW;
		}

		public function set halfH(value : int) : void {
			_halfH = value;
		}

		public function get halfH() : int {
			return _halfH;
		}

		public function set source(value : Rectangle) : void {
			if (_source == null) {
				_source = value;
			} else {
				_source.x = value.x;
				_source.y = value.y;
				_source.width = value.width;
				_source.height = value.height;
			}
			if (_hitRect == null) {
				_hitRect = _source.clone();
			} else {
				_hitRect.width = _source.width;
				_hitRect.height = _source.height;
			}
			if (_flipH) {
				_hitRect.x = _x - _source.x - _source.width;
			} else {
				_hitRect.x = _x + _source.x;
			}
			_hitRect.y = _y + _source.y + _z;
		}

		public function get source() : Rectangle {
			return _source;
		}

		public function set x(value : int) : void {
			_x = value;
			_blockRect.x = _x - _halfW;
			if (_flipH) {
				_hitRect.x = _x - _source.x - _source.width;
			} else {
				_hitRect.x = _x + _source.x;
			}
		}

		public function get x() : int {
			return _x;
		}

		public function set y(value : int) : void {
			_y = value;
			_blockRect.y = _y - _halfH;
			_hitRect.y = _y + _source.y + _z;
		}

		public function get y() : int {
			return _y;
		}

		public function set z(value : int) : void {
			if (_z == value) {
				return;
			}
			_z = value;
			if (_hitRect != null) {
				_hitRect.y = _y + _source.y + _z;
			}
		}

		public function moveTo(nx : int, ny : int) : void {
			_x = nx;
			_blockRect.x = _x - _halfW;
			_y = ny;
			_blockRect.y = _y - _halfH;
			if (_hitRect != null) {
				if (_flipH) {
					_hitRect.x = _x - _source.x - _source.width;
				} else {
					_hitRect.x = _x + _source.x;
				}
				_hitRect.y = _y + _source.y + _z;
			}
		}

		public function set flipH(value : Boolean) : void {
			if (_flipH == value) {
				return;
			}
			_flipH = value;
			if (_flipH) {
				_hitRect.x = _x - _source.x - _source.width;
			} else {
				_hitRect.x = _x + _source.x;
			}
		}

		/**
		 * 障碍矩形-处理寻路
		 * 
		 * @return Rectangle
		 */
		public function get blockRect() : Rectangle {
			return _blockRect;
		}

		public function hitBlock(value : BlockData) : Boolean {
			return _blockRect.intersects(value.blockRect);
		}

		public function set hitRect(hitRect : Rectangle) : void {
			_hitRect = hitRect;
		}

		/**
		 * 遮挡矩形-处理透明遮挡与攻击碰撞
		 * 
		 * @return Rectangle
		 */
		public function get hitRect() : Rectangle {
			return _hitRect;
		}
	}
}