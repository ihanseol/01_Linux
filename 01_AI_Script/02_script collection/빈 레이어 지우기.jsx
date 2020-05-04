// LayersDeleteEmpty
// Deletes all layers which do not have content (empty layers) in the active document
// Nathaniel Vaughn KELSO
// 2007.July.10 
// at Hyattsville, MD
// Version 0.2
// TODO: What about layers that are not visible when the script is run?
// TODO: Right now they are ignored (by Ai Default)...

// only do for the active document
if(documents.length > 0) {
	doc = activeDocument;
}

// Flag to determine if LAYERS only or also look at empty Sublayers
//  WARNING pageItems does NOT include sublayer if they are present!
var doSubLayers = 1;
var deleteEmptyLayers = 1;

var layersDeleted = 0;
var subLayersDeleted = 0;

var targetDocument = doc;
var layerCount = targetDocument.layers.length;


if( deleteEmptyLayers ) {
	// Loop through layers from the back, to preserve index
	// of remaining layers when we remove one
	// TODO: Only looks one level of sublayers deep!!!
	for (var ii = layerCount - 1; ii >= 0; ii-- ) {
		targetLayer = targetDocument.layers[ii];
		var layerObjects = new Number( targetLayer.pageItems.length );

		// For completely empty layers
		if ( layerObjects == 0 && targetLayer.layers.length==0 ) {
			targetDocument.layers[ii].remove();
			layersDeleted++;

		// What if the layer has sublayers?
		// TODO: Only looks one level of sublayers deep!!!
		} else if (doSubLayers ) {
			var subLayerCount = targetLayer.layers.length;
			for (var iii = subLayerCount - 1; iii >= 0; iii-- ) {
				targetSubLayer = targetLayer.layers[iii];
				var subLayerObjects = new Number( targetSubLayer.pageItems.length );

				// For completely empty layers
				if ( subLayerObjects == 0 && targetSubLayer.layers.length==0) {
					targetSubLayer.remove();
					subLayersDeleted++;
				}
			}
			// Check again to see if the layer is now empty if all the empty sublayer have beeen deleted
			// For completely empty layers
			if ( layerObjects == 0 && targetLayer.layers.length==0 ) {
				targetDocument.layers[ii].remove();
				layersDeleted++;
			}
		}
	}
}

	// Reset layer count
	layerCount = targetDocument.layers.length;
	
	for (var ii = layerCount - 1; ii >= 0; ii-- ) {
		targetLayer = targetDocument.layers[ii];

		// For 1st level layers
		// Check for old names and replace with new names
		switch ( targetLayer.name ) {
				case "Type Map" :
					targetLayer.name = "Type map";
					break;
				case "Map Type" :
					targetLayer.name = "Type map";
					break;
				case "Drop Type" :
					targetLayer.name = "Drop type";
					break;
				case "Graphic Type" :
					targetLayer.name = "Graphic type";
					break;
				case "patches" :
					targetLayer.name = "Patches";
					break;
				case "neat line" :
					targetLayer.name = "NEATLINE";
					break;
				case "roads" :
					targetLayer.name = "road cased";
					break;
				case "roads major nofill" :
					targetLayer.name = "roads major";
					break;
				case "Main Map upper" :
					targetLayer.name = "main map upper";
					break;
				case "Main Map lower" :
					targetLayer.name = "main map lower";
					break;
				case "Foreground" :
					targetLayer.name = "MainVectorImport";
					break;
				case "Foreground Loc" :
					targetLayer.name = "LocatorVectorImport";
					break;
		}
		
		if (doSubLayers ) {
			subLayerCount = targetLayer.layers.length;
			for (var j = subLayerCount - 1; j >= 0; j-- ) {
				targetSubLayer = targetLayer.layers[j];
				// Check for old names and replace with new names
				switch ( targetSubLayer.name ) {
					case "Type Map" :
						targetSubLayer.name = "Type map";
						break;
					case "Map Type" :
						targetLayer.name = "Type map";
						break;
					case "Drop Type" :
						targetSubLayer.name = "Drop type";
						break;
					case "Graphic Type" :
						targetSubLayer.name = "Graphic type";
						break;
					case "patches" :
						targetSubLayer.name = "Patches";
						break;
					case "neat line" :
						targetSubLayer.name = "NEATLINE";
						break;
					case "roads" :
						targetSubLayer.name = "road cased";
						break;
					case "roads major nofill" :
						targetSubLayer.name = "roads major";
						break;
					case "Main Map upper" :
						targetSubLayer.name = "main map upper";
						break;
					case "Main Map lower" :
						targetSubLayer.name = "main map lower";
						break;
					case "Foreground" :
						targetSubLayer.name = "MainVectorImport";
						break;
					case "Foreground Loc" :
						targetSubLayer.name = "LocatorVectorImport";
						break;
				}
			}
		}
	
	}
