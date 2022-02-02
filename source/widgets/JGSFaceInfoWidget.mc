import Toybox.Activity;

class JGSFaceInfoWidget extends JGSFaceWidget {    

    private const y = 0;
    private const x = 0;
    private const width = 240;
    private const height = 30;
    private const edge = 10;
    
    function initialize(){    
        JGSFaceWidget.initialize();
    }

    function updateCore(dc){
        var settings = System.getDeviceSettings();
        updateNotifications(dc, settings);
        var offset = updateDoNotDisturb(dc, settings);
        updateAlarmClock(dc, settings, offset);
        updateHR(dc);
    }

    function updateInChargingMode(dc){       
        var settings = System.getDeviceSettings();
        var notificationCount = settings.notificationCount;
        
        var offset = 0;
         if(settings.doNotDisturb){
            dc.setColor(Colors.INFO_BASE, Colors.EMPTY);
            dc.drawText(width - edge, 50, Fonts.get(Fonts.Icons), Icons.DoNotDisturb, TextJustification.RC);
            offset = 20;
        }
        if (notificationCount > 0) {
            dc.setColor(Colors.INFO_NOTIFICATION, Colors.EMPTY);
            dc.drawText(width - edge, 50+offset, Fonts.get(Fonts.Icons), Icons.EnvelopeSolid, TextJustification.RC);
        }  
    }

    private function updateDoNotDisturb(dc, settings){
        var offset = 0;
        if(settings.doNotDisturb){
            dc.setColor(Colors.INFO_BASE, Colors.EMPTY);
            dc.drawText(0 + edge, height / 2, Fonts.get(Fonts.Icons), Icons.DoNotDisturb, TextJustification.LC);
            offset = 15;
        }
        return offset;
    }

    private function updateAlarmClock(dc, settings, offset){
        if(settings.alarmCount>0){
            dc.setColor(Colors.INFO_BASE, Colors.EMPTY);
            dc.drawText(0 + edge + offset, height / 2, Fonts.get(Fonts.Icons), Icons.AlarmClock, TextJustification.LC);
        }
    }

    private function updateNotifications(dc, settings){
        var notificationCount = settings.notificationCount;
        if (notificationCount > 0) {
            dc.setColor(Colors.INFO_NOTIFICATION, Colors.EMPTY);
            dc.drawText(width - edge, height / 2, Fonts.get(Fonts.Icons), Icons.EnvelopeSolid, TextJustification.RC);
        }  
    }

    private function updateHR(dc){
        var heartRate = getHeartRate();
        if(heartRate!=null){
            var heartRateText = heartRate.format("%d");
            dc.setColor(Colors.INFO_HR, Colors.EMPTY);
            dc.drawText( width/2, height / 2, Fonts.get(Fonts.Icons), Icons.HeartBeat, TextJustification.RC); 
            dc.drawText( width/2 + 2, height / 2 , Fonts.get(Fonts.ExtraSmall), heartRateText, TextJustification.LC);
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