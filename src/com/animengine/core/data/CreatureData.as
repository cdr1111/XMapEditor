package com.animengine.core.data{
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	/**
	 * @author flashpf
	 */
	public class CreatureData {
		protected var _id : int;
		protected var _name : String;
		protected var _halfW : int;
		protected var _halfH : int;
		protected var _source : Rectangle;
		protected var _fixedDist : int;
		protected var _fixedHigh : int;
		protected var _backSpeed : int;
		protected var _airSpeedX : int;
		protected var _airSpeedZ : int;
		protected var _hitWait : int;
		protected var _key : String;
		protected var _lib : String;
		// protected var _list : BDList;
		protected var _actions : Dictionary;
		protected var _atks : Array;
		protected var _height : int;
		protected var _libs : Array;
		protected var _type : int;
		public var hp : uint;
		public var walkSpeedX : uint;
		public var walkSpeedY : uint;
		public var runSpeedX : uint;
		public var runSpeedY : uint;
		
		public function CreatureData() {
			_actions = new Dictionary();
			_atks = new Array();
			_libs = new Array();
		}
		
		public function get id() : int {
			return _id;
		}
		
		public function get name() : String {
			return _name;
		}
		
		public function get halfW() : int {
			return _halfW;
		}
		
		public function get halfH() : int {
			return _halfH;
		}
		
		public function get source() : Rectangle {
			return _source;
		}
		
		public function get fixedDist() : int {
			return _fixedDist;
		}
		
		public function get fixedHigh() : int {
			return _fixedHigh;
		}
		
		public function get backSpeed() : int {
			return _backSpeed;
		}
		
		public function set id(newId : int) : void {
			_id = newId;
		}
		
		public function get airSpeedX() : int {
			return _airSpeedX;
		}
		
		public function get airSpeedZ() : int {
			return _airSpeedZ;
		}
		
		public function get hitWait() : int {
			return _hitWait;
		}
		
		public function get libs() : Array {
			return _libs;
		}
		
		public function canAtk(atks : Array, dx : int, dy : int) : void {
			
		}
		
		public function atAtkRange(dx : int, dy : int) : Boolean {
			
			return false;
		}
		
		public function render() : void {
		}
		
		public function get actions() : Dictionary {
			return _actions;
		}
		
		public function get atks() : Array {
			return _atks;
		}
		
		public function parseObj(value : Object) : void {
			_id = value.id;
			_name = value.name;
			_halfW = (value.halfW != null ? value.halfW : 0);
			_halfH = (value.halfH != null ? value.halfH : 0);
			if (value.source != null) {
				_source = new Rectangle(value.source.x, value.source.y, value.source.width, value.source.height);
			}
		}
		
		public function set halfW(halfW : int) : void {
			_halfW = halfW;
		}
		
		public function set halfH(halfH : int) : void {
			_halfH = halfH;
		}
		
		public function set source(source : Rectangle) : void {
			_source = source;
		}
		
		public function set atks(atks : Array) : void {
			_atks = atks;
		}
		
		public function get type() : int {
			return _type;
		}
		
		public function set type(type : int) : void {
			_type = type;
		}
		
		public function set backSpeed(backSpeed : int) : void {
			_backSpeed = backSpeed;
		}
		
		public function set airSpeedX(airSpeedX : int) : void {
			_airSpeedX = airSpeedX;
		}
		
		public function set airSpeedZ(airSpeedZ : int) : void {
			_airSpeedZ = airSpeedZ;
		}
		
		public function set hitWait(hitWait : int) : void {
			_hitWait = hitWait;
		}
		
	}
}
