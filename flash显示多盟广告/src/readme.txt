flash 加载显示 多盟广告
国内广告商  多盟 的flash air ane扩展，用于在flash移动应用中显示admob广告
库力求功能全面和接口简单，真机上运行良好，不支持模拟器运行和pc运行。
基于domob v3编译，使用需要air sdk3.1或以上，
建议使用fb4.7打包，flex builder 4.7可以在pc上直接打包，无需额外设置，
如果是fb4.6或以下版本的fb需要设置iossdk 路径，并且只能在mac上打包。
能完美的显示横向广告和竖向广告，并且可以随意设置广告的位置，支持多样的广告类型和广告事件。
下面一句一句说明
package
{
	import flash.display.Sprite;
	import flash.events.TouchEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import so.cuo.anes.domob.AdType;
	import so.cuo.anes.domob.Domob;

	[SWF(width="640", height="960", frameRate="60", backgroundColor="#cccccc")]
	public class AdmobTestSimple extends Sprite
	{
		public function AdmobTestSimple()
		{
			super();
			var ad:Domob=Domob.getInstance();
			if(ad.isSupported){
				ad.initWithIDAndSize("56OJyM1ouMGoULfJaL",AdType.DOMOB_AD_SIZE_320x50.width,AdType.DOMOB_AD_SIZE_320x50.height);
				ad.setPosition(0,100);
				ad.setIsLandscape(true);
				ad.addToDisplayList();
				ad.refresh();
			}else{
				trace("not support");
			}
		}
	}
}
只要做到上面的已经可以正常工作了，可以调整position和size的类型选择广告尺寸，不过注意其官方公布的广告尺寸类型
更多的功能可以参考api文档和例子

下面还有些附加的功能
1.Domob.dispatcher可以添加监听器，来处理广告的各种状态
其中事件类型包括AD_RECEIVED，AD_FailToLoadAd，AD_WillPresentModalViewFromAd，AD_DidDismissModalViewFromAd，AD_ApplicationWillEnterBackgroundFromAd
包括用户点击了广告，由于点击要离开程序，广告加载成功和失败
具体的事件描述可以参考http://www.domob.cn/help/index.htm#tab2
2.通过adobe 本机扩展  ane for admob iphone 可以获取设备号（mac地址）
调用getUUID能获得设备的唯一id，由于苹果已经不再建议使用uuid，这个接口返回的是机器的mac地址和uuid的合并字符串。
Domob.getInstance().getUUID()