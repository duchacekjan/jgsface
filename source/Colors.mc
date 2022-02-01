module Colors{
    const WEATHER = 0xf8f800;
    const BACKGROUND = 0x000000;
    const EMPTY = -1;
    const LEAD = 0xaaaaaa;
    const DATE_FOREGROUND = 0xffffff;
    const TIME_HRS = new ClockColors(-1,0xf8f800);
    const TIME_MINS = new ClockColors(0xaaaaaa,0xffffff);
    const INFO_BASE = 0xaaaaaa;
    const INFO_NOTIFICATION = 0x00ff00;
    const INFO_HR = 0xff0000;
    const STEPS_UP_TO_100 = 0x00aaff;
    const STEPS_UP_TO_200 = 0x0000ff;
    const STEPS_OVER_200 = 0x00aa00;
    const BATTERY_HIGH = 0x00aa00;
    const BATTERY_MID = 0xff5500;
    const BATTERY_LOW = 0xaa0000;
}

class ClockColors{
    var foreground = -1;
    var border = -1;
    function initialize(foregroundColor, borderColor){
        foreground = foregroundColor;
        border = borderColor;
    }
}