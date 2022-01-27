import Toybox.Activity;

class JGSFaceInfoWidget {    

    private const y = 0;
    private const x = 0;
    private const width = 240;
    private const height = 30;
    private const edge = 10;
    private var iconsFont = null;
    private var infoFont = null;
    
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
        updateDoNotDisturb(dc, settings);
        updateAlarmClock(dc, settings);
        updateHR(dc);
    }

    private function updateDoNotDisturb(dc, settings){
        if(settings.doNotDisturb){
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
            dc.drawText(0 + edge, height / 2, iconsFont, "C", Graphics.TEXT_JUSTIFY_LEFT|Graphics.TEXT_JUSTIFY_VCENTER);
        }
    }

    private function updateAlarmClock(dc, settings){
        if(settings.alarmCount>0){
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
            dc.drawText(0 + edge + 25, height / 2, iconsFont, "D", Graphics.TEXT_JUSTIFY_LEFT|Graphics.TEXT_JUSTIFY_VCENTER);
        }
    }

    private function updateNotifications(dc, settings){
        var notificationCount = settings.notificationCount;
        if (notificationCount > 0) {
            dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
            dc.drawText(width - edge, height / 2, iconsFont, "A", Graphics.TEXT_JUSTIFY_RIGHT|Graphics.TEXT_JUSTIFY_VCENTER);
        }  
    }

    private function updateHR(dc){
        var heartRate = getHeartRate();
        if(heartRate!=null){
            var heartRateText = heartRate.format("%d");
            dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
            var offsetText = 25 + edge;
            var hrTextWidth = dc.getTextWidthInPixels(heartRateText, infoFont);
            dc.drawText( width - offsetText, height / 2 , infoFont, heartRateText, Graphics.TEXT_JUSTIFY_RIGHT|Graphics.TEXT_JUSTIFY_VCENTER);
            dc.drawText( width - offsetText - hrTextWidth - 2 , height / 2, iconsFont, "B", Graphics.TEXT_JUSTIFY_RIGHT|Graphics.TEXT_JUSTIFY_VCENTER); // Using Icon
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

//     // Get heart rate
// 	function drawHeartRate(dc, xIcon, hrIconY, xText, width, accentColor) {
    	

// 		// Render heart rate text
// 		var heartRateText = heartRate.format("%d");
// /*		if (heartRate == 0) {
// 			heartRateText="0";
// 		} else {
// 			heartRateText=heartRate.format("%d");
// 		}*/

// 		// Heart rate zones color definition (values for each zone are automatically calculated by Garmin)	
// 		var autoZones = UserProfile.getHeartRateZones(UserProfile.getCurrentSport());
// 		var heartRateZone = 0;
// 		if (heartRate >= autoZones[5]) { // 185
// 			heartRateZone = 7;
// 		} else if (heartRate >= autoZones[4]) { // 167
// 			heartRateZone = 6;
// 		} else if (heartRate >= autoZones[3]) { // 148
// 			heartRateZone = 5;
// 		} else if (heartRate >= autoZones[2]) { // 130
// 			heartRateZone = 4;
// 		} else if (heartRate >= autoZones[1]) { // 111
// 			heartRateZone = 3;
// 		} else if (heartRate >= autoZones[0]) { // 93
// 			heartRateZone = 2;
// 		} else {  
// 			heartRateZone = 1;
// 		}
		
// 		// Choose the colour of the heart rate icon based on heart rate zone
// 		var heartRateIconColour = Graphics.COLOR_DK_GRAY;
// 		if (heartRateZone == 0) { // Only when no default zones were detected
// 			if (heartRate >= 185) {
// 				heartRateZone = 7;
// 			} else if (heartRate >= 167) {
// 				heartRateZone = 6;
// 			} else if (heartRate >= 148) {
// 				heartRateZone = 5;
// 			} else if (heartRate >= 130) {
// 				heartRateZone = 4;
// 			} else if (heartRate >= 111) {
// 				heartRateZone = 3;
// 			} else if (heartRate >= 93) {
// 				heartRateZone = 2;
// 			} else { //(heartRate > 0) {
// 				heartRateZone = 1;
// 			}  
// 		}
		
// 		if (heartRateZone == 1) { // Resting / Light load
// 			if (width==360 or width==390 or width==416){ //AMOLED
// 				heartRateIconColour = Graphics.COLOR_LT_GRAY;
// 			} else { // MIP, for better readability
// 				heartRateIconColour = Graphics.COLOR_WHITE;
// 			}
// 		} else if (heartRateZone == 2) { // Moderate Effort
// 			heartRateIconColour = Graphics.COLOR_BLUE;
// 		} else if (heartRateZone == 3) { // Weight Control
// 			if (accentColor == 0xAAFF00) {
// 				heartRateIconColour = 0xAAFF00; /* Vivomove GREEN */
// 			} else {
// 				heartRateIconColour = 0x55FF00; /* GREEN */
// 			}
// 		} else if (heartRateZone == 4) { // Aerobic
// 			heartRateIconColour = 0xFFFF00; /* yellow */
// 		} else if (heartRateZone == 5) { // Anaerobic
// 			heartRateIconColour = 0xFFAA00; /* orange */
// 		} else if (heartRateZone == 6){ // Maximum effort
// 			heartRateIconColour = 0xFF5555; /* pastel red */
//  		} else if (heartRateZone == 7){ // Speed
// 			heartRateIconColour = 0xFF0000; /* bright red */
// 		}

// 		var offset=0;
// 		if (width >= 360) { // Venu, Venu 2 & 2s
// 			offset = 3;
// 			hrIconY = hrIconY + 1;
// 		}	else if(width==280){ // Fenix 6X & Enduro
// 			xText = xText-0.5;
// 			hrIconY = hrIconY - 4.5;
// 		}	else if(width==260){ // Fenix 6
// 			xText = xText-1.5;
// 			hrIconY = hrIconY - 4;
// 		}	else if(width==240){ // Fenix 6
// 			xText = xText-0.5;
// 			hrIconY = hrIconY - 5;
// 		}	else if(width==218){ // Fenix 6
// 			xText = xText-1.5;
// 			hrIconY = hrIconY - 2;			
// 		}
				
// 		// Render heart rate icon and text
// 		dc.setColor(heartRateIconColour, Graphics.COLOR_TRANSPARENT);
// 		dc.drawText( xIcon + offset/3 , hrIconY - 1, IconsFont, "3", Graphics.TEXT_JUSTIFY_CENTER); // Using Icon
// 		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
// 		dc.drawText( xText, hrIconY - offset , Graphics.FONT_XTINY, heartRateText, Graphics.TEXT_JUSTIFY_LEFT);		
// 	}
}