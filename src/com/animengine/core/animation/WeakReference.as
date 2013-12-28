package com.animengine.core.animation {

import flash.utils.Dictionary;

public class WeakReference{
	
	private var weakDic:Dictionary;
	
	public function WeakReference(v:*=null){
		super();
		this.value = v;
	}
	
	public function set value(v:*):void{
		if(v == null){
			weakDic = null;
		}else{
			weakDic = new Dictionary(true);
			weakDic[v] = null;
		}
	}
	
	public function get value():*{
		if(weakDic){
			for(var v:* in weakDic){
				return v;
			}
		}
		return null;
	}

	public function clear():void{
		weakDic = null;
	}
}
}