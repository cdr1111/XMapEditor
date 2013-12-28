package com.animengine.frameworks.combat.hit
{
    public class N_HitType extends Object
    {
        public function N_HitType()
        {
            super();
            return;
        }

        public static function getType(arg1:String):int
        {
            return _list.indexOf(arg1);
        }

        private static const _list:Array=["物理攻击", "魔法攻击"];

        public static const NONE:int=-1;

        public static const PHYSIC:int=0;

        public static const MAGIC:int=1;
    }
}
