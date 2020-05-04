/**********************************************************
 
ADOBE SYSTEMS INCORPORATED
Copyright 2005-2006 Adobe Systems Incorporated
All Rights Reserved 
 
NOTICE:  Adobe permits you to use, modify, and
distribute this file in accordance with the terms
of the Adobe license agreement accompanying it.
If you have received this file from a source
other than Adobe, then your use, modification,
or distribution of it requires the prior
written permission of Adobe. 
 
*********************************************************/
 
/**********************************************************
 
Export to PDFs.jsx
 
DESCRIPTION
 
This sample gets files specified by the user from the
selected folder and batch processes them and saves them
as PDFs.
 
Edits by Patrick Mineault:
 - only .ai files processed
 - files saved in same folder as the input files
 - export files have name (oldname)_export.pdf
 - PDF settings: non-editable / acrobatLayers=false
      for maximum compatibility with Preview
 
**********************************************************/
 
// Main Code [Execution of script begins here]
 
// uncomment to suppress Illustrator warning dialogs
// app.userInteractionLevel = UserInteractionLevel.DONTDISPLAYALERTS;
 
var destFolder, sourceFolder, files, fileType, sourceDoc, targetFile, pdfSaveOpts;
 
// Select the source folder.
sourceFolder = Folder.selectDialog( 'Select the folder with Illustrator .ai files you want to convert to PDF');
 
// If a valid folder is selected
if ( sourceFolder != null )
{
    files = new Array();
    fileType = "*.ai"; //prompt( 'Select type of Illustrator files to you want to process. Eg: *.ai', ' ' );
 
    // Get all files matching the pattern
    files = sourceFolder.getFiles( fileType );
 
    if ( files.length > 0 )
    {
        // Get the destination to save the files
        //destFolder = Folder.selectDialog( 'Select the folder where you want to save the converted PDF files.', '~' );
        destFolder = sourceFolder;
        for ( i = 0; i < files.length; i++ )
        {
            sourceDoc = app.open(files[i]); // returns the document object
 
            // Call function getNewName to get the name and file to save the pdf
            targetFile = getNewName();
 
            // Call function getPDFOptions get the PDFSaveOptions for the files
            pdfSaveOpts = getPDFOptions( );
 
            // Save as pdf
            sourceDoc.saveAs( targetFile, pdfSaveOpts );
 
            sourceDoc.close();
        }
        alert( 'Files are saved as PDF in ' + destFolder );
    }
    else
    {
        alert( 'No matching files found' );
    }
}
 
/*********************************************************
 
getNewName: Function to get the new file name. The primary
name is the same as the source file.
 
**********************************************************/
 
function getNewName()
{
    var ext, docName, newName, saveInFile, docName;
    docName = sourceDoc.name;
    ext = '_export.pdf'; // new extension for pdf file
    newName = "";
 
    for ( var i = 0 ; docName[i] != "." ; i++ )
    {
        newName += docName[i];
    }
    newName += ext; // full pdf name of the file
 
    // Create a file object to save the pdf
    saveInFile = new File( destFolder + '/' + newName );
 
    return saveInFile;
}
 
/*********************************************************
 
getPDFOptions: Function to set the PDF saving options of the
files using the PDFSaveOptions object.
 
**********************************************************/
 
function getPDFOptions()
{
    // Create the PDFSaveOptions object to set the PDF options
    var pdfSaveOpts = new PDFSaveOptions();
 
    // Setting PDFSaveOptions properties. Please see the JavaScript Reference
    // for a description of these properties.
    // Add more properties here if you like
    pdfSaveOpts.acrobatLayers = false;
    pdfSaveOpts.colorBars = false;
    pdfSaveOpts.colorCompression = CompressionQuality.AUTOMATICJPEGHIGH;
    pdfSaveOpts.compressArt = true; //default
    pdfSaveOpts.embedICCProfile = true;
    pdfSaveOpts.enablePlainText = true;
    pdfSaveOpts.generateThumbnails = true; // default
    pdfSaveOpts.optimization = true;
    pdfSaveOpts.pageInformation = false;
    pdfSaveOpts.preserveEditability = false;
 
    return pdfSaveOpts;
}