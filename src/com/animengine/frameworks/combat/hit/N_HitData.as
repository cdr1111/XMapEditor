package com.animengine.frameworks.combat.hit
{
    import com.animengine.core.data.BlockData;
    
    import flash.geom.*;
    
    public final class N_HitData extends Object
    {
        public function N_HitData(arg1:com.animengine.frameworks.combat.hit.N_AtkHit, arg2:int, arg3:int, arg4:flash.geom.Rectangle)
        {
            super();
            this._owner = arg1;
            this._key = arg2;
            this._same = arg3;
            this._source = arg4;
            if (this._source != null) 
            {
                this._hitRect = this._source.clone();
            }
            return;
        }

        public function get owner():com.animengine.frameworks.combat.hit.N_AtkHit
        {
            return this._owner;
        }

        public function get key():int
        {
            return this._key;
        }

        public function get source():flash.geom.Rectangle
        {
            return this._source;
        }

        public function get hitRect():flash.geom.Rectangle
        {
            return this._hitRect;
        }

        public function get x():int
        {
            return this._x;
        }

        public function get same():int
        {
            return this._same;
        }

        public function get flipH():Boolean
        {
            return this._flipH;
        }

        public function reset(arg1:int, arg2:int, arg3:int, arg4:Boolean):void
        {
            this._x = arg1;
            this._y = arg2;
            this._z = arg3;
            this._flipH = arg4;
            if (this._flipH) 
            {
                this._hitRect.x = this._x - this._source.x - this._source.width;
            }
            else 
            {
                this._hitRect.x = this._x + this._source.x;
            }
            this._hitRect.y = this._y + this._source.y + this._z;
            return;
        }

        public function resetSource(arg1:flash.geom.Rectangle):void
        {
            this._source.x = arg1.x;
            this._source.y = arg1.y;
            var loc1:*;
            this._source.width = loc1 = arg1.width;
            this._hitRect.width = loc1;
            this._source.height = loc1 = arg1.height;
            this._hitRect.height = loc1;
            if (this._flipH) 
            {
                this._hitRect.x = this._x - this._source.x - this._source.width;
            }
            else 
            {
                this._hitRect.x = this._x + this._source.x;
            }
            this._hitRect.y = this._y + this._source.y + this._z;
            return;
        }

        public function checkHit(arg1:BlockData):Boolean
        {
            var loc1:*=this._y - arg1.y;
            if (this._owner.halfH > 0 && (loc1 > 0 ? loc1 : -loc1) > this._owner.halfH) 
            {
                return false;
            }
            return this._hitRect.intersects(arg1.hitRect);
        }

        private var _owner:com.animengine.frameworks.combat.hit.N_AtkHit;

        private var _key:int;

        private var _same:int;

        private var _source:flash.geom.Rectangle;

        private var _hitRect:flash.geom.Rectangle;

        private var _x:int;

        private var _y:int;

        private var _z:int;

        private var _flipH:Boolean;
    }
}
