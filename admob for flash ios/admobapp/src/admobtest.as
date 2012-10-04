package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.TouchEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import so.cuo.anes.admob.AdType;
	import so.cuo.anes.admob.Admob;
	import so.cuo.anes.admob.NativeAdsEvent;
	
	[SWF(width="960", height="640", frameRate="60", backgroundColor="#cccccc")]
	public class admobtest extends Sprite
	{
		private var gid:String="a14fde93a405e01";
		private var type:TextField=new TextField();
		private var land:TextField=new TextField();
		public function admobtest()
		{
			super();
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			this.addLabels();
			
			var ad:Admob=Admob.getInstance();
			if(ad.isSupported){
				trace(ad.getUUID());
				ad.setUnitId(gid);
				////https://developers.google.com/mobile-ads-sdk/docs/admob/intermediate
				//https://developers.google.com/mobile-ads-sdk/docs/admob/smart-banners
				ad.setAdType(AdType.kGADAdSizeMediumRectangle);
				ad.isTesting=true;
				ad.setPosition(10,20);
				ad.dispatcher.addEventListener(NativeAdsEvent.AD_CLICKED,clickAdHandler);
				this.addEventListener(Event.ACTIVATE,adtiveLandscape);//if not landscape ad replace  adtiveLandscape with adtivePorttrat
			}else{
				trace("not support");
			}
		}
		
		protected function clickAdHandler(event:Event):void
		{
			trace("click ad");
			Admob.getInstance().removeFromDisplayList();
		}
		protected function adtiveLandscape(event:Event):void
		{
			Admob.getInstance().addToDisplayList();
			Admob.getInstance().refresh();
		}
		private function addLabels():void{
			var f:TextFormat=new TextFormat(null,36);
			type.defaultTextFormat=f;
			land.defaultTextFormat=f;
			type.text="adtype";
			land.text="Landscape";
			land.y=400;
			type.y=320;
			land.x=640;
			type.x=640;
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			land.addEventListener(TouchEvent.TOUCH_END,clickLand);
			type.addEventListener(TouchEvent.TOUCH_END,clickType);
			this.addChild(type);
			this.addChild(land);
		}
		
		
		private var cur:int=0;
		protected function clickType(event:TouchEvent):void
		{
			cur=cur%8;
			cur+=1;
			trace(cur);
			type.text="type:"+cur;
			Admob.getInstance().setAdType(cur);
			Admob.getInstance().refresh();
		}
		

		private var landtype:Boolean=false;
		protected function clickLand(event:TouchEvent):void
		{
			landtype=!landtype;
			Admob.getInstance().setIsLandscape(landtype);
			Admob.getInstance().refresh();
		}
		
	}
}