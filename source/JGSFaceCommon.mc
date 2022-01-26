class JGSFaceCommon{
    var _weatherIconMap;
    function initialize(){
        _weatherIconMap = new JgsWeatherIconMap();
    }
    function drawWeatherIcon(dc, x, y, color) {
		var clockTime = System.getClockTime();
		var WeatherFont = Application.loadResource(Rez.Fonts.weatherFont);
        var condition = null;
		if(Toybox.Weather has :getCurrentConditions and Toybox.Weather.getCurrentConditions() != null) {
            var weather = Toybox.Weather.getCurrentConditions();            
            condition = weather.condition;

            var temperature = getTemperature(weather);
            if(temperature!=null){
                var temperatureFont = Application.loadResource(Rez.Fonts.temperatureFont);            
                drawTemperature(dc, x+10, y-28, temperatureFont, temperature, color);
            }
        }
        else{
        }
        var iconCode = _weatherIconMap.getWeatherIconCode(condition);
            dc.setColor(color, Graphics.COLOR_TRANSPARENT);
            dc.drawText(x, y, WeatherFont, iconCode, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
            
        drawWeatherLead(dc, x, y, Graphics.COLOR_DK_GRAY);
	}

    function drawDateString( dc, x, y ) {
        var info = Time.Gregorian.info(Time.now(), Time.FORMAT_LONG);
        var dateStr = Lang.format("$1$ $2$", [info.month, info.day]);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        var offset = dc.getFontHeight(Graphics.FONT_TINY);
       	dc.drawText(x, y, Graphics.FONT_TINY, dateStr, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);   
        dc.drawText(x, y+offset, Graphics.FONT_TINY, info.day_of_week, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
    }

    private function drawWeatherLead(dc,x,y, color){
        dc.setColor(color, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(1);
        var radius = 30;
        dc.drawCircle(x, y, radius);
    }

    private function drawTemperature(dc, x, y, font, temperature, color){
        if (temperature != null ){
            var justify = Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER;
            dc.setColor(color, Graphics.COLOR_BLACK);
            dc.drawText(x, y, font, temperature, justify);
        }
    }

    private function getTemperature(weather){
        var targetMetric = System.getDeviceSettings().temperatureUnits;
        var temp = "";
        var units = "";
        var temperature = null;
        // if(weather has :feelsLikeTemperatrure){
        //     temperature = weather.feelsLikeTemperature;
        // } else
        if(weather has :temperature){
            temperature = weather.temperature;
        }


        if(temperature!=null and (temperature instanceof Number)){
            if (targetMetric == System.UNIT_METRIC) { 
                units = "°C";
                temp = temperature;
            }	else {
                temp = (temperature * 9/5) + 32; 
                units = "°F";
            }
            return temp + units;
        }else{
            return null;
        }
    }
}