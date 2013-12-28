/* 
	Eb163 Flash RPG Webgame Framework
	@author eb163.com
	@email game@eb163.com
	@website www.eb163.com
 */
package com.mapeditor.layers
{
	
	import com.mapeditor.utils.ImageLoader;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.Event;
	
	import mx.core.UIComponent;

	//地图层 图片
	public class MapLayer extends UIComponent
	{
		//图片读取器
		private var _imageLoader:ImageLoader;
//		private var _image:Bitmap;
		private var _inputW:int;
		private var _sectionNumber:int;
		private var _eachWidth:Array;
		private var _arrSprite:Array;
		public function MapLayer(sectionNumber:int, eachWidths:Array, w:int )
		{
			_sectionNumber = sectionNumber;
			_eachWidth = eachWidths;
			_inputW = w;
		}
		//读取地图图片
		public function load(src:String):void{
			_imageLoader = new ImageLoader();
			_imageLoader.load(src);
			_imageLoader.addEventListener(Event.COMPLETE,loadSuccess);
		}
		//读取成功
		public function loadSuccess(evet:Event):void{
			dispatchEvent(evet);
			while(numChildren)
			{
				removeChildAt(0);
			}
			var bitmap:BitmapData = _imageLoader.data;
			var curW:int = _inputW;
			
			var _x:int = 0;
			while(1)
			{
				if(_x >= _inputW)
					break;
				if(curW <= bitmap.width)
				{
					var _image:Bitmap = new Bitmap(bitmap.clone());	
					addChild(_image);
					_image.x = 0;
					break;
				}else
				{
					var _image2:Bitmap = new Bitmap(bitmap.clone());	
					addChild(_image2);
					_image2.x = _x;
					_x += _image2.width;
				}
			}
			
			this.width = _inputW;
			this.height = 600;
			_imageLoader.removeEventListener(Event.COMPLETE,loadSuccess);
			
			_arrSprite = [];
			//绘制 分段线
			if(_sectionNumber <= 1)
				return;
			var i:int = 0;
			var eW:int;
			var oldW:int;
			for(i = 0; i<_sectionNumber; ++i)
			{
				oldW = oldW + int(_eachWidth[i]);
				var sprite:Shape = new Shape();
				sprite.graphics.beginFill(0xff0000);
				sprite.graphics.drawRect(0, 0, 2, this.height);
				sprite.graphics.endFill();
				sprite.x = oldW;
				this.addChild(sprite);
				_arrSprite.push(sprite);
//				oldW += eW;
			}
		}
	}
}