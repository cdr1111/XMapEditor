/* 
	Eb163 Flash RPG Webgame Framework
	@author eb163.com
	@email game@eb163.com
	@website www.eb163.com
 */
package com.mapeditor.utils
{
	
	
	import flash.utils.Dictionary;
	
	/**
	 * 类似java中HashMap类的实现 继承于IMap 具体方法说明见IMap中的注释
	 * */
	public class HashMap
	{
		private var _keys:Array=null;
		private var props:Dictionary=null;

		public function HashMap() {
			this.clear();
		}
		public function clear():void {
			this.props=new Dictionary  ;
			this._keys=new Array  ;
		}
		public function containsKey(key:Object):Boolean {
			return this.props[key]!=null;
		}
		public function containsValue(value:Object):Boolean {
			var result:Boolean=false;
			var len:uint=this.size();
			if (len>0) {
				for (var i:uint=0; i<len; i++) {
					if (this.props[this._keys[i]]==value) {
						result =  true;
						break;
					}
				}
			}
			return result;
		}
		public function getValue(key:Object):Object {
			return this.props[key];
		}
		public function put(key:Object,value:Object):Object {
			var result:Object=null;
			if (this.containsKey(key)) {
				result=this.getValue(key);
				this.props[key]=value;
			} else {
				this.props[key]=value;
				this._keys.push(key);
			}
			return result;
		}
		public function remove(key:Object):Object {
			var result:Object=null;
			if (this.containsKey(key)) {
				delete this.props[key];
				var index:int=this._keys.indexOf(key);
				if (index>-1) {
					this._keys.splice(index,1);
				}
			}
			return result;
		}
		public function putAll(map:HashMap):void {
			this.clear();
			var len:uint=map.size();
			if (len>0) {
				var arr:Array=map.keys();
				for (var i:uint=0; i<len; i++) {
					this.put(arr[i],map.getValue(arr[i]));
				}
			}
		}
		public function size():uint {
			return this._keys.length;
		}
		public function isEmpty():Boolean {
			return this.size()  <1;
		}
		public function values():Array {
			var result:Array=new Array  ;
			var len:uint=this.size();
			if (len>0) {
				for (var i:uint=0; i<len; i++) {
					result.push(this.props[this._keys[i]]);
				}
			}
			return result;
		}
		public function keys():Array {
			return this._keys;
		}

	}
}