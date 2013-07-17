package  so.cuo.anes.admob
{
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;

	/**
	 * main function class. you can have one instance only.
	 * so call Admob.getInstance() 
	 * 
	 * 		var admob:Admob=Admob.getInstance();
			if (admob.isSupported)
			{
				admob.createADView(AdSize.BANNER, "your admob id"); //create a banner ad view.this init the view 
				admob.addToStage(0, 0); // ad to displaylist position 0,0
				admob.load(false); // send a ad request.  
			}
	 * @author Administrator
	 */
	public class Admob implements IAdmob
	{
		private static var _inst:Admob;
		private var extensionContext:ExtensionContext=null;
		private var adSize:AdSize=new AdSize();
		private var mac:String=null;
		private var screen:Rectangle=null;
		public const dispatcher:EventDispatcher=new EventDispatcher();

		public function Admob():void{
			if (this.extensionContext == null)
			{
				extensionContext=ExtensionContext.createExtensionContext("so.cuo.ane.Admob", null);
				if (extensionContext != null)
				{
					extensionContext.addEventListener(StatusEvent.STATUS, onAdHandler);
				}
			}
		}
		/**
		 * if admob is not create ,getInstance will return a new instance
		 * @return 
		 */
		public static function getInstance():Admob
		{
			if (_inst == null)
			{
				_inst=new Admob();
			}
			return _inst;
		}

		private function onAdHandler(e:StatusEvent):void
		{
			trace("ane event type:" + e.type, "code:" + e.code, "level:" + e.level);
			if(e.code.indexOf("Full")>0){
				dispatcher.dispatchEvent(new FullAdEvent(e.code));
			}else{
				dispatcher.dispatchEvent(new AdEvent(e.code));
			}
		}

		/**
		 * test if admob is available on this platform
		 * @return 
		 */
		public function get isSupported():Boolean
		{
			var ok:Boolean=Capabilities.manufacturer.indexOf('iOS') > -1 || Capabilities.manufacturer.indexOf('Android') > -1;
			return extensionContext != null&&ok;
		}

		/**
		 * not need admob ane any more,dispose it.
		 * after dispose other function will no long available,
		 * unless call getInstance again
		 */
		public function dispose():void
		{
			if (extensionContext != null)
			{
				extensionContext.removeEventListener(StatusEvent.STATUS, onAdHandler);
				extensionContext.dispose();
				extensionContext=null;
			}
		}

		/**
		 * create a adview with a adsize and admob ad id
		 * The ad sizes can be any size admob defined
		 * AdSize provide some common size
		 * @param size  ref AdSize
		 * @param adid  ref http://www.google.com/ads/admob/
		 */
		public function createADView(size:AdSize, adid:String):void
		{
			this.adSize.width=size.width;
			this.adSize.height=size.height;
			if (this.isSupported)
				extensionContext.call("createView", size.width, size.height, adid);
		}

		/**
		 * set is landscape mode. if b==true ad will show landscape
		 * this will not fun on android
		 * @param b
		 */
		public function setIsLandscape(b:Boolean):void
		{
			if (this.isSupported)
				extensionContext.call("setIsLandscape", b);
		}

		/**
		 * send a ad request ,if isTesting==true,this request will be test mode
		 * @param isTesting
		 */
		public function load(isTesting:Boolean=false):void
		{
			if (this.isSupported)
				extensionContext.call("loadAD", isTesting);
		}

		/**
		 * stop current loading request.
		 * ios will do nothing,it just do on android
		 */
		public function stopLoading():void
		{
			if (this.isSupported)
				extensionContext.call("stopLoading");
		}

		/**
		 * add ad view to display list,position to x,y
		 * or reset ad position
		 * @param x
		 * @param y
		 */
		public function addToStage(x:int, y:int):void
		{
			if (this.isSupported)
				extensionContext.call("addToStage", x, y);
		}

		/**
		 * remove from display list.you can call addToStage show it later
		 */
		public function removeFromStage():void
		{
			if (this.isSupported)
				extensionContext.call("removeFromStage");
		}

		/**
		 * destroy ad view. ad will been removed,
		 * ad will not show any long unless you call createAdView 
		 */
		public function destroyADView():void
		{
			if (this.isSupported)
				extensionContext.call("destroyADView");
		}

		/**
		 * get ad size current showing,only available after ad receive event.
		 * @return 
		 */
		public function getAdSize():AdSize
		{
			if (this.isSupported)
			{
				var sizeString:String=extensionContext.call("getAdSize") as String;
				var v:Array=sizeString.split("_");
				var w:int=parseInt(v[0]);
				var h:int=parseInt(v[1]);
				if(w!=0&&h!=0){
					this.adSize.width=w;
					this.adSize.height=h;
				}
			}
			return adSize;
		}

		/**
		 * get device screen size 
		 * @return 
		 */
		public function getScreenSize():Rectangle
		{
			if (this.isSupported)
			{
				if (this.screen == null)
				{
					var sizeString:String=extensionContext.call("getScreenSize") as String;
					var v:Array=sizeString.split("_");
					screen=new Rectangle(0, 0, parseInt(v[0]), parseInt(v[1]));
				}
				return new Rectangle(0, 0, screen.width, screen.height);
			}
			else
			{
				return new Rectangle(0, 0);
			}
		}

		/**
		 * ios return mac address
		 * android return device id
		 * @return 
		 */
		public function getMacAddress():String
		{
			if (this.isSupported)
			{
				if (this.mac == null)
				{
					this.mac=extensionContext.call("getMacAddress") as String;
				}
				return this.mac;
			}
			return "";
		}
		/**
		 * create Interstitial ad instance
		 */
		public function createFullScreenAd(adid:String):void{
			if (this.isSupported)
				extensionContext.call("createFullAd", adid);
		}
		/**
		 * cache Interstitial with test mode or running mode
		 */
		public function cacheFullScreenAd(isTesting:Boolean=false):void{
			if (this.isSupported)
				extensionContext.call("cacheFullAd",isTesting);
		}
		/**
		 * add Interstitial to stage,and display,call this after isFullScreenAdReady==true
		 */
		public function showFullScreenAd():void{
			if (this.isSupported)
				extensionContext.call("showFullAd");
		}
		/**
		 * test if full screen ad is ready for show
		 */
		public function isFullScreenAdReady():Boolean{
			if (this.isSupported)
				return extensionContext.call("isReadyFullAd");
			return false;
		}
	}
}
