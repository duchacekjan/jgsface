import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class JGSFaceView extends WatchUi.WatchFace {
    enum {
        W_Weather = 0,
        W_Time = 1,
        W_Date = 2,
        W_Progress = 3,
        W_Info = 4
    }

    private var inSleepMode;
    private var isVisible = false;
    private var widgets;

    function initialize() {
        WatchFace.initialize();
        inSleepMode = false;
        widgets = new [5];
        widgets[W_Weather] = new JGSFaceWeatherWidget();
        widgets[W_Time] = new JGSFaceTimeWidget();
        widgets[W_Date] = new JGSFaceDateWidget();
        widgets[W_Progress] = new JGSFaceProgressWidget();
        widgets[W_Info] = new JGSFaceInfoWidget();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void { 
        for(var i = 0; i < widgets.size();i += 1){
            var widget = widgets[i] as JGSFaceWidget;
            widget.loadResources();
        }
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {

        dc.setColor(Graphics.COLOR_BLACK,Graphics.COLOR_BLACK);
    	dc.clear();

        for(var i = 0; i < widgets.size(); i += 1){
            var widget = widgets[i] as JGSFaceWidget;
            widget.update(dc, inSleepMode);
        }
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
        for(var i = 0; i < widgets.size(); i += 1){
            var widget = widgets[i] as JGSFaceWidget;
            widget.freeResources();
        }
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
        inSleepMode = false;
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
        inSleepMode = true;
    }

}
