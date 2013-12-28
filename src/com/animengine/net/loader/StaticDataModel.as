package  com.animengine.net.loader{
	import com.animengine.core.animation.BitmapFrameData;
	import com.animengine.core.data.EffectData;
	import com.animengine.define.ResType;
	
	import flash.geom.Point;
	import flash.utils.Dictionary;

	/**
	 * @author Sampson
	 */
	public class StaticDataModel{
		private static var _instance : StaticDataModel ;
		public var animCache : Dictionary;
		private var _linkAtkMap : Dictionary;
		public var actionMap : Dictionary;
		public var creatureData : Dictionary;
		public var effectData : Dictionary;
		public function StaticDataModel() {
			
			animCache = new Dictionary();
			_linkAtkMap = new Dictionary();
			actionMap = new Dictionary();
			creatureData = new Dictionary();
			effectData = new Dictionary();
		}

		public function getHitRectObj(_x : int, _y : int, _width : uint, _height : uint) : Object {
			return {x:_x, y:_y, width:_width, height:_height};
		}
		public function getEffectData(type:String, id:String) : EffectData {
			return effectData[ResType.EFFECTS + "_" + type + "_" + id];
		}

		protected function getPoint(x : int, y : int) : Point {
			return new Point(x, y);
		}

		public function getAnimOffsetLength(packid : int, group : int, action : int) : int {
			var key : String = packid + "_" + group + "_" + action;
			var offsets : Array = animCache[key];
			if (offsets) {
				return offsets.length;
			} else
				return -1;
		}

		public function setOffset(key:String, vect : Vector.<BitmapFrameData>) : void {
			if (!vect)
				return;
//			var key : String = packid + "_" + group + "_" + action;
			var offsets : Array = animCache[key];
			if (offsets) {
				var len : int = Math.min(offsets.length, vect.length);
				var point : Point;
				for (var i : int = 0; i < len; i++) {
					point = offsets[i];
					vect[i].offsetX = point.x;
					vect[i].offsetY = point.y;
				}
			}
		}

		public function getAtkAction(type : int, id : int) : Array {
			return actionMap[type + "_" + id + "_atk"];
		}

		public static function get instance():StaticDataModel
		{
			_instance ||= new StaticDataModel();

			return _instance;
		}

		public function get linkAtkMap():Dictionary
		{
			return _linkAtkMap;
		}
	}
}
