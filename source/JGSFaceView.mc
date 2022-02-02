import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class JGSFaceView extends WatchUi.WatchFace {
    private var inLowPowerMode;
    private var isVisible = false;

    function initialize() {
        WatchFace.initialize();
        inLowPowerMode = false;
        Widgets.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void { 
        Widgets.loadResources();
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {

        dc.setColor(Colors.BACKGROUND,Colors.BACKGROUND);
    	dc.clear();
        Widgets.update(dc, inLowPowerMode);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
        Widgets.freeResources();
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
        inLowPowerMode = false;
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
        inLowPowerMode = true;
    }

}
