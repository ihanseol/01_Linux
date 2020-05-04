var idoc = app.activeDocument;
var sel = idoc.selection;
for (i=sel.length-1; i>=0; i--)
          {
                    var ilayer = idoc.layers.add();
                    var pgItem = sel[i];
                    pgItem.move(ilayer,ElementPlacement.PLACEATEND)
                    ilayer.name = pgItem.name;
          }