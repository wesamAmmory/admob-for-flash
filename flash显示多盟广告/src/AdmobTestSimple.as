package
{
	import flash.display.Sprite;
	import flash.events.TouchEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import so.cuo.anes.domob.AdType;
	import so.cuo.anes.domob.Domob;

	[SWF(width="640", height="960", frameRate="60", backgroundColor="#cccccc")]
	public class AdmobTestSimple extends Sprite
	{
		public function AdmobTestSimple()
		{
			super();
			var ad:Domob=Domob.getInstance();
			this.addLabels();
			if(ad.isSupported){
				ad.initWithIDAndSize("56OJyM1ouMGoULfJaL",AdType.DOMOB_AD_SIZE_300x250.width,AdType.DOMOB_AD_SIZE_300x250.height);
				ad.setPosition(0,100);
				ad.setIsLandscape(true);
				ad.addToDisplayList();
				ad.refresh();
			}else{
				trace("not support");
			}
		}
		private	 var type:TextField=new TextField();
	    private		 var land:TextField=new TextField();
		private function addLabels():void{
			var f:TextFormat=new TextFormat(null,36);
			type.defaultTextFormat=f;
			land.defaultTextFormat=f;
			type.text="show";
			land.text="hide";
			land.y=100;
			type.y=50;
			land.x=240;
			type.x=240;
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			land.addEventListener(TouchEvent.TOUCH_END,clickType);
			type.addEventListener(TouchEvent.TOUCH_END,clickType);
			this.addChild(type);
			this.addChild(land);
		}
		protected function clickType(event:TouchEvent):void
		{
			trace(event.currentTarget);
			if(event.currentTarget==type){
				Domob.getInstance().addToDisplayList();
			}
			if(event.currentTarget==land){
				Domob.getInstance().removeFromDisplayList();
			}
		}
	}
}