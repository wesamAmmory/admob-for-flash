package
{
	import flash.display.Sprite;
	import so.cuo.platform.admob.Admob;
	import so.cuo.platform.ad.AdEvent;
	
	public class InterstitialDemo extends Sprite
	{
		var admob:Admob= Admob.getInstance();
		public function InterstitialDemo()
		{
			super();
			if(admob.supportDevice){
				admob.setInterstitialKeys("a152834c8723912");
				admob.addEventListener(AdEvent.onInterstitialReceive,onAdReceived);
				admob.cacheInterstitial();
			}
		}
		protected function onAdReceived(event:AdEvent):void
		{
			if(event.type==AdEvent.onInterstitialReceive){
				admob.showInterstitial();
			}
		}
	}
}