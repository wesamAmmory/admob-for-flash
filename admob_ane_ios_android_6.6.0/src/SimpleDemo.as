package
{
	import flash.display.Sprite;
	
	import so.cuo.platform.ad.AdPosition;
	import so.cuo.platform.admob.Admob;
	
	public class SimpleDemo extends Sprite
	{
		public function SimpleDemo()
		{
			super();
			var admob:Admob= Admob.getInstance();
			if(admob.supportDevice){
				admob.setBannerKeys("a152834c2b8cce6");
				admob.showBanner(Admob.BANNER,AdPosition.BOTTOM_CENTER);
			}
		}
	}
}