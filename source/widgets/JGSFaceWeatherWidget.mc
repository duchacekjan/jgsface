import Toybox.Weather;
import Toybox.Lang;

class JGSFaceWeatherWidget extends JGSFaceWidget{
    private const startX = 0;
    private const startY = 30;
    private var x;
    private var y;
    private var radius = 30;
    
    function initialize(){
        JGSFaceWidget.initialize();
        x = startX + radius + 10;
        y = startY + radius + 5;      
    }

    function updateCore(dc){
        drawLead(dc);
        var weather = null;
        if (Weather has :getCurrentConditions && Weather.getCurrentConditions()!=null) {
            weather = Weather.getCurrentConditions();
        } 
        drawTemperature(dc, weather);
        drawWeatherIcon(dc, weather);
    }

    private function drawWeatherIcon(dc, weather){
        var condition = null;
        if (weather!=null) {
            condition = weather.condition;
        }
        var iconCode = Common.getWeatherIconCode(condition, System.getClockTime());
        dc.setColor(Colors.WEATHER, Colors.EMPTY);
        dc.drawText(x, y, Fonts.get(Fonts.Weather), iconCode, TextJustification.CC);
    }

    private function drawTemperature(dc, weather){
        var temperature = getTemperature(weather);
        dc.setColor(Colors.WEATHER, Colors.BACKGROUND);
        dc.drawText(x+radius, y-radius, Fonts.get(Fonts.Small), temperature.getText(), TextJustification.RC);
    }

    private function drawLead(dc){
        dc.setColor(Colors.LEAD, Colors.EMPTY);
        dc.setPenWidth(1);
        dc.drawCircle(x, y, radius);
    }

    private function getTemperature(weather){
        var result = new Temperature(null);
        if(weather has :temperature){
            result = new Temperature(weather.temperature);
        } else if(weather has :feelsLikeTemperature){
            result = new Temperature(weather.feelsLikeTemperature);
        }
        return result;
    }
}

class Temperature{
    function initialize(temperature){
        if (temperature != null and (temperature instanceof Number)){
            var targetUnit = System.getDeviceSettings().temperatureUnits;
            if(targetUnit==System.UNIT_METRIC){
                value = temperature;
                unit = "C";
            }else{
                value =  (temperature * 9.0/5.0) + 32;            
                unit = "F";
            }
            isAssigned = true;
        }        
    }

    var value = null;
    var unit = null;
    private var isAssigned = false;

    function getText(){
        if (isAssigned){
            var format = " $1$°$2$";
            var args = [value.format("%d"), unit];
            return Lang.format(format, args);
        } else {
            return " N/A";
        }
    }
}