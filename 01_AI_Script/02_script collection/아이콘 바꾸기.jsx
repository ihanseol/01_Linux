/////////////////////////////////////////////////////////////////
//Copy to Object(s) v7 -- CS,CS2,CS3
// Hacked again by Nathaniel Vaughn KELSO
// Last modified: 2008.March.30
// Created: 2007.July.7 
// at Hyattsville, MD
// Version 2
// (c) nvkelso2008@gmail.com (but remove the 2008 bit)
// "Multiple-object-replacement" hack by Iain Henderson
// iain@addition.com.au
// 
//>=--------------------------------------
// User selects two (or more) objects:
// This script copies the top most object to the position and size of 
// all other selected objects.
//
//Version 2 update: now adjusts stroke based on difference in area.
//Version 3 update: now accepts multiple targets (Thanks Iain)
//Version 4 update: Deselects everything but source object 
//  --this makes it easy to delete the source object if you wish,
//  -- also this makes the older "Replace-Object" script obsolete.
//Version 5 update: option to NOT transform to fit original shape
//  -- with additional option flag to register the replacing shape to
//     the being-replaced shape's center instead of upper-left corner
//TODO: add flag to delete "master" replacing symbol on completion
//>=--------------------------------------
// JS code (c) copyright: John Wundes ( john@wundes.com ) www.wundes.com
//copyright full text here:  http://www.wundes.com/js4ai/copyright.txt
////////////////////////////////////////////////////////////////// 

	//initialize vars
	//
	//*******************************************************
	// Toggles for scaling object, fitting to original, offset to center
	//toggle for scaling stroke: set to true to scale stroke.
	var scaledStroke = false;							// when fitting original dimensions, scale the stroke
	var scaledObject = false;							// fit to original dimensions
	var scaleMethod = "scaleToFit";					// if true, do NOT scale to fit original bounds but favor the smallest percentage of X or Y scaling for both X and Y
	var scalingCentered = true;							// register with center of being-replaced object
	var groupFindAndReplaceResults = false;		// often not desired
	var keepReplacedSelected = true;				// the result
	var keepReplaceWithObjSelected = true;		// the model object that everything is replaced with
	var deleteReplaceWithObj = true;				// the model object that everything is replaced with

