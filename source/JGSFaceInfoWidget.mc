class JGSFaceInfoWidget {    

    private const y = 0;
    private const x = 0;
    private const width = 240;
    private const height = 30;
    private var iconsFont = null;
    
    function initialize(){    
    }

    function loadResources(){
        iconsFont = Application.loadResource(Rez.Fonts.iconsFont);
    }

    function freeResources(){
        iconsFont = null;
    }

    function update(dc){
        updateNotifications(dc);
    }

    private function updateNotifications(dc){
        var notificationCount = System.getDeviceSettings().notificationCount;
        if (notificationCount > 0) {
            dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
            var icons =  Application.loadResource(Rez.Fonts.iconsFont);
            dc.drawText(width - 5, height / 2, icons, "A", Graphics.TEXT_JUSTIFY_RIGHT|Graphics.TEXT_JUSTIFY_VCENTER);
        }  
    }
}