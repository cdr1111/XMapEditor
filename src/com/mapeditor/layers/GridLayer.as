/* 
	Eb163 Flash RPG Webgame Framework
	@author eb163.com
	@email game@eb163.com
	@website www.eb163.com
 */
package com.mapeditor.layers
{
	import com.mapeditor.utils.MapEditorConstant;
	import com.mapeditor.utils.MapEditorUtils;
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.geom.Point;
	
	import mx.core.UIComponent;
	
	public class GridLayer extends UIComponent
	{
		
		
		private var _mapWidth:int;		//地图网格宽度
		private var _mapHeight:int;		//地图网格高度
		
		private var _tilePixelWidth:int;	//一个网格的象素宽
		private var _tilePixelHeight:int;	//一个网格的象素高
		
		private var _gridLineColor:uint = 0xbbbbbb;//线条颜色
		
		
		private var _wHalfTile:int;	//网格象素宽的一半
		private var _hHalfTile:int;	//网格象素高的一半
		
		
		public function GridLayer()
		{
			this.mouseEnabled = false;
		}
		
		//画制网格
		public function drawGrid(mapWidth:int, mapHeight:int, tilePixelWidth:int, tilePixelHeight:int):void
		{
			this._mapWidth = mapWidth;
			this._mapHeight = mapHeight;
			this._tilePixelWidth = tilePixelWidth;
			this._tilePixelHeight = tilePixelHeight;
			var row:int = this._mapHeight/this._tilePixelHeight;
			var col:int = this._mapWidth/this._tilePixelWidth; 
			var grid:Shape = new Shape();
			this.addChild(grid);
			
			grid.graphics.lineStyle(1, _gridLineColor, 1);
			
			var i:int = 0;
			for( i = 0; i<row+1; ++i )
			{
				grid.graphics.moveTo( 0, i*this._tilePixelHeight );
				
				grid.graphics.lineTo( this._mapWidth, this._tilePixelHeight*i );
			}
			
			for( i = 0; i<col+1; ++i )
			{
				grid.graphics.moveTo( i*this._tilePixelWidth, 0 );
				
				grid.graphics.lineTo( this._tilePixelWidth*i, this._mapHeight );
			}
			//重设宽高，滚动条用
			this.width = col * this._tilePixelWidth + this._tilePixelWidth/2;
			this.height = (row + 1) * this._tilePixelHeight / 2;
		}
		
		

	}
}