import Toybox.Weather;

class JGSFaceWeatherWidget{
    private var x = 36;
    private var y = 65;
    private var radius = 30;
    private var foregroundColor = 0xf8f800;
    private var weatherIconsMap;
    private var _weatherFont = null;
    private var _temperatureFont = null;
    
    function initialize(){
        weatherIconsMap = new JgsWeatherIconMap();        
    }

    function loadResources(){
        _temperatureFont = Application.loadResource(Rez.Fonts.temperatureFont);
        _weatherFont = Application.loadResource(Rez.Fonts.weatherFont);
    }

    function update(dc){
        drawLead(dc);
        var weather = null;
        if(Weather has :getCurrentConditions && Weather.getCurrentConditions()!=null){
            weather = Weather.getCurrentConditions();
        } 
        drawTemperature(dc, weather);
        drawWeatherIcon(dc, weather);
    }

    function freeResources(){
        weatherIconsMap = null;
        _weatherFont = null;
        _temperatureFont = null;
    }

    private function getWeatherFont(){
        if(_weatherFont==null){
            _weatherFont = Application.loadResource(Rez.Fonts.weatherFont);
        }

        return _weatherFont;
    }

    private function getTemperatureFont(){
        if(_temperatureFont==null){
            _temperatureFont = Application.loadResource(Rez.Fonts.temperatureFont);
        }

        return _temperatureFont;
    }

    private function drawWeatherIcon(dc, weather){
        var condition = null;
        if(weather!=null){
            condition = weather.condition;
        }
        var iconCode = weatherIconsMap.getWeatherIconCode(condition);
        dc.setColor(foregroundColor, Graphics.COLOR_TRANSPARENT);
        var font = getWeatherFont();
        dc.drawText(x, y, font, iconCode, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
    }

    private function drawTemperature(dc, weather){
        var temperature = getTemperature(weather);
        if(temperature!=null && temperature instanceof String){
            dc.setColor(foregroundColor, Graphics.COLOR_BLACK);
            var font = getTemperatureFont();
            dc.drawText(x+radius, y-radius, font, temperature, Graphics.TEXT_JUSTIFY_RIGHT|Graphics.TEXT_JUSTIFY_VCENTER);
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