class JGSFaceCommon{
    function drawWeatherIcon(dc, x, y, color) {
		var clockTime = System.getClockTime();
		var WeatherFont = Application.loadResource(Rez.Fonts.weatherFont);
		if(Toybox.Weather has :getCurrentConditions and Toybox.Weather.getCurrentConditions() != null) {
            var weather = Toybox.Weather.getCurrentConditions();
            var condition = "";
            var isNight = clockTime.hour >= 18 or clockTime.hour < 6;

            switch(weather.condition){
                case Toybox.Weather.CONDITION_CLEAR:{
                    condition = "A";
                    break;
                }
                case Toybox.Weather.CONDITION_PARTLY_CLOUDY:{
                    condition="B";
                    break;
                }
                case Toybox.Weather.CONDITION_RAIN:{
                    condition="C";
                    break;
                }
                case Toybox.Weather.CONDITION_FOG:{
                    condition="D";
                    break;
                }
                case Toybox.Weather.CONDITION_MOSTLY_CLEAR:{
                    condition="E";
                    break;
                }
                case Toybox.Weather.CONDITION_LIGHT_SNOW:{
                    condition="F";
                    break;
                }
                case Toybox.Weather.CONDITION_HEAVY_SNOW:{
                    condition="G";
                    break;
                }
                case Toybox.Weather.CONDITION_THUNDERSTORMS:{
                    condition="H";
                    break;
                }
                case Toybox.Weather.CONDITION_CLOUDY:{
                    condition="I";
                    break;
                }
                default:{
                    condition="Z";
                }
            }

            if(isNight){
                condition = condition.toLower();
            }

            if(condition!=""){
                dc.setColor(color, Graphics.COLOR_TRANSPARENT);
                dc.drawText(x, y, WeatherFont, condition, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);

                var temperatureFont = Application.loadResource(Rez.Fonts.temperatureFont);            
                var temperature = getTemperature(weather, false);
                drawTemperature(dc, x+10, y-28, temperatureFont, temperature, color);
                // var temperatureFeelFont = Application.loadResource(Rez.Fonts.temperatureFeelFont);
                // var temperatureFeel = getTemperature(weather, true);
                // drawTemperature(dc, x-22, y+20, temperatureFeelFont, temperatureFeel, color);
                var hasTemperature = temperature!=null;
                //var hasTemperatureFeel = temperatureFeel!=null;
                //drawWeatherLead(dc, x, y, Graphics.COLOR_DK_GRAY, hasTemperature, hasTemperatureFeel);
                drawWeatherLead(dc, x, y, Graphics.COLOR_DK_GRAY, hasTemperature, false);
            }
        }
        else{
            dc.setColor(color, Graphics.COLOR_TRANSPARENT);
            dc.drawText(x, y, WeatherFont, "Z", Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
        }
	}

    function drawDateString( dc, x, y ) {
        var info = Time.Gregorian.info(Time.now(), Time.FORMAT_LONG);
        var dateStr = Lang.format("$1$ $2$", [info.month, info.day]);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        var offset = dc.getFontHeight(Graphics.FONT_TINY);
       	dc.drawText(x, y, Graphics.FONT_TINY, dateStr, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);   
        dc.drawText(x, y+offset, Graphics.FONT_TINY, info.day_of_week, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
    }

    private function drawWeatherLead(dc,x,y, color, hasTemperature, hasTemperatureFeel){
        dc.setColor(color, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(1);
        var radius = 30;
        if(hasTemperature && hasTemperatureFeel){
            dc.drawArc(x, y, radius, Graphics.ARC_COUNTER_CLOCKWISE, 120, 195);
            dc.drawArc(x, y, radius, Graphics.ARC_COUNTER_CLOCKWISE, 255, 25);
        }else if(hasTemperature){            
            dc.drawArc(x, y, radius, Graphics.ARC_COUNTER_CLOCKWISE, 120, 25);
        } else if(hasTemperatureFeel){
            dc.drawArc(x, y, radius, Graphics.ARC_COUNTER_CLOCKWISE, 255, 195);
        }else{
            dc.drawCircle(x, y, radius);
        }
    }

    private function drawTemperature(dc, x, y, font, temperature, color){
        if (temperature != null ){
            var justify = Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER;
            dc.setColor(color, Graphics.COLOR_TRANSPARENT);
            dc.drawText(x, y, font, temperature, justify);
        }
    }

    private function getTemperature(weather, useFeel){
        var targetMetric = System.getDeviceSettings().temperatureUnits;
        var temp = "";
        var units = "";
        var temperature = null;
        if(useFeel && weather has :feelsLikeTemperature){
            temperature = weather.feelsLikeTemperature;
        }else if(weather has :temperature){
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