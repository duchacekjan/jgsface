class JGSFaceProgressWidget {    

    private const startX = 0;
    private const startY = 240;
    private const RADIUS_S = 20;
    private const RADIUS_M = 27;
    private const RADIUS_L = 33;
    private const PROGRESS_STROKE = 4;
    private var x;
    private var y;
    private var batteryFont = null;
    
    function initialize(){    
        x = startX + 35 + 3;
        y = startY - RADIUS_L - 7;
    }

    function loadResources(){
        batteryFont = Application.loadResource(Rez.Fonts.temperatureFont);
    }

    function freeResources(){
        batteryFont = null;
    }

    function update(dc){
        drawLeads(dc);
        drawProgress2(dc, RADIUS_L, 75, getStepsColor(75));
        drawProgress2(dc, RADIUS_M, 50, Graphics.COLOR_GREEN);
        drawProgress2(dc, RADIUS_S, 100, Graphics.COLOR_RED);
        dc.setPenWidth(1);
        var font = Graphics.FONT_SYSTEM_XTINY;
        dc.drawText(x, y, batteryFont, "100", Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
    }

    private function drawLeads(dc){
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(1);
        dc.drawCircle(x, y, RADIUS_S);
        dc.drawCircle(x, y, RADIUS_M);
        dc.drawCircle(x, y, RADIUS_L);
    }

    private function drawProgress(dc, radius, progress){
        dc.setPenWidth(PROGRESS_STROKE);
        dc.setColor(color, Graphics.COLOR_TRANSPARENT);
        //TODO caculate correctly
        var startAngle = 90;
        var endAngle = (360.0 * progress/100.0)-90.0;
        if(endAngle<0){
            endAngle=360+endAngle;
        }
        dc.drawArc(x, y, radius, Graphics.ARC_CLOCKWISE, startAngle, endAngle);
    }

    private function drawProgress2(dc as Dc, radius, percentageProgress, color){
        var progressValue = percentageProgress;
        if (percentageProgress > 100.0){
            progressValue = 100.0;
        }
        var progressLevel = (360 * progressValue/100.0).toNumber();
        dc.setColor(color, Graphics.COLOR_TRANSPARENT);
        var topLevel = 90.0;
        dc.setPenWidth(PROGRESS_STROKE);
        var arcEnd = topLevel - progressLevel;
        if (arcEnd < 0) {
            arcEnd = 360 + arcEnd;
        }
        var arc = Graphics.ARC_CLOCKWISE;
        // if(isReverse){
        //     arc = Graphics.ARC_COUNTER_CLOCKWISE;
        // }
        dc.drawArc(x, y, radius, arc, topLevel, arcEnd);
        dc.setPenWidth(1);
    }

    private function getStepsColor(progressValue){
        return Graphics.COLOR_BLUE;
    }
}