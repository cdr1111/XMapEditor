package  com.animengine.net.loader{
	import com.animengine.core.data.CreatureData;
	import com.animengine.core.data.EffectData;
	import com.animengine.define.ResType;
	import com.animengine.frameworks.combat.hit.N_AtkHit;
	import com.animengine.util.ArrayUtil;
	import com.resManager.manage.Explorer;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * 很多静态数据，配置的信息在这里加载，解析
	 * @author Halley
	 */
	public class StaticDataService extends EventDispatcher
	{
		private static var _instance : StaticDataService ;
		public var nameList : XMLList;
		private var _loadList : Array = new Array();
		private var _urlLoader : URLLoader;
		private var _currentRequest : URLRequest;
		private var _currentLoad : Object;
		
		public var loadFunc:Function;

		public function loadAll() : void {
			_urlLoader = new URLLoader();
			_urlLoader.addEventListener(Event.COMPLETE, loaded);
			_currentRequest = new URLRequest();
			var url:String = "../resource/bin/data/";
//			addToLoadList(url + "PlayerData.xml", loadedCreatureData, ResType.HERO);
//			addToLoadList(url + "MonsterData.xml", loadedCreatureData, ResType.MONSTER);
//			addToLoadList(url + "BossData.xml", loadedCreatureData, ResType.BOSS);
			addToLoadList(url + "AnimationOffset.xml", loadedOffset);
//			addToLoadList(url + "PlayerActions.xml", loadedCreatureAction, ResType.HERO);
//			addToLoadList(url + "BossActions.xml", loadedCreatureAction, ResType.BOSS);
//			addToLoadList(url + "MonsterActions.xml", loadedCreatureAction, ResType.MONSTER);
//			addToLoadList(url + "EffectData.xml", loadedEffectData, ResType.EFFECTS);
//			addToLoadList(url + "NpcActions.xml", loadedCreatureAction, ResType.NPC);
//			addToLoadList(url + "NpcData.xml", loadedCreatureData, ResType.NPC);
			nextLoad();
		}
		
		private function loadedEffectData(data : XML, ...args):void
		{
		}


		
		public function initOffset() : void {
			var data : XML = Explorer.getinstance().getXml("AnimationOffset");
			if(null == data)
			{
				trace("AnimationOffset is null");
				return;
			}
			loadedOffset(data);
		}
		private function loadedOffset(data : XML, ...args) : void {
			var p : Point;
			var arr : Array;
			for each (var type : XML in data.type) {
				var type_ : int = int(type.@id);
				for each (var id : XML in type.id) {
					var id_ : int = int(id.@id);
					for each (var action : XML in id.action) {
						var action_ : int = int(action.@type);
						arr = StaticDataModel.instance.animCache[type_ + "_" + id_ + "_" + action_];
						if (arr == null) {
							arr = new Array();
							StaticDataModel.instance.animCache[type_ + "_" + id_ + "_" + action_] = arr;
						}
						for each (var offset : XML in action.offset) {
							p = new Point(int(offset.@x), int(offset.@y));
							arr.push(p);
						}
					}
				}
			}
		}

		private function loaded(event : Event) : void {
			_currentLoad.func(XML(event.target.data), _currentLoad.arg);
			nextLoad();
		}

		private function addToLoadList(key : String, fun : Function, ...args) : void {
			_loadList.push({key:key, func:fun, arg:args});
		}

		private function loadedCreatureData(data : XML, ...args) : void {
			var player : CreatureData;
			for each (var xml : XML in data.data) {
				player = parseCreatureData(xml, args[0]);
				StaticDataModel.instance.creatureData[player.type + "_" + player.id] = player;
			}
		}

		private function parseCreatureData(xml : XML, type : uint, id : uint = 0) : CreatureData {
			var data : CreatureData = new CreatureData();
			data.type = type;
			data.id = int(xml.@id);
			data.halfH = int(xml.@halfH);
			data.halfW = int(xml.@halfW);
			data.walkSpeedX = int(xml.@walkSpeedX);
			data.walkSpeedY = int(xml.@walkSpeedY);
			data.runSpeedX = int(xml.@runSpeedX);
			data.runSpeedY = int(xml.@runSpeedY);
			data.hp = int(xml.@hp);
			data.backSpeed = int(xml.@backSpeed);
			data.hitWait = int(xml.@hitWait);
			data.airSpeedX = int(xml.@airSpeedX);
			data.airSpeedZ = int(xml.@airSpeedZ);
			var source : Array = String(xml.@source).split(",");
			data.source = new Rectangle(parseInt(source[0]), parseInt(source[1]), parseInt(source[2]), parseInt(source[3]));
			return data;
		}

		private function nextLoad() : void {
			if (_loadList.length == 0) {
				//load完成
				if(null != loadFunc)
				{
					loadFunc();
					loadFunc = null;
				}
				return;
			}
			_currentLoad = _loadList.shift();
			_currentRequest.url = _currentLoad.key;
			_urlLoader.load(_currentRequest);
		}

		public static function get instance():StaticDataService
		{
			return _instance ||= new StaticDataService();
		}

	}
}