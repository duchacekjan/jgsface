import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class JGSFaceView extends WatchUi.WatchFace {
    var width, height;
    var contouredFont = null;
    var contouredBFont = null;
    var weatherFont =null;
    var temperatureFont =null;
    private const BATTERY_R = 20;
    private const STEPS_R = 30;
    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        contouredFont = WatchUi.loadResource(Rez.Fonts.contouredFont);
        contouredBFont = WatchUi.loadResource(Rez.Fonts.contouredBFont);
        temperatureFont = WatchUi.loadResource(Rez.Fonts.temperatureFont);
        weatherFont = WatchUi.loadResource(Rez.Fonts.weatherFont);
        width=dc.getWidth();
		height=dc.getHeight();
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void { 
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {

        dc.setColor(Graphics.COLOR_BLACK,Graphics.COLOR_BLACK);
    	dc.clear();

        var clockTime = System.getClockTime();
        var hourString = Lang.format("$1$", [clockTime.hour.format("%02d")]);
        var minString = Lang.format("$1$", [clockTime.min.format("%02d")]);
        updateContouredText(dc, hourString, 0xf8f800, Graphics.COLOR_BLACK, height/4);
        updateContouredText(dc, minString, Graphics.COLOR_WHITE, Graphics.COLOR_LT_GRAY, 3*height/4);
        updateBatteryLevel(dc);
        updateWeather(dc);
        updateNotifications(dc);
        var common = new JGSFaceCommon();
        common.drawDateString(dc, width / 6, height/2);
    }

    function updateNotifications(dc as Dc){
        var notificationCount = System.getDeviceSettings().notificationCount;
        if (notificationCount > 0) {
            dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
            var icons =  Application.loadResource(Rez.Fonts.iconsFont);
            dc.drawText(5, 15, icons, "B", Graphics.TEXT_JUSTIFY_LEFT|Graphics.TEXT_JUSTIFY_VCENTER);
        }
        
    }

    function updateWeather(dc as Dc){
        var x = width/6;
        var y = x+20;
        var common = new JGSFaceCommon();
        common.drawWeatherIcon(dc, x, y, 0xf8f800);
    }

    function updateContouredText(dc as Dc, text as String, borderColor as Color, color as Color, y as Int) as Void{
        updateTimeLabel(dc, text, borderColor, y, contouredBFont);
        updateTimeLabel(dc, text, color, y, contouredFont);
    }

    function updateTimeLabel(dc as Dc, text as String, color as Color, y as Int, font as Font) as Void{
        var justify = Graphics.TEXT_JUSTIFY_RIGHT|Graphics.TEXT_JUSTIFY_VCENTER;

        dc.setColor(color, Graphics.COLOR_TRANSPARENT);
        dc.drawText(width-2,y,font,text,justify);
    }

    function updateBatteryLevel(dc as Dc) as Void{
        var progress = new JGSFaceCircleProgress(BATTERY_R);
        var x = width/6;
        var y = height-x;
        var progress2 = new JGSFaceCircleProgress(STEPS_R);
        var activityInfo = Toybox.ActivityMonitor.getInfo();
        var stepPercent = 100.0*activityInfo.steps.toFloat()/activityInfo.stepGoal.toFloat();
        progress2.drawCircleProgress(dc, x, y, stepPercent);
        progress.font = temperatureFont;
        progress.isProgressTextVisible = true;
        progress.progressColor = new JGSFaceBatteryColorLevels();
        progress.drawCircleProgress(dc, x, y, System.getSystemStats().battery);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
        contouredFont = null;
        contouredBFont = null;
        weatherFont =null;
        temperatureFont =null;
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

}
