package  so.cuo.anes.admob
{
	import flash.events.Event;
	/**
	 * Interstitial ad event 
	 * ref  https://developers.google.com/mobile-ads-sdk/docs/admob/advanced
	 **/
	public class FullAdEvent extends Event
	{
		/**
		 * Event which will be fired when  ad is clicked  and not leave app. will show a full screen in app ad
		 */
		public static const onDismissScreen:String = "onFullDismissScreen";
		/**
		 *Event which will be fired when fail to receive ad
		 **/
		public static const onFailedToReceiveAd:String = "onFullFailedToReceiveAd";
		/**
		 * Event which will be fired when ad clicked and will leave app.
		 */
		public static const onLeaveApplication:String = "onFullLeaveApplication";
		/**
		 * Event which will be fired when ad will been add to screen.
		 */
		public static const onPresentScreen:String = "onFullPresentScreen";
		/**
		 * Event which will be fired when ad received success 
		 */
		public static const onReceiveAd:String = "onFullReceiveAd";
		public function FullAdEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
