package com.animengine.net.loader
{
	/**
	 * @author Halley
	 */
	public class FunctionVO
	{
		public var fun:Function;
		public var args:*;

		public function FunctionVO( fun:Function, args:* )
		{
			this.fun = fun;
			this.args = args;
		}
	}
}
