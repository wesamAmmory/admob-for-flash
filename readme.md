admob for flash 
------

admob_all_in_one.ane      contains admob for ios and for android in one file,very convenient <br/>
admob home: www.admob.com<br/>
project home:https://github.com/lilili87222/admob-for-flash/ <br />
download:https://github.com/lilili87222/admob-for-flash/archive/master.zip

admob ane for air mobile ad ,support Interstitial and Banner<br/>
support  landscape and portrait  and autoOrient<br/>
support ios and android<br/>
support all native event<br/>
base on admob ios sdk 6.12.0 and admob android sdk(Google Play services 4.5) 4.5<br/>
requred  air sdk 14.0 or later <br/>

very easy to use ,just three line code for simple usage<br/>
### show simple admob banner :
```
var admob:Admob=Admob.getInstance();
admob.setKeys("your admob banner id","your admob institial id");
admob.showBanner(Admob.BANNER,AdmobPosition.BOTTOM_CENTER);
```

###show admob  Interstitial ad (full screen ad)
```
var admob:Admob=Admob.getInstance();
admob.setKeys("your admob banner id","your admob institial id");////replace this fake ID with your really ID
if (admob.isInterstitialReady())// check ad has cached ,if true show it
{
     admob.showInterstitial();
}
else
{
    admob.cacheInterstitial();
}
```
### show admob banner with extra parameter 
```
var extraParam:ExtraParameter=new ExtraParameter();
extraParam.isChildApp=true;
extraParam.testDeviceID="your device";

var admob:Admob=Admob.getInstance();
admob.setKeys("your admob banner id","your admob institial id");
admob.showBannerAbsolute(Admob.BANNER,0,100,extraParam);
```
###for android.  you need add in application-app.xml
```
<android>
        <manifestAdditions><![CDATA[
			<manifest android:installLocation="auto">
			    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
			    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE"/>
			     <application>
 <meta-data android:name="com.google.android.gms.version"
        android:value="@integer/google_play_services_version" />
			  	   <activity android:name="com.google.android.gms.ads.AdActivity" android:configChanges="keyboard|keyboardHidden|orientation|screenLayout|uiMode|screenSize|smallestScreenSize"/>
			     </application>
			</manifest>
		]]></manifestAdditions>
    </android>
```

**more function**
- 1. handler  ad event  like this.
```
admob.addEventListener(AdmobEvent.onBannerReceive,onAdReceived);
```
- 2. get ad size info
```
protected function onAdReceived(event:AdmobEvent):void
{
    if(event.type==AdmobEvent.onBannerReceive){
	trace(event.data.width,event.data.height);
    }
}
```
- 3.get screen size info,old version function
```
admob.getScreenSize()

```

### 6.12.0 admob ane changes
1.update admob sdk for ios to 6.12.0 <br/>
2.add code tips document<br/>
3.add admob extra parameter that control test mode,age,location,is child app and so on. <br/>
4.refact demo code<br/>

### admob ane 6.11.1 changes
1.update admob sdk for ios to 6.11.1<br/>
2.fix Errors/warnings on publishing Air app with admob extension using Flash Professional

### 6.9.3 changes
1.update admob sdk ios to 6.9.3 ,update android google service sdk to the last version<br/>
2.trace the detail when load ad fail<br/>

###6.8.0 changes
1.update admob sdk ios 6.9.2 ,android google service sdk 4.3<br/>
2.add getScreenSize function for show banner absolute<br/>

###6.6.0 changes
1.support  landscape and portrait  and autoOrient<br/>
2.support relation position and Absolute position<br/>
3.support ios 5, ios 6, ios 7 ,and android<br/>
4.update admob sdk to last version<br/>
###6.4.1 changes
enable Interstitial admob ad 
###6.3.1 changes
1.include ios and android in one file<br/>
2.enable debug and pack on pc<br/>
3.base on admob6.3 no more use udid<br/>
4.enable get ad size info and screen size info<br/>

contact:wohaosea@gmail.com
