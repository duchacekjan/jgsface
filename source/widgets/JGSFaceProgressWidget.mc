class JGSFaceProgressWidget extends JGSFaceWidget{
    private const startX = 0;
    private const startY = 240;
    private const RADIUS_S = 22;
    private const RADIUS_L = 30;
    private const PROGRESS_STROKE = 4;
    private var x;
    private var y;
    
    function initialize(){    
        JGSFaceWidget.initialize();
        x = startX + 35 + 5;
        y = startY - RADIUS_L - 10;
    }

    function updateCore(dc){
        drawLeads(dc);
        var activityInfo = Toybox.ActivityMonitor.getInfo();
         
        updateSteps(dc, activityInfo);
        updateBatteryStatus(dc);
    }

    private function drawLeads(dc){
        dc.setColor(Colors.LEAD, Colors.EMPTY);
        dc.setPenWidth(1);
        dc.drawCircle(x, y, RADIUS_S);
        dc.drawCircle(x, y, RADIUS_L);
    }

    private function updateSteps(dc, activityInfo){
        var stepsProgress = 0;
        if(activityInfo!=null){
            stepsProgress = getStepsProgress(activityInfo);
        }

        if(stepsProgress<=100){
            drawProgress(dc, RADIUS_L, stepsProgress, Colors.STEPS_UP_TO_100, PROGRESS_STROKE);
        }else if (stepsProgress<=200){
            drawProgress(dc, RADIUS_L, 100, Colors.STEPS_UP_TO_200, PROGRESS_STROKE);
            drawProgress(dc, RADIUS_L, stepsProgress-100, Colors.STEPS_UP_TO_100, PROGRESS_STROKE);
        }else {
            drawProgress(dc, RADIUS_L, 100, Colors.STEPS_OVER_200, PROGRESS_STROKE);
            drawProgress(dc, RADIUS_L, stepsProgress-200, Colors.STEPS_UP_TO_100, PROGRESS_STROKE);
        }
    }

    private function updateBatteryStatus(dc){
        var batteryLevel = getBatteryLevel();
        var color = getBatteryColor(batteryLevel);
        drawProgress(dc, RADIUS_S, batteryLevel, color, PROGRESS_STROKE);
        dc.setPenWidth(1);
        var font = Graphics.FONT_SYSTEM_XTINY;
        var text = batteryLevel.format("%.0d");
        if(batteryLevel<100){
            text = text + "%";
        }
        dc.drawText(x, y, Fonts.get(Fonts.Small), text, TextJustification.CC);
    }

    private function drawProgress(dc as Dc, radius, percentageProgress, color, stroke){
        var progressValue = percentageProgress;
        if (percentageProgress > 100.0){
            progressValue = 100.0;
        }else if(percentageProgress<1){
            return;
        }
        var progressLevel = (360 * progressValue/100.0).toNumber();
        dc.setColor(color, Colors.EMPTY);
        var topLevel = 90.0;
        dc.setPenWidth(stroke);
        var arcEnd = topLevel - progressLevel;
        if (arcEnd < 0) {
            arcEnd = 360 + arcEnd;
        }
        var arc = Graphics.ARC_CLOCKWISE;
        dc.drawArc(x, y, radius, arc, topLevel, arcEnd);
    }

    private function getStepsProgress(activityInfo){
        return 100.0 * activityInfo.steps.toFloat() / activityInfo.stepGoal.toFloat();
    }

    private function getBatteryColor(progressValue){
        var result;
        if (progressValue < 15){
            result = Colors.BATTERY_LOW;
        } else if (progressValue < 30){
            result = Colors.BATTERY_MID;
        } else {
            result = Colors.BATTERY_HIGH;
        }
        return result;
    }

    private function getBatteryLevel(){
        return System.getSystemStats().battery;
    }
}