package com.animengine.core.data {
	import com.animengine.core.animation.BitmapFrameData;

	/**
	 * 要渲染的数据
	 * 可以看作是一个MovieClip，frames是每帧的图像数据，width,height是mc的大小
	 * @author Halley
	 */
	public class RenderData
	{
		/**
		 * 每帧的位图数据
		 */
		public var frames:Vector.<BitmapFrameData>;
		/**
		 * 渲染的宽
		 */
		public var width:Number;
		/**
		 * 渲染的高
		 */
		public var height:Number;
		/**
		 * 切换到下张图所需的时间
		 */
		public var renderSpeed:uint;

		public function RenderData( w:Number, h:Number, sp:uint, f:Vector.<BitmapFrameData> )
		{
			width = w;
			height = h;
			frames = f;
			renderSpeed = sp;
		}

		public function dispose():void
		{
			for each (var eachFrame : BitmapFrameData in frames) {
				eachFrame.dispose();
			}
		}
	}
}
