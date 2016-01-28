package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.text.TextField;
	import flash.text.TextFieldType;

	import so.cuo.platform.admob.Admob;
	import so.cuo.platform.admob.AdmobEvent;
	import so.cuo.platform.admob.AdmobSize;
	import so.cuo.platform.admob.ExtraParameter;

	public class demo extends Sprite
	{
		private var admob:Admob;
		public var fullID:String="ca-app-pub-xxxxxxxxxxxxxx/xxxxxxxxxxx";
		public var bannerID:String="ca-app-pub-xxxxxxxxxxxxxx/xxxxxxxxxxx";
//error admob id may cause ERROR_CODE_ERNAL_ERROR 
		public var extraParam:ExtraParameter;

		public var xPosition:TextField
		public var yPosition:TextField
		public var bannerType:TextField

		public function demo()
		{
			super();
			initUI();
			admob=Admob.getInstance();
			if (admob.supportDevice)
			{
				admob.setKeys(bannerID, fullID);
				admob.addEventListener(AdmobEvent.onInterstitialReceive, onAdEvent);
				admob.addEventListener(AdmobEvent.onBannerReceive, onAdEvent);
				admob.enableTrace=true;
				trace(admob.getScreenSize(), admob.getScreenSize().height);
			}
			
			extraParam=new ExtraParameter();
//			extraParam.setLocation(40, 40);
//			extraParam.birthday=new Date();
//			extraParam.contentUrl="http://www.google.com";
//			extraParam.keyWord="air admob ane";
//			extraParam.isChildApp=true;
//			extraParam.testDeviceID="C10FA0762720A0FD0E64FE3824A8B64F";//set device id for ios to show test
//			extraParam.testDeviceID="true";//set true for android to show test
		}

		private function initUI():void
		{
			stage.align=StageAlign.TOP_LEFT;
			stage.scaleMode=StageScaleMode.NO_SCALE;
			var ui:UI=new UI(onClick);
			addChild(ui);
			ui.addButton("relation", 20, 20);
			ui.addButton("absolute", 200, 20);
			ui.addButton("hide", 20, 120);
			ui.addButton("interstitial", 200, 120);

			xPosition=ui.addButton("x", 20, 220);
			yPosition=ui.addButton("y", 200, 220);
			bannerType=ui.addButton("bannerType", 20, 320);
			xPosition.type=yPosition.type=bannerType.type=TextFieldType.INPUT;
			xPosition.border=yPosition.border=bannerType.border=true;
		}

		private function onAdEvent(event:AdmobEvent):void
		{
//			if(event.data!=null)
//			trace("adsize",event.data.width,event.data.height);
//			trace(event.type);
			if (event.type == AdmobEvent.onBannerReceive)
			{
				trace(event.data.width, event.data.height);
			}
			if (event.type == AdmobEvent.onInterstitialReceive)
			{
				admob.showInterstitial();
			}
		}

		private function onClick(label:String):void
		{

			trace("click flash stage-------1", stage.stageWidth, stage.stageHeight, stage.orientation);
			if (!admob.supportDevice)
			{
				trace("not support device");
				return
			}
			else
			{
				var xPositionValue:int=parseInt(xPosition.text);
				var yPositionValue:int=parseInt(yPosition.text);
				var bannerTypeValue:int=parseInt(bannerType.text);
				var adsize:AdmobSize;
				if (bannerTypeValue == 1)
				{
					adsize=Admob.BANNER;
				}
				if (bannerTypeValue == 2)
				{
					adsize=Admob.IAB_BANNER;
				}
				if (bannerTypeValue == 3)
				{
					adsize=Admob.SMART_BANNER;
				}
				if (bannerTypeValue == 4)
				{
					adsize=Admob.IAB_MRECT;
				}
				if (bannerTypeValue == 5)
				{
					adsize=Admob.IAB_WIDE_SKYSCRAPER;
				}
				if (bannerTypeValue == 6)
				{
					adsize=Admob.IAB_LEADERBOARD;
				}
				if (adsize == null)
				{
					adsize=Admob.BANNER_STANDARD;
				}
				if (label == "hide")
				{
					admob.hideBanner();
				}
				if (label == "absolute")
				{
					admob.showBannerAbsolute(adsize, xPositionValue, yPositionValue, extraParam);
				}
				else if (label == "relation")
				{
					if (xPositionValue > 9)
						xPositionValue=9;
					if (xPositionValue < 1)
						xPositionValue=1;
					admob.showBanner(adsize, xPositionValue, extraParam);
				}
				else if (label == "interstitial")
				{
					if (admob.isInterstitialReady())
					{
						admob.showInterstitial();
					}
					else
					{
						admob.cacheInterstitial(extraParam);
					}
				}
			}
		}
	}
}
