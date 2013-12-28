/* 
	Eb163 Flash RPG Webgame Framework
	@author eb163.com
	@email game@eb163.com
	@website www.eb163.com
 */
package com.mapeditor.layers
{
	import com.animengine.core.DepthSort;
	import com.animengine.core.animation.BitmapAnimation;
	import com.animengine.core.animation.WrapperedAnimation;
	import com.animengine.core.data.PlayData;
	import com.animengine.net.loader.ImageModel;
	import com.animengine.net.loader.StaticDataModel;
	import com.mapeditor.items.Building;
	import com.mapeditor.utils.MapEditorConstant;
	import com.mapeditor.utils.MapEditorUtils;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.geom.Point;
	import flash.text.ReturnKeyLabel;
	
	import mx.core.UIComponent;
	
	public class BuildingLayer extends UIComponent
	{
		public var buildingArray:Array;	//所有building数组，数组索引对应building id
		private var uId:int = 0;		//建筑数
		private var _depthSort:DepthSort;
		
		public function BuildingLayer()
		{
			buildingArray = new Array();
			_depthSort = new DepthSort(this);
		}
		
		public function placeAndClone(bld:Building, tilePoint:Point):Building
		{
			var nbld:Building = new Building(this.uId);
			//存储笔刷格式
			nbld.reset(bld._dispAnm);
			this.addChild(nbld);
			
			nbld.tId = bld.tId;
			trace("添加一个id:"+nbld.tId);
			nbld.x = tilePoint.x;
			nbld.y = tilePoint.y;
			nbld._dispAnm.renderBySelf = true;
			
			nbld.index = _depthSort.reset(nbld);
			nbld.type = bld.type;
			nbld.source = bld.source;
			
			this.buildingArray.push(nbld);
			nbld._dispAnm.gotoAndStop(1);
			this.uId++;
			return nbld;
		}
		//移除建筑
		public function removeBuild(bld:Building):void{
			var index:int = buildingArray.indexOf(bld);
			buildingArray.splice(index, 1);
//			delete buildingArray[bld.id];
			removeChild(bld);
		}
		
		//读取XML配置 放置建筑
		public function drawByXml(mapXml:XML):void{
			if(null == mapXml || mapXml.children().length() == 0)
			{
				return;
			}
			while(numChildren)
			{
				removeChildAt(0);
			}
			this.buildingArray = [];
			var dispAnm:BitmapAnimation;
			if(null != mapXml.npc && 0 != mapXml.npc.children().length())
			{
				for each(var _itemXml:XML in mapXml.npc.node){
					if(_itemXml)
					{
						ImageModel.instance.getAnimRes(_itemXml.@source, function(frames : WrapperedAnimation) : void
						{
							dispAnm = new BitmapAnimation(null, false);
							StaticDataModel.instance.setOffset(_itemXml.@source, frames.frames);
							dispAnm.renderSpeed = frames.renderSpeed;
							dispAnm.setFrames(frames.frames);
							dispAnm.gotoAndStop(1);
							
							setBrushBitmapData(dispAnm, _itemXml);
						});
					}
				}
			}
			if(null != mapXml.monster && 0 != mapXml.monster.children().length())
			{
				for each(var _monsterXml:XML in mapXml.monster.node){
					if(_monsterXml)
					{
						ImageModel.instance.getAnimRes(_monsterXml.@source, function(frames : WrapperedAnimation) : void
						{
							dispAnm = new BitmapAnimation(null, false);
							StaticDataModel.instance.setOffset(_monsterXml.@source, frames.frames);
							dispAnm.renderSpeed = frames.renderSpeed;
							dispAnm.setFrames(frames.frames);
							dispAnm.gotoAndStop(1);
							setBrushBitmapData(dispAnm, _monsterXml);
						});
					}
				}
			}
		}
		
		
		private function setBrushBitmapData(dispAnm:BitmapAnimation, itemXml:XML):void
		{
			var nbld:Building = new Building(itemXml.@id);
			this.buildingArray.push(nbld);
			var tilePoint:Point = new Point(itemXml.@x, itemXml.@y);
			//存储笔刷格式
			nbld.reset(dispAnm);
			this.addChild(nbld);
			nbld.x = tilePoint.x;
			nbld.y = tilePoint.y;
			
			nbld.tId = itemXml.@id;
			nbld.index = _depthSort.reset(nbld);
			nbld.type = itemXml.@type;
			nbld.source = itemXml.@source;
			nbld._dispAnm.gotoAndStop(1);
			this.uId++;
		}
	}
}