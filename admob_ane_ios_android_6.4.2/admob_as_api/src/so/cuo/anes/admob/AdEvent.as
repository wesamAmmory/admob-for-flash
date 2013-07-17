package  so.cuo.anes.admob
{
	import flash.events.Event;
	/**
	 * ad event 
	 * ref  https://developers.google.com/mobile-ads-sdk/docs/admob/intermediate
	 **/
	public class AdEvent extends Event
	{
		/**
		 * Event which will be fired when  ad is clicked  and not leave app. will show a full screen in app ad
		 */
		public static const onDismissScreen:String = "onDismissScreen";
		/**
		 *Event which will be fired when fail to receive ad
		 **/
		public static const onFailedToReceiveAd:String = "onFailedToReceiveAd";
		/**
		 * Event which will be fired when ad clicked and will leave app.
		 */
		public static const onLeaveApplication:String = "onLeaveApplication";
		/**
		 * Event which will be fired when ad will been add to screen.
		 */
		public static const onPresentScreen:String = "onPresentScreen";
		/**
		 * Event which will be fired when ad received success 
		 */
		public static const onReceiveAd:String = "onReceiveAd";
		public function AdEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
