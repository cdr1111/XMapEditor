package com.animengine.core.animation{

	/**
	 * @author Halley
	 */
	public class WrapperedAnimation extends BitmapAnimation// implements ISortable
	{
		public var wrapperWidth : Number;
		public var wrapperHeight : Number;
		private var _depth : uint;
		private var rotateOffsetX : Number;
		private var rotateOffsetY : Number;
		private var offsetwidth : Number;
		private var offsetheight : Number;
		public var needAdjpos : Boolean;
		public var stateEffect : Boolean;
//		public var imageVO:ImageVO;
		public function WrapperedAnimation(factory : Class = null, renderBySelf : Boolean = false, playOnce : Boolean = false)
		{
			super(factory, renderBySelf, playOnce);
			rotateOffsetX = 0;
			rotateOffsetY = 0;
			offsetwidth = 0;
			offsetheight = 0;
		}

		public function get depth() : uint
		{
			if (_depth != 0)
			{
				return _depth;
			}
			return y;
		}

		public function set depth(value : uint) : void
		{
			_depth = value;
		}

	}
}