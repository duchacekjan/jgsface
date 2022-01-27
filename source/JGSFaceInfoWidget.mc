class JGSFaceInfoWidget {    

    private const y = 0;
    private const x = 0;
    private var iconsFont = null;
    
    function initialize(){    
    }

    function loadResources(){
        iconsFont = Application.loadResource(Rez.Fonts.temperatureFont);
    }

    function freeResources(){
        iconsFont = null;
    }

    function update(dc){
    }
}