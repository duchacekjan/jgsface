class JGSFaceChargingWidget extends JGSFaceWidget{
    private const centerX = 120;
    private const centerY = 120;
    private const radius = 70;
    private const stroke = 15;
    function initialize(){
        JGSFaceWidget.initialize();
    }

    function updateInChargingMode(dc){
        drawLead(dc);
        var batteryLevel = System.getSystemStats().battery;
        var color = Common.getBatteryColor(batteryLevel);
        drawProgress(dc, batteryLevel, color);
        drawIcon(dc, color);
    }

    private function drawIcon(dc, color){
        dc.setColor(color, Colors.EMPTY);
        dc.drawText(centerX, centerY-5, Fonts.get(Fonts.IconsBig), Icons.Charging, TextJustification.CC);
    }

    private function drawLead(dc){
        dc.setColor(Colors.LEAD, Colors.EMPTY);
        dc.setPenWidth(stroke);
        dc.drawCircle(centerX, centerY, radius);
        dc.setPenWidth(1);
    }

    private function drawProgress(dc, percentageProgress, color){
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
        dc.drawArc(centerX, centerY, radius, arc, topLevel, arcEnd);
    }
}