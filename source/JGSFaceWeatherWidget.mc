import Toybox.Weather;

class JGSFaceWeatherWidget extends JGSFaceWidget{
    private const startX = 0;
    private const startY = 30;
    private var x;
    private var y;
    private var radius = 30;
    private var foregroundColor = 0xf8f800;
    private var weatherFont = null;
    private var temperatureFont = null;
    
    function initialize(){
        JGSFaceWidget.initialize();
        x = startX + radius + 10;
        y = startY + radius + 5;      
    }

    function loadResourcesCore(){
        temperatureFont = Application.loadResource(Rez.Fonts.temperatureFont);
        weatherFont = Application.loadResource(Rez.Fonts.weatherFont);
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

    function freeResourcesCore(){
        weatherFont = null;
        temperatureFont = null;
    }

    private function drawWeatherIcon(dc, weather){
        var condition = null;
        if (weather!=null) {
            condition = weather.condition;
        }
        var iconCode = JGSCommonModule.getWeatherIconCode(condition, System.getClockTime());
        dc.setColor(foregroundColor, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x, y, weatherFont, iconCode, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
    }

    private function drawTemperature(dc, weather){
        var temperature = getTemperature(weather);
        if (temperature!=null && temperature instanceof String) {
            dc.setColor(foregroundColor, Graphics.COLOR_BLACK);
            dc.drawText(x+radius, y-radius, temperatureFont, temperature, Graphics.TEXT_JUSTIFY_RIGHT|Graphics.TEXT_JUSTIFY_VCENTER);
        }
    }

    private function drawLead(dc){
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(1);
        dc.drawCircle(x, y, radius);
    }

    private function getTemperature(weather){
        var temp = null;
        var units="";
        if (System.getDeviceSettings().temperatureUnits == System.UNIT_METRIC) { 
            units = "°C";
            temp = weather.temperature;
        }	else {
            temp = (weather.temperature * 9/5) + 32; 
            units = "°F";
        }	
        if (temp != null && temp instanceof Number) {
            return temp.format("%.0d")+units;
        } else {
            return null;
        }
    }
}