package
{
	import flash.display.Sprite;
	
	import so.cuo.platform.admob.Admob;
	import so.cuo.platform.admob.AdmobEvent;
	
	public class InterstitialDemo extends Sprite
	{
		var admob:Admob= Admob.getInstance();
		public function InterstitialDemo()
		{
			super();
			if(admob.supportDevice){
				admob.setKeys("your banner id","your institial id");
				admob.addEventListener(AdmobEvent.onInterstitialReceive,onAdReceived);
				admob.cacheInterstitial();
			}
		}
		protected function onAdReceived(event:AdmobEvent):void
		{
			if(event.type==AdmobEvent.onInterstitialReceive){
				admob.showInterstitial();
			}
		}
	}
}