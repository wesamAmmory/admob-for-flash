package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import so.cuo.anes.admob.*;

/**
 * demo for admob interstitials ad(admob full screen ad)
 **/
	[SWF(width="960", height="640", frameRate="35", backgroundColor="#cccccc")]
	public class InterstitialTest extends Sprite
	{
		private var admob:Admob=Admob.getInstance();
		public function InterstitialTest()
		{
			super();
			stage.align=StageAlign.TOP_LEFT;
			stage.scaleMode=StageScaleMode.NO_SCALE;
			var title:TextField=new TextField();
			title.width=300;
			title.selectable=false;
			title.defaultTextFormat=new TextFormat(null,48);
			title.text="admob Interstitial demo";
			title.addEventListener(MouseEvent.CLICK,onClick);
			this.addChild(title);
			
			admob.dispatcher.addEventListener(FullAdEvent.onReceiveAd,onAddReceive);
			// create and cache a admob full screen ad(interstitials ad)
			admob.createFullScreenAd("your id");
		}
		
		protected function onAddReceive(event:Event):void
		{
			trace(admob.isFullScreenAdReady());
			admob.showFullScreenAd();
		}
		
		protected function onClick(event:MouseEvent):void
		{
			if(admob.isFullScreenAdReady()){// check ad has cached ,if true show it
				admob.showFullScreenAd();
			}else{
				// cache ad ,load interstitials ad need time,so you would best cache it early
				//if is testing pass true,else pass false
				admob.cacheFullScreenAd(false);
			}
		}
	}
}
