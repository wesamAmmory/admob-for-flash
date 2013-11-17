package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import so.cuo.platform.ad.AdEvent;
	import so.cuo.platform.admob.Admob;

	public class EventDemo extends Sprite
	{
		var admob:Admob= Admob.getInstance();

		public function EventDemo()
		{
			super();
			if (admob.supportDevice)
			{
				admob.setInterstitialKeys("a152834c8723912");//Interstitial and banner use the same key
				admob.addEventListener(AdEvent.onBannerFailedReceive, onAdReceived);
				admob.addEventListener(AdEvent.onBannerReceive, onAdReceived);
			}
			stage.addEventListener(MouseEvent.CLICK, clickStage);
		}

		protected function clickStage(event:MouseEvent):void
		{
			admob.showBannerAbsolute(Admob.IAB_BANNER, 0, 10);
			if (admob.isInterstitialReady())
			{
				admob.showInterstitial();
			}
			else
			{
				admob.cacheInterstitial();
			}
		}

		protected function onAdReceived(event:AdEvent):void
		{
			trace(event.type, event.data);
		}
	}
}
