package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import so.cuo.anes.admob.AdType;
	import so.cuo.anes.admob.Admob;
	import so.cuo.anes.admob.NativeAdsEvent;

	[SWF(width="640", height="960", frameRate="60", backgroundColor="#cccccc")]
	public class AdmobTestSimple extends Sprite
	{
		private var gid:String="a14fde93a405e01";
		public function AdmobTestSimple()
		{
			super();
			var ad:Admob=Admob.getInstance();
			if(ad.isSupported){
				ad.setUnitId(gid);
				ad.isTesting=true;
				showBarAd();
				showFullAd();
			}else{
				trace("not support");
			}
		}
		
		private function showFullAd():void
		{
			var ad:Admob=Admob.getInstance();
			ad.dispatcher.addEventListener(NativeAdsEvent.full_interstitialDidReceiveAd,adEventHandler);
			ad.loadFull();
		}
		
		protected function adEventHandler(event:Event):void
		{
			Admob.getInstance().addFullToDisplayList();
		}
		
		private function showBarAd():void
		{
			var ad:Admob=Admob.getInstance();
			//https://developers.google.com/mobile-ads-sdk/docs/admob/intermediate
			//https://developers.google.com/mobile-ads-sdk/docs/admob/smart-banners
			ad.setAdType(AdType.kGADAdSizeBanner);
			ad.setPosition(0,100);
			ad.setIsLandscape(true);
			ad.addToDisplayList();
			ad.refresh();
		}
	}
}