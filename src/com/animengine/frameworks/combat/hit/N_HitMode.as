package com.animengine.frameworks.combat.hit
{
    public class N_HitMode extends Object
    {
        public function N_HitMode()
        {
            super();
            return;
        }

        public static function getType(arg1:String):int
        {
            return _list.indexOf(arg1);
        }

        private static const _list:Array=["单次碰撞", "多次碰撞"];

        public static const NONE:int=-1;

        public static const ONCE:int=0;

        public static const MORE:int=1;
    }
}
