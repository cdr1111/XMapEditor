package  com.animengine.core.creature{
	import com.animengine.frameworks.combat.ai.action.LinkAction;
	
	import flash.filters.GlowFilter;
	
	/**
	 * @author bright
	 */
	public class EnityState 
	{
		public static const NO_MOVE:int = 0;
		public static const DIR_UP:int = 1;
		public static const DIR_DOWN:int = 2;
		public static const DIR_LEFT:int = 3;
		public static const DIR_RIGHT:int = 4;
		public static const DIR_UP_LEFT:int = 5;
		public static const DIR_UP_RIGHT:int = 6;
		public static const DIR_DOWN_LEFT:int = 7;
		public static const DIR_DOWN_RIGHT:int = 8;
		
		
		public static const BRAVE_FILTER : GlowFilter = new GlowFilter(0xFFFF00, 1, 2, 2, 17, 1, false, false);
		public static const IGNORE_FILTER : GlowFilter = new GlowFilter(0xFFFFFF, 1, 2, 2, 17, 1, false, false);
		public static const SELF_EXPLODE_FILTER : GlowFilter = new GlowFilter(0xFF0000, 0.7, 10, 10, 2, 1, true, false);
		public var place : int;
		public var isDead : Boolean;
		private var _isUp : Boolean;
		private var _isDown : Boolean;
		private var _isLeft : Boolean;
		private var _isRight : Boolean;
		public var firstUp : Boolean;
		public var firstLeft : Boolean;
		public var isRun : Boolean;
		public var canFlipH : Boolean;
		private var _canMove : Boolean;
		public var hitFrame : int;
		public var nextType : int;
		public var linkNext : int;
		public var devilNext : int;
		public var isBrave : Boolean;
		public var isIgnore : Boolean;
		public var isSlow : Boolean;
		public var suckedT : EnityView;
		public var stoneType : int;
		public var linkAction : LinkAction;
		
		private var _moveDir:int = 0;
		protected var _hits : Array;
		
		public function EnityState() {
			reset();
			_hits = new Array();
		}
		
		public function get canMove():Boolean
		{
			return _canMove;
		}
		
		public function set canMove(value:Boolean):void
		{
			_canMove = value;
		}
		
		public function reset() : void {
			isDead = false;
			isRun = false;
			canFlipH = true;
			canMove = true;
			nextType = -1;
			linkNext = -1;
			devilNext = -1;
			stoneType = 0;
		}
		
		public function get isMove() : Boolean {
			return isLeft || isRight || isUp || isDown;
		}
		
		public function getMoveFlipH(flipH : Boolean) : Boolean {
			if (firstLeft) {
				if (isLeft) {
					return true;
				} else if (isRight) {
					return false;
				}
			} else {
				if (isRight) {
					return false;
				} else if (isLeft) {
					return true;
				}
			}
			return flipH;
		}
		
		public function get hits() : Array {
			return _hits;
		}
		public function setMoveDir(value:int, _isMove:Boolean):void
		{
			switch(value)
			{
				case DIR_UP:
					_isUp = _isMove;
					if(_isLeft && !firstUp)
						firstUp = true;
					break;
				case DIR_DOWN:
					_isDown = _isMove;
					firstUp = false;
					break;
				case DIR_LEFT:
					_isLeft = _isMove;
					if(_isLeft && !firstLeft)
						firstLeft = true;
					break;
				case DIR_RIGHT:
					_isRight = _isMove;
					firstLeft = false;
					break;
				case NO_MOVE:
					_isUp = false;
					_isDown = false;
					_isLeft = false;
					_isRight = false;
					//					canMove = true;
					break;
			}
			
			//			checkMoveDir();
		}
		//判断转换为8方向 数字
		public function checkMoveDir() : int
		{
			_moveDir = NO_MOVE;
			if (firstLeft) {
				if (isLeft) {
					_moveDir = DIR_LEFT;					
				} else if (isRight) {
					_moveDir = DIR_RIGHT;
				}
			} else {
				if (isRight) {
					_moveDir = DIR_RIGHT;
				} else if (isLeft) {
					_moveDir = DIR_LEFT;
				}
			}
			if (firstUp) {
				if (isUp) {
					_moveDir = _moveDir == DIR_LEFT ? DIR_UP_LEFT : _moveDir == DIR_RIGHT ? DIR_UP_RIGHT : DIR_UP;
				} else if (isDown) {
					_moveDir = _moveDir == DIR_LEFT ? DIR_DOWN_LEFT : _moveDir == DIR_RIGHT ? DIR_DOWN_RIGHT : DIR_DOWN;
				}
			} else {
				if (isDown) {
					_moveDir = _moveDir == DIR_LEFT ? DIR_DOWN_LEFT : _moveDir == DIR_RIGHT ? DIR_DOWN_RIGHT : DIR_DOWN;
				} else if (isUp) {
					_moveDir = _moveDir == DIR_LEFT ? DIR_UP_LEFT : _moveDir == DIR_RIGHT ? DIR_UP_RIGHT : DIR_UP;	
				}
			}
			return _moveDir;
		}
		public function get isUp():Boolean
		{
			return _isUp;
		}
		
		public function get isDown():Boolean
		{
			return _isDown;
		}
		
		public function get isLeft():Boolean
		{
			return _isLeft;
		}
		
		public function get isRight():Boolean
		{
			return _isRight;
		}
		
		public function get moveDir():int
		{
			return _moveDir;
		}
	}
}