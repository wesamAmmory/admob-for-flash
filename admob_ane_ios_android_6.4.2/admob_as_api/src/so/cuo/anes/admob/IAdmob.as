package so.cuo.anes.admob
{
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;

	public interface IAdmob
	{
//		 function getInstance():IAdmob;
		 function get isSupported() : Boolean;
		 function dispose() : void;
		 function createADView(size:AdSize,adid:String):void;
		 function setIsLandscape(b:Boolean):void;
		 function load(testing:Boolean=false):void;
		 function stopLoading():void;
		 function addToStage(x:int,y:int):void;
		 function removeFromStage():void;
		 function getAdSize():AdSize;
		 function getScreenSize():Rectangle;
		 function getMacAddress():String;
		 function destroyADView():void;
	}
}