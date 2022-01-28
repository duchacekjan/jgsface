import Toybox.Activity;

class JGSFaceInfoWidget {    

    private const y = 0;
    private const x = 0;
    private const width = 240;
    private const height = 30;
    private const edge = 10;
    private var iconsFont = null;
    private var infoFont = null;
    private var neutralColor = Graphics.COLOR_LT_GRAY;
    private var notificationColor = Graphics.COLOR_GREEN;
    private var hrColor = Graphics.COLOR_RED;
    
    function initialize(){    
    }

    function loadResources(){
        iconsFont = Application.loadResource(Rez.Fonts.iconsFont);
        infoFont = Application.loadResource(Rez.Fonts.infoFont);
    }

    function freeResources(){
        iconsFont = null;
        infoFont = null;
    }

    function update(dc){
        var settings = System.getDeviceSettings();
        updateNotifications(dc, settings);
        var offset = updateDoNotDisturb(dc, settings);
        updateAlarmClock(dc, settings, offset);
        updateHR(dc);
    }

    private function updateDoNotDisturb(dc, settings){
        var offset = 0;
        if(settings.doNotDisturb){
            dc.setColor(neutralColor, Graphics.COLOR_TRANSPARENT);
            dc.drawText(0 + edge, height / 2, iconsFont, "C", Graphics.TEXT_JUSTIFY_LEFT|Graphics.TEXT_JUSTIFY_VCENTER);
            offset = 15;
        }
        return offset;
    }

    private function updateAlarmClock(dc, settings, offset){
        if(settings.alarmCount>0){
            dc.setColor(neutralColor, Graphics.COLOR_TRANSPARENT);
            dc.drawText(0 + edge + offset, height / 2, iconsFont, "D", Graphics.TEXT_JUSTIFY_LEFT|Graphics.TEXT_JUSTIFY_VCENTER);
        }
    }

    private function updateNotifications(dc, settings){
        var notificationCount = settings.notificationCount;
        if (notificationCount > 0) {
            dc.setColor(notificationColor, Graphics.COLOR_TRANSPARENT);
            dc.drawText(width - edge, height / 2, iconsFont, "A", Graphics.TEXT_JUSTIFY_RIGHT|Graphics.TEXT_JUSTIFY_VCENTER);
        }  
    }

    private function updateHR(dc){
        var heartRate = getHeartRate();
        if(heartRate!=null){
            var heartRateText = heartRate.format("%d");
            dc.setColor(hrColor, Graphics.COLOR_TRANSPARENT);
            dc.drawText( width/2, height / 2, iconsFont, "B", Graphics.TEXT_JUSTIFY_RIGHT|Graphics.TEXT_JUSTIFY_VCENTER); // Using Icon
            dc.drawText( width/2 + 2, height / 2 , infoFont, heartRateText, Graphics.TEXT_JUSTIFY_LEFT|Graphics.TEXT_JUSTIFY_VCENTER);
        }
    }

    private function getHeartRate(){
        var heartRate = null;
    	if(Activity has :getActivityInfo) {
    		heartRate = Activity.getActivityInfo().currentHeartRate; 
    		if(heartRate==null) {
    			if(ActivityMonitor has :getHeartRateHistory) {
	    			var HRH=ActivityMonitor.getHeartRateHistory(1, true);
					var HRS=HRH.next();
					if(HRS!=null && HRS.heartRate!= ActivityMonitor.INVALID_HR_SAMPLE){
						heartRate = HRS.heartRate;
					}
				}
    		}
		} 
        return heartRate;
    }
}