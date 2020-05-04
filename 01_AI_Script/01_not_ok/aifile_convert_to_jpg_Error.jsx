var  sAlertDocumentNotOpen = "No open document !";

var jpgQuality = 10;

main();

function main() {       

        if ( app.documents.length <= 0 ) {

               alert( sAlertDocumentNotOpen  );

                return 'cancel';

        }

        var fileName = app.activeDocument.fullName.toString().slice( 0, -4 );

        var jpgDoc = app.activeDocument.duplicate( "JPGFILE", true );    

     

        saveFile( jpgDoc, fileName );

     

        return true;

}

function saveFile( docRef, fileName ) {

            docRef.bitsPerChannel = BitsPerChannelType.EIGHT;        

            var saveFile = new File( fileName );

            jpgSaveOptions = new JPEGSaveOptions();

            jpgSaveOptions.embedColorProfile = true;

            jpgSaveOptions.quality = jpgQuality;

            docRef.saveAs(saveFile, jpgSaveOptions, true, Extension.LOWERCASE);

            docRef.close( SaveOptions.DONOTSAVECHANGES );

            return true;

}        

function pad(num, size) {

    var s = "" + num;

    return s.substr(s.length-size);

}