var selObjs = "Please select at least two objects on the page.";
var docRef = activeDocument;
if (documents.length>0) {
	if (docRef.selection.length > 1) {
		mySelection = docRef.selection;
		var sourceObj = docRef.selection[0];
		//if object is a (collection of) object(s) not a text field.
		if (mySelection instanceof Array) {
			//*******************************************************
			//create stroke Array
			var strokeArray = new Array();
			//create bounding objects 
			//********************************************************
			var origBounds = mySelection[0].geometricBounds;
			
			//define paramaters of top object
			var oul_x = origBounds[0];
			var oul_y = origBounds[1];
			var olr_x = origBounds[2];
			var olr_y = origBounds[3];
			var oSelWidth = (olr_x-oul_x);
			var oSelHeight = (oul_y-olr_y);
			var oSelPos = [oul_x, oul_y];
			// *********************************************************
			var initBounds;
			var ul_x;
			var ul_y;
			var lr_x;
			var lr_y;
			var mySelWidth;
			var mySelHeight;
			var mySelPos;
			
			var alterObjectArray = new Array();
			
			for (var i=0; i < mySelection.length; i++) {
				eval('subArray' + i + '=' + 'new Array()');
				eval('subArray' + i + '["object"]' +  '=' + mySelection[i]);
				initBounds = mySelection[i].geometricBounds;
				ul_x = initBounds[0];
				ul_y = initBounds[1];
				lr_x = initBounds[2];
				lr_y = initBounds[3];
				mySelWidth = (lr_x-ul_x);
				mySelHeight = (ul_y-lr_y);
				mySelPos = [ul_x, ul_y];
				mySelOffsetXpos = (ul_x + mySelWidth / 2 - oSelWidth / 2);
				mySelOffsetYpos = (ul_y - mySelHeight / 2 + oSelHeight / 2);
				eval('subArray' + i + '["width"]=' + mySelWidth);
				eval('subArray' + i + '["xpos"]=' + ul_x);
				eval('subArray' + i + '["ypos"]=' + ul_y);
				eval('subArray' + i + '["height"]=' + mySelHeight);
				eval('subArray' + i + '["offsetXpos"]=' + mySelOffsetXpos);
				eval('subArray' + i + '["offsetYpos"]=' + mySelOffsetYpos);
				
				eval('alterObjectArray.push(subArray' + i + ')');
			}
			
			for (var i=1; i < alterObjectArray.length; i++) {
				//find proportional Difference
				//average height and width to find new stroke
				if (scaledStroke == true ) {
					var wdiff = mySelWidth/oSelWidth;
					var whght = mySelHeight/oSelHeight;
					var propDiff = (wdiff+whght)/2;
				} else {
					var propDiff = 1;
				}
				//mark stroked Items
				//apply transforms
				var newGroup = mySelection[i].parent.groupItems.add();
				//modify move behavior for changes in JS for CS...
				if (version == "10.0") {
					newGroup.moveToEnd(mySelection[i].parent);
					tempItem = mySelection[0].duplicate( mySelection[i], ElementPlacement.PLACEBEFORE);
					tempItem.moveToEnd(newGroup);
				} else {
					newGroup.move(mySelection[i], ElementPlacement.PLACEBEFORE);
					mySelection[0].duplicate(newGroup, ElementPlacement.PLACEATEND);
				}
				markStroked(newGroup);

				// Check to see if the replacing object should be scaled down/up to fit the dimensions of the being-replaced object
				if ( scaledObject == true) {
					eval('newGroup.position = [alterObjectArray['+i+']["xpos"], alterObjectArray['+i+']["ypos"]]');		
					//eval('newGroup.position = [alterObjectArray['+i+']["offsetXpos"], alterObjectArray['+i+']["offsetYpos"]]');
					newGroupWidth = newGroup.width;
					newGroupHeight = newGroup.height;
					
					tempObjCenterX = newGroup.position[0] + newGroup.width / 2;
					tempObjCenterY = newGroup.position[1] - newGroup.height /2;
					
					replacingWidth  = eval('newGroup.width  = alterObjectArray[' + i +']["width"]');
					replacingHeight = eval('newGroup.height = alterObjectArray['+ i +']["height"]');
	
					switch( scaleMethod) {
						case "proportionalX":
							if( newGroupWidth >= newGroupHeight ) {
								eval('newGroup.height = alterObjectArray['+ i +']["width"]');
								eval('newGroup.width   = alterObjectArray['+ i +']["width"]');
								// now offset X as needed
								if( newGroup.height >= mySelection[0].height ) {
									newGroup.top = newGroup.top + replacingHeight / 2;
								} else {
									newGroup.top = newGroup.top - replacingHeight / 2;
								}
							} else {
								eval('newGroup.height = alterObjectArray['+ i +']["height"]');
								eval('newGroup.width   = alterObjectArray['+ i +']["height"]');
								// now offset X as needed
								newGroup.left = newGroup.left  + replacingWidth / 2;
							}							
							break;						
						case "proportionalY":
							if( newGroupWidth >= newGroupHeight ) {
								eval('newGroup.height = alterObjectArray['+ i +']["height"]');
								eval('newGroup.width   = alterObjectArray['+ i +']["height"]');
								// now offset X as needed
								if( newGroup.width >= mySelection[0].width ) {
									newGroup.left = newGroup.left  - replacingWidth / 2;
								} else {
									newGroup.left = newGroup.left + replacingWidth / 2;
								}
							} else {
								eval('newGroup.height = alterObjectArray['+ i +']["width"]');
								eval('newGroup.width   = alterObjectArray['+ i +']["width"]');
								// now offset X as needed
								newGroup.top = newGroup.top  + replacingHeight / 2;
							}
							break;
						case "proportionalXY":
							xy_Average = ( eval('alterObjectArray['+ i +']["height"]') + eval('alterObjectArray[' + i +']["width"]') ) /2;
							newGroup.height = xy_Average;
							newGroup.width = xy_Average;
							if( newGroup.width >= mySelection[0].width ) {
								newGroup.left = (newGroup.left  + newGroup.width  / 2 - replacingWidth / 2);
							} else {
								newGroup.left = (newGroup.left  + newGroup.height / 2 - replacingHeight / 2);
							}
							if( newGroup.height >= mySelection[0].height ) {
								newGroup.top = (newGroup.top + newGroup.height / 2 - replacingHeight / 2);
							} else  {
								newGroup.top = (newGroup.top + newGroup.height / 2 + replacingHeight / 2);
							}
							break;
						case "scaleToFit":
						default:
							eval('newGroup.height = alterObjectArray['+ i +']["height"]');
							eval('newGroup.width = alterObjectArray[' + i +']["width"]');
							break;
					}
					tempGroupWidth  = newGroup.width;
					tempGroupHeight = newGroup.height;
									
					
					// now offset Y as needed
					//newGroup.top = newGroup.top + newGroupHeight / 2 - tempGroupHeight / 2;
				} else {
					// Check to see if the replacing object should be registered to the upper left corer of 
					// the being-replaced objects or if it should be centered on the being-replaced object
					if( scalingCentered == true ) {
						eval('newGroup.position = [alterObjectArray['+i+']["offsetXpos"], alterObjectArray['+i+']["offsetYpos"]]');
					} else {
						eval('newGroup.position = [alterObjectArray['+i+']["xpos"], alterObjectArray['+i+']["ypos"]]');
					}
				}

				mySelection[i].remove();
				//restroke with new proportions
				scaleStroke(strokeArray, propDiff);
				
				howManyGroupItems = newGroup.pageItems.length - 1;
				
				if( groupFindAndReplaceResults ) {
					// they are already grouped
					if( keepReplacedSelected ) {
						theMovedObject.selected = true;
					} else {
						theMovedObject.selected = false;
					}
				} else {
					// but was the original a group?
					if( mySelection[0].typename == "GroupItem" ) {
						// do nothing
						if( keepReplacedSelected ) {
							newGroup.selected = true;
						} else {
							newGroup.selected = false;
						}
					} else {
						for( g=0; g<=howManyGroupItems; g++ ) {
							theMovedObject = newGroup.pageItems[g].duplicate( newGroup, ElementPlacement.PLACEBEFORE );
							if( keepReplacedSelected ) {
								theMovedObject.selected = true;
							} else {
								theMovedObject.selected = false;
							}
						}
						// now that the group is empty of items, delete the group
						newGroup.remove();
					}
				}
			}
			// Do we want to have the "replacing" object SELECTED after the result is processed and displayed (and may be selected)?
			if( keepReplaceWithObjSelected ) {
				sourceObj.selected = true;
			} else {
				sourceObj.selected = false;
			}
			// Do we want to have the "replacing" object DELETED after the result is processed and displayed (and may be selected)?
			if( deleteReplaceWithObj ) {
				sourceObj.remove();
			}
		} else {
			alert(selObjs);
		}
	} else {
		alert(selObjs);
	}
}
//Create the stroke Object that goes into the stroke Array.
//   contains the items colorObject, and it's initial stroke weight.
function strokeObj(pName, strokeWt) {
	this.pName = pName;
	this.strokeWt = strokeWt;
}
function markStroked(Sel) {
	var slen = Sel.length;
	// if selected is a single object...
	if (Sel.typename == "GroupItem") {
		markStroked(Sel.pageItems);
	} else if (Sel.typename == "CompoundPathItem") {
		//add object and stroke weight to the array...
		myColor = Sel.pathItems[0];
		myWt = myColor.strokeWidth;
		bob = new strokeObj(myColor, myWt);
		strokeArray.push(bob);
	} else if (Sel.typename == "TextFrame") {
		if (Sel.textRange.characterAttributes.strokeColor.typename != "NoColor") {
			var clMax = Sel.textRange.characters.length;
			for (var cl=0; cl<clMax; cl++) {
				myColor = Sel.textRange.characters[0].characterAttributes;
				myWt = myColor.strokeWeight;
				bob = new strokeObj(myColor, myWt);
				strokeArray.push(bob);
			}
		}
	}
	// if selected contains more than one object...
	for (var a=0; a<slen; a++) {
		if (Sel[a].typename == "GroupItem") {
			//alert("a group in markStroke");
			markStroked(Sel[a].pageItems);
		} else if (Sel[a].typename == "CompoundPathItem") {
			myColor = Sel[a].pathItems[0];
			myWt = myColor.strokeWidth;
			bob = new strokeObj(myColor, myWt);
			strokeArray.push(bob);
		} else if (Sel[a].typename == "PathItem") {
			if (Sel[a].stroked == true) {
				myColor = Sel[a];
				myWt = myColor.strokeWidth;
				bob = new strokeObj(myColor, myWt);
				strokeArray.push(bob);
			}
		} else if (Sel[a].typename == "TextFrame") {
			if (Sel[a].textRange.characterAttributes.strokeColor.typename != "NoColor") {
				var clMax = Sel[a].textRange.characters.length;
				for (var cl=0; cl<clMax; cl++) {
					myColor = Sel[a].textRange.characters[cl].characterAttributes;
					myWt = myColor.strokeWeight;
					bob = new strokeObj(myColor, myWt);
					strokeArray.push(bob);
				}
			}
		}
	}
}
function scaleStroke(mySlx, strokeScale) {
	var slen = mySlx.length;
	for (var a=0; a<slen; a++) {
		//set it's strokeweight or strokewidth, whatever... :)
		mySlx[a].pName.strokeWidth = mySlx[a].strokeWt*strokeScale;
		mySlx[a].pName.strokeWeight = mySlx[a].strokeWt*strokeScale;
	}
}

