// https://gist.github.com/joonaspaakko/df2f9e31bdb365a6e5df

// Finds all .ai files from the input folder + its subfolders and converts them to the version given below in a variable called "targetVersion"

// Tested in Illustrator cc 2014 (Mac)
// Didn't bother to do a speed test with my macbook air...

#target illustrator

	// If set to false, a new file will be written next to the original file.
	// The new file will have (legacyFile) in the name.
	// Files with (legacyFile) in the file name are always ignored.
var overwrite = false, // boolean
	// Accepted values:
	// 8, 9, 10, 11 (cs), 12 (cs2), 13 (cs3), 14 (cs4), 15 (cs5), 16 (cs6), 17 (cc)
	targetVersion = 16;

if ( app.documents.length > 0 ) {

	alert("ERROR: \n Close all documents before running this script." );

}
// Run the script
else {

	var files,
		folder = Folder.selectDialog("Input folder...");

	// If folder variable return null, user most likely canceled the dialog or
	// the input folder and it subfolders don't contain any .ai files.
	if ( folder != null ) {

		// returns an array of file paths in the selected folder.
		files = GetFiles( folder );

		// This is where things actually start happening...
		process( files );

	}

}


function process( files ) {

	// Loop through the list of .ai files:
	// Open > Save > Close > LOOP
	for ( i = 0; i < files.length; i++ ) {

		// Current file
		var file = files[i]

		// Open
		app.open( file );

		// If overwrite is false, create a new file, otherwise use "file" variable;
		file = !overwrite ? new File( file.toString().replace(".ai", " (legacyFile).ai") ) : file;

		// Save
		app.activeDocument.saveAs( file, SaveOptions_ai() )

		// Close
		app.activeDocument.close( SaveOptions.DONOTSAVECHANGES );

	}

	// For better of for worse...
	alert( "Script is done." );

}

function SaveOptions_ai() {

    var saveOptions = new IllustratorSaveOptions();

    saveOptions.compatibility = Compatibility[ "ILLUSTRATOR" + targetVersion ];
    saveOptions.flattenOutput = OutputFlattening.PRESERVEAPPEARANCE;
    saveOptions.compressed = true; // Version 10 or later
    saveOptions.pdfCompatible = true; // Version 10 or later
    saveOptions.embedICCProfile = true; // Version 9 or later
    saveOptions.embedLinkedFiles = false; // Version 7 or later

    return saveOptions

}

function GetFiles( folder ) {

	var i, item,
		// Array to store the files in...
		files = [],
		// Get files...
		items = folder.getFiles();

	// Loop through all files in the given folder
	for ( i = 0; i < items.length; i++ ) {

		item = items[i];

		// Find .ai files
		var fileformat = item.name.match(/\.ai$/i),
			legacyFile = item.name.indexOf("(legacyFile)") > 0;

		// If item is a folder, check the folder for files.
		if ( item instanceof Folder ) {

			// Combine existing array with files found in the folder
			files = files.concat( GetFiles( item ) );


		}
		// If the item is a file, push it to the array.
		else if ( item instanceof File && fileformat && !legacyFile ) {

			// Push files to the array
			files.push( item );

		}
	}

	return files;
}
