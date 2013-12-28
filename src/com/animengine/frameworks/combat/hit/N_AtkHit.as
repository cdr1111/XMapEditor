package com.animengine.frameworks.combat.hit
{
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;
    
    public final class N_AtkHit extends Object
    {
        public function N_AtkHit()
        {
            super();
            this._list = new Dictionary();
			
            {
                this._hitSp = new Sprite();
                var loc1:*;
                this._hitSp.mouseEnabled = loc1 = false;
                this._hitSp.mouseChildren = loc1;
            }
            return;
        }

        public function get keys():Array
        {
            var loc2:*=null;
            var loc1:*=new Array();
            var loc3:*=0;
            var loc4:*=this._list;
            for each (loc2 in loc4) 
            {
                loc1.push(loc2.key);
            }
            return loc1;
        }

        public function get weaponType():int
        {
            return this._weaponType;
        }

        public function get mode():int
        {
            return this._mode;
        }

        public function get type():int
        {
            return this._type;
        }

        public function get percent():int
        {
            return this._percent;
        }

        public function get fixed():int
        {
            return this._fixed;
        }

        public function get dist():int
        {
            return this._dist;
        }

        public function get high():int
        {
            return this._high;
        }

        public function get hitWait():int
        {
            return this._hitWait;
        }

        public function get halfH():int
        {
            return this._halfH;
        }

        public function getBy(arg1:int):com.animengine.frameworks.combat.hit.N_HitData
        {
            if (this._list[arg1] == null) 
            {
                return this._list[-1];
            }
            return this._list[arg1];
        }

        public function get rangeX():int
        {
            return this._rangeX;
        }

        public function get rangeY():int
        {
            return this._rangeY;
        }

        public function drawHitData(arg1:com.animengine.frameworks.combat.hit.N_HitData):void
        {
            var loc1:*=null;
            this._hitSp.graphics.clear();
            if (arg1 != null) 
            {
                this._hitSp.graphics.lineStyle(1, 16711680);
                loc1 = arg1.hitRect;
                this._hitSp.graphics.drawRect(loc1.x, loc1.y, loc1.width, loc1.height);
                trace("draw " + loc1);
            }
            return;
        }

        public function clearHitdata():void
        {
            if (this._hitSp && this._hitSp.parent) 
            {
                this._hitSp.graphics.clear();
                this._hitSp.parent.removeChild(this._hitSp);
            }
            return;
        }

        public function parseObj(arg1:Object):void
        {
            var loc1:*=null;
            var loc4:*=0;
            var loc6:*=null;
            var loc7:*=null;
            this._weaponType = arg1.weaponType;
            this._mode = com.animengine.frameworks.combat.hit.N_HitMode.getType(arg1.modeName);
            this._type = com.animengine.frameworks.combat.hit.N_HitType.getType(arg1.typeName);
            this._halfH = arg1.halfH;
            this._percent = arg1.percent;
            this._fixed = arg1.fixed;
            this._dist = arg1.dist;
            this._high = arg1.high;
            this._hitWait = arg1.hitWait;
            var loc2:*=arg1.keys.length;
            var loc3:*=arg1.sames.length - 1;
            var loc5:*=arg1.sources.length - 1;
            var loc8:*=0;
            while (loc8 < loc2) 
            {
//                loc4 = arg1.sames[com.animengine.util.MathUtil.clamp(loc8, 0, loc3)];
//                loc7 = arg1.sources[com.animengine.util.MathUtil.clamp(loc8, 0, loc5)];
//                loc6 = new flash.geom.Rectangle(loc7.x, loc7.y, loc7.width, loc7.height);
//                loc1 = new com.animengine.frameworks.combat.hit.N_HitData(this, arg1.keys[loc8], loc4, loc6);
//                this._list[this._weaponType * 100 + loc1.key] = loc1;
//                this._rangeX = Math.max(this._rangeX, loc6.right);
//                ++loc8;
            }
            this._rangeY = Math.max(this._rangeY, this._halfH);
            return;
        }

        public function get hitSp():flash.display.Sprite
        {
            return this._hitSp;
        }

        private var _list:flash.utils.Dictionary;

        private var _weaponType:int;

        private var _mode:int;

        private var _type:int;

        private var _halfH:int;

        private var _percent:int;

        private var _fixed:int;

        private var _dist:Number;

        private var _high:Number;

        private var _hitWait:int;

        private var _rangeX:int;

        private var _rangeY:int;

        private var _hitSp:flash.display.Sprite;
    }
}
