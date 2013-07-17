package  so.cuo.anes.admob
{

	/**
	 * ad size
	 * ad size must been admob defined size.
	 * ref  https://developers.google.com/mobile-ads-sdk/docs/admob/intermediate
	 **/
	public class AdSize
	{
		/**320*50**/
		public static const BANNER:AdSize=new AdSize(320, 50);
		/**300*250**/
		public static const IAB_MRECT:AdSize=new AdSize(300, 250);
		/**468*60**/
		public static const IAB_BANNER:AdSize=new AdSize(468, 60);
		/**728*90**/
		public static const IAB_LEADERBOARD:AdSize=new AdSize(728, 90);
		/**Smart Banners are new ad units (as of v6.0.0) 
		 * that will render screen-wide banner ads 
		 * on any screen size across different devices in either orientation.
		 *  Smart Banners help deal with increasing screen fragmentation 
		 * across different devices by "smartly" detecting the width of the phone 
		 * in its current orientation, and making the ad view that size. **/
		public static const SMART_BANNER:AdSize=new AdSize(-1, -2);
		/**160*600**/
		public static const IAB_WIDE_SKYSCRAPER:AdSize=new AdSize(160, 600);

		public function AdSize(w:Number=320, h:Number=50)
		{
			this.width=w;
			this.height=h;
		}
		public var width:int;
		public var height:int;
	}
}
