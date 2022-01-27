import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class JGSFaceView extends WatchUi.WatchFace {
    private var weatherWidget = null;
    private var timeWidget = null;
    private var dateWidget = null;
    private var progressWidget = null;
    private var infoWidget = null;

    function initialize() {
        WatchFace.initialize();
        weatherWidget = new JGSFaceWeatherWidget();
        timeWidget = new JGSFaceTimeWidget();
        dateWidget = new JGSFaceDateWidget();
        progressWidget = new JGSFaceProgressWidget();
        infoWidget =new JGSFaceInfoWidget();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        weatherWidget.loadResources();
        timeWidget.loadResources();
        dateWidget.loadResources();
        progressWidget.loadResources();
        infoWidget.loadResources();
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

        timeWidget.update(dc);
        dateWidget.update(dc);
        weatherWidget.update(dc);
        progressWidget.update(dc);
        infoWidget.update(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
        weatherWidget.freeResources();
        timeWidget.freeResources();
        dateWidget.freeResources();
        progressWidget.freeResources();
        infoWidget.freeResources();
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

}
