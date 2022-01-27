import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class JGSFaceView extends WatchUi.WatchFace {
    var width, height;
    var weatherFont =null;
    var temperatureFont =null;
    private const BATTERY_R = 20;
    private const STEPS_R = 30;

    private var weatherWidget = null;
    private var timeWidget = null;
    private var dateWidget = null;

    function initialize() {
        WatchFace.initialize();
        weatherWidget = new JGSFaceWeatherWidget();
        timeWidget = new JGSFaceTimeWidget();
        dateWidget = new JGSFaceDateWidget();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        temperatureFont = WatchUi.loadResource(Rez.Fonts.temperatureFont);
        weatherFont = WatchUi.loadResource(Rez.Fonts.weatherFont);
        width=dc.getWidth();
		height=dc.getHeight();
        weatherWidget.loadResources();
        timeWidget.loadResources();
        dateWidget.loadResources();
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

        updateBatteryLevel(dc);
        updateNotifications(dc);
        // var common = new JGSFaceCommon();
        // common.drawDateString(dc, width / 6, height/2);
        weatherWidget.update(dc);
        timeWidget.update(dc);
        dateWidget.update(dc);
    }

    function updateNotifications(dc as Dc){
        var notificationCount = System.getDeviceSettings().notificationCount;
        if (notificationCount > 0) {
            dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
            var icons =  Application.loadResource(Rez.Fonts.iconsFont);
            dc.drawText(5, 15, icons, "B", Graphics.TEXT_JUSTIFY_LEFT|Graphics.TEXT_JUSTIFY_VCENTER);
        }        
    }

    function updateBatteryLevel(dc as Dc) as Void{
        var progress = new JGSFaceCircleProgress(BATTERY_R);
        var x = width/6;
        var y = height-x;
        var progress2 = new JGSFaceCircleProgress(STEPS_R);
        progress2.progressColor = new JGSFaceColorLevels(Graphics.COLOR_BLUE);
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
        weatherFont =null;
        temperatureFont =null;
        weatherWidget.freeResources();
        timeWidget.freeResources();
        dateWidget.freeResources();
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

}
