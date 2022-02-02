import Toybox.Weather;

module Common{
	function isInSleepMode(){
		return false;
		//TODO Disabled for now.
		var userProfile = Toybox.UserProfile.getProfile();

		var oToday = Toybox.Time.today();
		var oSleepTime = userProfile.sleepTime;
		var oWakeTime = userProfile.wakeTime;
		var oNow = Toybox.Time.now();
		var oneDay = new Toybox.Time.Duration(24*60*60);

		var wakeTime = oToday.add(oWakeTime);
		var shouldAddDay = oWakeTime.lessThan(oSleepTime);
		if(shouldAddDay){
			wakeTime = wakeTime.add(oneDay);
		}
		var sleepTime = oToday.add(oSleepTime);

		var currentTime = Toybox.Time.now();
		if(currentTime.lessThan(sleepTime) && shouldAddDay){
			currentTime = currentTime.add(oneDay);
		}

		return currentTime.greaterThan(sleepTime) &&
			   currentTime.lessThan(wakeTime);
	}

    function getWeatherIconCode(condition, clockTime){
		var isNight = clockTime.hour >= 18 or clockTime.hour < 6;
		var code;
		switch(condition){
			case Toybox.Weather.CONDITION_CLEAR:{
				code='A';
				break;
			}
			case Toybox.Weather.CONDITION_PARTLY_CLOUDY:{
				code='B';
				break;
			}
			case Toybox.Weather.CONDITION_MOSTLY_CLOUDY:{
				code='C';
				break;
			}
			case Toybox.Weather.CONDITION_RAIN:{
				code='D';
				break;
			}
			case Toybox.Weather.CONDITION_SNOW:{
				code='E';
				break;
			}
			case Toybox.Weather.CONDITION_WINDY:{
				code='F';
				break;
			}
			case Toybox.Weather.CONDITION_THUNDERSTORMS:{
				code='G';
				break;
			}
			case Toybox.Weather.CONDITION_WINTRY_MIX:{
				code='H';
				break;
			}
			case Toybox.Weather.CONDITION_FOG:{
				code='I';
				break;
			}
			case Toybox.Weather.CONDITION_HAZY:{
				code='@';
				break;
			}
			case Toybox.Weather.CONDITION_HAIL:{
				code='J';
				break;
			}
			case Toybox.Weather.CONDITION_SCATTERED_SHOWERS:{
				code='K';
				break;
			}
			case Toybox.Weather.CONDITION_SCATTERED_THUNDERSTORMS:{
				code='L';
				break;
			}
			case Toybox.Weather.CONDITION_UNKNOWN_PRECIPITATION:{
				code='?';
				break;
			}
			case Toybox.Weather.CONDITION_LIGHT_RAIN:{
				code='7';
				break;
			}
			case Toybox.Weather.CONDITION_HEAVY_RAIN:{
				code='4';
				break;
			}
			case Toybox.Weather.CONDITION_LIGHT_SNOW:{
				code='6';
				break;
			}
			case Toybox.Weather.CONDITION_HEAVY_SNOW:{
				code='3';
				break;
			}
			case Toybox.Weather.CONDITION_LIGHT_RAIN_SNOW:{
				code='5';
				break;
			}
			case Toybox.Weather.CONDITION_HEAVY_RAIN_SNOW:{
				code='/';
				break;
			}
			case Toybox.Weather.CONDITION_CLOUDY:{
				code='\\';
				break;
			}
			case Toybox.Weather.CONDITION_RAIN_SNOW:{
				code='5';
				break;
			}
			case Toybox.Weather.CONDITION_PARTLY_CLEAR:{
				code='C';
				break;
			}
			case Toybox.Weather.CONDITION_MOSTLY_CLEAR:{
				code='B';
				break;
			}
			case Toybox.Weather.CONDITION_LIGHT_SHOWERS:{
				code='K';
				break;
			}
			case Toybox.Weather.CONDITION_SHOWERS:{
				code='M';
				break;
			}
			case Toybox.Weather.CONDITION_HEAVY_SHOWERS:{
				code='D';
				break;
			}
			case Toybox.Weather.CONDITION_CHANCE_OF_SHOWERS:{
				code='K';
				break;
			}
			case Toybox.Weather.CONDITION_CHANCE_OF_THUNDERSTORMS:{
				code='L';
				break;
			}
			case Toybox.Weather.CONDITION_MIST:{
				code='(';
				break;
			}
			case Toybox.Weather.CONDITION_DUST:{
				code='{';
				break;
			}
			case Toybox.Weather.CONDITION_DRIZZLE:{
				code='#';
				break;
			}
			case Toybox.Weather.CONDITION_TORNADO:{
				code='$';
				break;
			}
			case Toybox.Weather.CONDITION_SMOKE:{
				code='}';
				break;
			}
			case Toybox.Weather.CONDITION_ICE:{
				code='2';
				break;
			}
			case Toybox.Weather.CONDITION_SAND:{
				code='{';
				break;
			}
			case Toybox.Weather.CONDITION_SQUALL:{
				code=']';
				break;
			}
			case Toybox.Weather.CONDITION_SANDSTORM:{
				code='[';
				break;
			}
			case Toybox.Weather.CONDITION_VOLCANIC_ASH:{
				code=')';
				break;
			}
			case Toybox.Weather.CONDITION_HAZE:{
				code='(';
				break;
			}
			case Toybox.Weather.CONDITION_FAIR:{
				code='N';
				break;
			}
			case Toybox.Weather.CONDITION_HURRICANE:{
				code='9';
				break;
			}
			case Toybox.Weather.CONDITION_TROPICAL_STORM:{
				code='8';
				break;
			}
			case Toybox.Weather.CONDITION_CHANCE_OF_SNOW:{
				code='O';
				break;
			}
			case Toybox.Weather.CONDITION_CHANCE_OF_RAIN_SNOW:{
				code='H';
				break;
			}
			case Toybox.Weather.CONDITION_CLOUDY_CHANCE_OF_RAIN:{
				code='7';
				break;
			}
			case Toybox.Weather.CONDITION_CLOUDY_CHANCE_OF_SNOW:{
				code='6';
				break;
			}
			case Toybox.Weather.CONDITION_CLOUDY_CHANCE_OF_RAIN_SNOW:{
				code='5';
				break;
			}
			case Toybox.Weather.CONDITION_FLURRIES:{
				code='4';
				break;
			}
			case Toybox.Weather.CONDITION_FREEZING_RAIN:{
				code='3';
				break;
			}
			case Toybox.Weather.CONDITION_SLEET:{
				code='P';
				break;
			}
			case Toybox.Weather.CONDITION_ICE_SNOW:{
				code='2';
				break;
			}
			case Toybox.Weather.CONDITION_THIN_CLOUDS:{
				code='1';
				break;
			}
			default:{
				code='0';
				break;
			}
		}
		
		if(isNight && code>='A' && code<='Z'){
			code = code.toLower();
		}
		if(code!=null){
			code = code.toString();
		}

		return code;
	}
}