package com.animengine.core.animation {
	import com.animengine.core.data.PlayData;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageQuality;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;

	/**
	 * @author Halley
	 */
	public class BitmapAnimation extends Bitmap {
		public static const DISPOSE : String = "DISPOSE";
		
		/**
		 * 当前帧:从1开始
		 */
		public var currentFrame : int;
		/**
		 * 总帧数
		 */
		public var totalFrames : int;
		/**
		 * 是否只播放一次
		 */
		public var playOnce : Boolean;
		/**
		 * 播放时重复的次数
		 */
		public var repeat : int = -1;
		/**
		 * 已经重复播放的次数
		 */
		public var repeatCount : uint;
		/**
		 * X轴偏移量（设置了偏移量在下一帧执行,立即执行调用setPosiction方法）等同于displayObject的X(重要！)
		 */
		private var _xOffset : Number = 0;
		/**
		 * Y轴偏移量（设置了偏移量在下一帧执行,立即执行调用setPosiction方法）
		 */
		private var _yOffset : Number = 0;
		/**
		 * 是否需要渲染（播放）
		 */
		public var needRender : Boolean;
		/**
		 * 
		 */
		public var needDisappear : Boolean;
		/**
		 * 初始化class
		 */
		public var factory : Class;
		/**
		 * 标记是否停止播放
		 */
		public var isStoped : Boolean;
		/**
		 * 标记初始化是否完成
		 */
		public var isLoaded : Boolean;
		/**
		 * 适应原来在ART时的坐标
		 */
		// public var adjust:Boolean;
		public var renderBySelf : Boolean = true;
		/**
		 * 多少毫秒切一张图
		 */
		public var renderSpeed : uint;
		protected var _onChange : Function;

		public function get isReverse() : Boolean {
			return _isReverse;
		}

		public function set isReverse(value : Boolean) : void {
			if (_isReverse == value) {
				return;
			}
			_isReverse = value;
			_playFrames.reverse();
			currentFrame = _playFrames.length - currentFrame;
		}

		/**
		 * 每次放完frames触发
		 */
		public var executeWhenEnd : Function;
		public var currentFramData : BitmapFrameData;
		private var _frames : Vector.<BitmapFrameData>;
		private var _playFrames : Array;
		private var _time : int;
		private var startLifeTimer : int;
		private var _lifeTime : int;
		private var _tempFrameFuns : Dictionary;

		public function get lifeTime() : int {
			return _lifeTime;
		}

		/**
		 * 生命周期，到时间自动清除
		 */
		public function set lifeTime(value : int) : void {
			_lifeTime = value;
			startLifeTimer = getTimer();
		}

		protected var _flipH : Boolean = true;
		protected var _flipHChange : Boolean;

		public function set flipH(value : Boolean) : void {
			if (_flipH == value) {
				return;
			}
			_flipH = value;
			_flipHChange = true;
		}

		public function get flipH() : Boolean {
			return _flipH;
		}

		/**
		 * 每帧的bitmapdata
		 */
		public function get frames() : Vector.<BitmapFrameData> {
			return _frames;
		}

		public function get time() : int {
			return _time;
		}

		public function set time(value : int) : void {
			_time = value;
		}

		private var _isReverse : Boolean = false;

		/**
		 * 立刻让动画移动至某地方
		 * @param xPos X坐标
		 * @param yPos Y坐标
		 * @param alwaysOffset 是否下一帧也到这
		 */
		public function setPosiction(xPos : Number, yPos : Number, alwaysOffset : Boolean = true) : void {
			if (!currentFramData) return;
			var rec : Rectangle = _flipH ? currentFramData.reverseRectangle : currentFramData.rectangle;
			if (rec) {
				var tempX : Number = rec.x + xPos;
				var tempY : Number = rec.y + yPos;

				if (x != tempX) x = tempX;
				if (y != tempY) y = tempY;
			} else {
				if (x != xPos) x = xPos;
				if (y != yPos) y = yPos;
			}
			if (alwaysOffset) {
				_xOffset = xPos;
				_yOffset = yPos;
			}
		}

		/**
		 * 影片剪辑转位图动画
		 * @param factory 初始化CLASS
		 * @param renderBySelf 是否在自身添加ENTER_FRAME事件渲染
		 */
		public function BitmapAnimation(factory : Class = null, renderBySelf : Boolean = false, playOnce : Boolean = false) {
			this.playOnce = playOnce;
			this.renderBySelf = renderBySelf;
			this.factory = factory;
			if (stage) onAddedToStage();
			else addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}

		private function onRemovedFromStage(event : Event) : void {
			dispose(false);
		}

		private function onAddedToStage(event : Event = null) : void {
			resetRenderTime();
			if (isLoaded == false && factory) creatFrames();
			addSelfRender();
		}

		public function addSelfRender() : void {
			if (renderBySelf && needRender) {
				if ( !hasEventListener(Event.ENTER_FRAME) )
					addEventListener(Event.ENTER_FRAME, onRender, false, 0, true);
			}
		}

		/**
		 * 手动添加动画数据factory类将会失效
		 * @param value 每帧的数据
		 * @param renderNow 是否现在立即绘制
		 */
		public function setFrames(value : Vector.<BitmapFrameData>, renderNow : Boolean = true) : void {
			_frames = value;
			isLoaded = true;
			totalFrames = value.length;
			needRender = totalFrames > 1;
			resetFrames(_playFrames, false);
			if (renderNow) {
				gotoAndPlay(currentFrame ? currentFrame : 1);
				if (!currentFrame) resetRenderTime();
			}
		}
		public function resetFramesArr(value : Array, needRendNow : Boolean = true) : void {
			resetFrames(value, needRendNow);
		}
		protected function resetFrames(value : Array, needRendNow : Boolean = true) : void {
			if (_playFrames == null) _playFrames = new Array();
			_playFrames.splice(0);
			var total : int;
			var i : int;
			if (value == null || value.length < 1) {
				total = _frames.length;
				for (i = 0;i < total;i++) {
					_playFrames.push(i);
				}
			} else {
				total = value.length;
				for (i = 0;i < total;i++) {
					_playFrames.push(value[i]);
				}
			}
			currentFrame = 1;
			totalFrames = _playFrames.length;
			// _frame = -1;
			needRender = totalFrames > 1;
			if (needRender && needRendNow) {
				gotoAndPlay(currentFrame ? currentFrame : 1);
				if (!currentFrame) resetRenderTime();
			}
		}

		/**
		 * 修改帧
		 */
		public function changeFrames(index : int, frames : Array) : void {
			if (index < 0 || index >= _playFrames.length) {
				return;
			}
			for (var i : int = 0;i < frames.length;i++) {
				_playFrames[index + i] = frames[i];
			}
		}

		public function playBy(value : PlayData) : void {
			// if (_list == null) {
			// return;
			// }
			renderSpeed = value.delay;
			if (renderSpeed < 33) {
				renderSpeed = 33;
			}
			repeat = value.loop;
			_onChange = value.change;
			resetFrames(value.frames);
			executeWhenEnd = value.complete;
			addSelfRender();
		}

		public function resetRenderTime() : void {
			if (renderSpeed) _time = getTimer();
		}

		/**
		 * 生成所有帧的bitmadata
		 */
		public function creatFrames(fac : Class = null) : Vector.<BitmapFrameData> {
			var oldQuality : String = stage.quality;
			stage.quality = StageQuality.BEST;
			if (fac != null)
				factory = fac;
			var mc : * = new factory();
			_frames = new Vector.<BitmapFrameData>();
			_playFrames = new Array();
			if (mc is MovieClip) {
				totalFrames = mc.totalFrames;
				for (var i : int = 1; i <= totalFrames; i++) {
					mc.gotoAndStop(i);
					frames.push(getBitmapData(mc));
				}
				needRender = true;
			} else if (mc is Sprite) {
				totalFrames = 1;
				frames.push(getBitmapData(mc));
			} else {
				throw new Error("不是Sprite");
			}
			resetFrames(null, false)
			gotoAndPlay(1);
			stage.quality = oldQuality;
			isLoaded = true;
			dispatchEvent(new Event(Event.COMPLETE));
			return frames;
		}

		private function onRender(event : Event) : void {
			render();
		}

		protected function getBitmapData(obj : DisplayObjectContainer) : BitmapFrameData {
			var bmd : BitmapFrameData;
			var bounds : Rectangle = obj.getRect(obj);
			bounds.x = Math.round(bounds.x);
			bounds.y = Math.round(bounds.y);
			bmd = new BitmapFrameData();
			bmd.bitmapData = new BitmapData(bounds.width, bounds.height, true, 0x00);
			bmd.bitmapData.draw(obj, new Matrix(1, 0, 0, 1, -bounds.x, -bounds.y));
			bmd.rectangle = bounds;
			return bmd;
		}

		public function reset() : void {
			repeat = -1;
			repeatCount = 0;
			_onChange = null;
			executeWhenEnd = null;
		}

		/**
		 * 跳到某帧
		 * @param adjustPosition 根据影片剪辑绘制时的坐标定位
		 */
		public function gotoAndPlay(frame : int, adjustPosition : Boolean = true) : void {
			// trace( "goto frame:" + frame + " totalFrames:" + totalFrames );
			currentFrame = frame;
			var endFlag : Boolean;
			if (currentFrame > totalFrames) {
				endFlag = true;
				if ( endFlag && executeWhenEnd != null ) {
					executeWhenEnd(this);
				}
				if (repeat != -1) {
					repeatCount++;
					if (repeatCount >= repeat) {
						dispose();
						return;
					}
				}
				if (playOnce) {
					dispose();
					return;
				} else {
					currentFrame = 1;
				}
			}
			gotoAndSet(currentFrame, adjustPosition);
		}

		protected function gotoAndSet(frame : int, adjustPosition : Boolean = true) : void {
			if (!frames || _playFrames.length == 0 || frame > _playFrames.length) return;
			currentFramData = frames[_playFrames[frame - 1]];
			currentFramData.execute();
			if (_tempFrameFuns) {
				if (_tempFrameFuns[_playFrames[frame - 1]] != null) {
					var functions : Vector.<Function> = _tempFrameFuns[frame - 1];
					for each (var fun:Function in functions) {
						fun();
					}
				}
			}
			// new version
			if (bitmapData != currentFramData.bitmapData) {
				bitmapData = currentFramData.bitmapData;
			}
			reverse(parent);
			// // /

			if (adjustPosition) {
				setPosiction(currentFramData.offsetX != 0 ? currentFramData.offsetX : _xOffset, currentFramData.offsetY != 0 ? currentFramData.offsetY : _yOffset, false);
			}
			if (_onChange != null)
				_onChange(this);
		}
		
		protected function reverse(container : DisplayObjectContainer) : void {
			if (container) {
				if (_flipH) {
					if (container.scaleX != -1) {
						container.scaleX = -1;
						// container.x = -_defultContainerX + CELL_WIDTH;
					}
				} else {
					if (container.scaleX != 1) {
						container.scaleX = 1;
						// container.x = _defultContainerX;
					}
				}
			}
		}

		public function gotoAndStop(frame : int, adjustPosition : Boolean = true) : void {
			gotoAndSet(frame, adjustPosition);
			isStoped = true;
		}

		public function gotoAndStopLastFrame(adjustPosition : Boolean = true) : void {
			gotoAndSet(totalFrames, adjustPosition);
			isStoped = true;
		}

		/**
		 * 下一帧
		 */
		public function nextFrame() : void {
			if (isLoaded) {
				_nextFrame();
			} else {
				var loadedFun : Function = function(event : Event) : void {
					_nextFrame();
				};
				addEventListener(Event.COMPLETE, loadedFun);
			}
		}

		/**
		 * 添加帧代码
		 */
		public function addFrameScript(frameIndex : int, fun : Function, isOnce : Boolean = false) : void {
			if (isLoaded) {
				var frameBmd : BitmapFrameData = frames[frameIndex - 1];
				if (fun == null) {
					frameBmd.functions = null;
				} else {
					if (frameBmd.functions == null || isOnce) frameBmd.functions = new Vector.<Function>();
					frameBmd.functions.push(fun);
				}
			} else {
				trace("Warning addFrameScript :not loaded");
			}
		}

		/**
		 * 添加帧代码
		 */
		public function addTempFrameScript(frameIndex : int, fun : Function) : void {
			if (isLoaded) {
				var frameBmd : BitmapFrameData = frames[frameIndex - 1];
				var functions : Vector.<Function>;
				if (_tempFrameFuns == null) _tempFrameFuns = new Dictionary(true);
				if (_tempFrameFuns[frameIndex - 1] == null) {
					functions = new Vector.<Function>();
				} else {
					functions = _tempFrameFuns[frameIndex - 1];
				}
				functions.push(fun);
				_tempFrameFuns[frameIndex - 1] = functions;
			} else {
				trace("Warning addFrameScript :not loaded");
			}
		}

		private function _nextFrame() : void {
			isStoped = true;
			if (currentFrame + 1 <= totalFrames) {
				currentFrame++;
			} else {
				currentFrame = 1;
			}
			gotoAndPlay(currentFrame);
		}

		/**
		 * 上一帧
		 */
		public function prevFrame() : void {
			if (isLoaded) {
				_prevFrame();
			} else {
				var loadedFun : Function = function(event : Event) : void {
					_prevFrame();
				};
				addEventListener(Event.COMPLETE, loadedFun);
			}
		}

		private function _prevFrame() : void {
			isStoped = true;
			if (currentFrame - 1 > 0) {
				currentFrame--;
			} else {
				currentFrame = totalFrames;
			}
			gotoAndPlay(currentFrame);
		}

		public function clone() : BitmapAnimation {
			var anim : BitmapAnimation = new BitmapAnimation();
			anim.renderBySelf = renderBySelf;
			anim.renderSpeed = renderSpeed;
			anim.setFrames(frames);
			anim.name = name;
			return anim;
		}

		public function dispose(removeContent : Boolean = true) : void {
			isReverse = false;
			_time = 0;
			if (needDisappear) {
				// EffectManager.disappearWin( this, 1.5, true );6
			} else {
				if (parent && removeContent) {
					parent.removeChild(this);
				}
			}
			_tempFrameFuns = null;
			removeEventListener(Event.ENTER_FRAME, onRender);
			dispatchEvent(new Event(DISPOSE));
		}

		public function stop() : void {
			isStoped = true;
		}

		public function play() : void {
			isStoped = false;
		}

		/**
		 * 从头开始播放，只播放一次
		 */
		public function playFromStart() : void {
			this.visible = true;
			gotoAndPlay(1);
		}

		/**
		 * 渲染
		 * @param renderCount 跳帧次数
		 */
		public function render(renderCount : uint = 1) : void {
			if ( isStoped ) return;
			if ( totalFrames == 1) {
				if ( executeWhenEnd != null ) {
					executeWhenEnd();
				}
				return;
			}
			if (needRender) {
				if (lifeTime) {
					if (getTimer() - startLifeTimer >= lifeTime) {
						dispose();
						return;
					}
				}

				if (renderSpeed > 0) {
					renderCount = int((getTimer() - _time) / renderSpeed);
					if (renderCount > 0) {
						_time = getTimer();
					} else return;
				}
				currentFrame += renderCount;
				gotoAndPlay(currentFrame);
			}
		}

		public function get onChange() : Function {
			return _onChange;
		}

		public function set onChange(onChange : Function) : void {
			_onChange = onChange;
		}

		public function get playFrames() : Array {
			return _playFrames;
		}

		public function set playFrames(playFrames : Array) : void {
			resetFrames(playFrames);
		}

		public function get yOffset() : Number {
			return _yOffset;
		}
		public function get xOffset() : Number {
			return _xOffset;
		}
	}
}