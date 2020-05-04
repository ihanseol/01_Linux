// ������ �������� ��� .ai ������ JPG ���Ϸ� ��ȯ�Ͽ� �ϰ� �����Ѵ�.
// coded by sooop - 2017.07.12

// �����̸��� �ѱ��� ����ִ��� ��� ǥ������ �ʴ´�. 
app.userInteractionLevel = UserInteractionLevel.DONTDISPLAYALERTS;
main();

function main(){
    var sourceFiles = getSourceFiles();
    if(sourceFiles != null){
        var targetFolder = Folder.selectDialog("Select destination folder", new Folder('C:/')); 
        for(var i=0; i<sourceFiles.length; i++){
            processFile(sourceFiles[i], targetFolder);
        }
    }
}

// ���������κ��� ó���� ������ �迭�� �����ϴ� �Լ�
function getSourceFiles(){
    var sourceFolder = Folder.selectDialog("Select source folder", new Folder('C:/'));  // ���� ���� ��ȭ����
    if(sourceFolder != null){  
        var sfiles = sourceFolder.getFiles("*.ai"); 
        if(sfiles != null && sfiles.length > 0){
             alert(sfiles.length + " AI files found");  // ai ������ ������ �����Ѵ�.
             return sfiles;
        }
        else{
            alert("No AI file found. Process canceled."); //ai ������ ������ �峭ġ�ĸ� �۾� ����.
        }
    }
    return null;
}

// ���� �ϳ��� ó���ϴ� �Լ�
function processFile(aFile, destinationFolder) {
    
    if(destinationFolder == undefined){
        destinationFolder = Folder.selectDialog("Select destination folder", new Folder('C:/'));
    }
    
    var currentDoc = app.open(aFile, DocumentColorSpace.RGB);
    
    var savingOptions = (function (){
        var opts = new ExportOptionsJPEG();
        opts.antiAliasing = true;  //��Ƽ�ٸ���� ����
        opts.artBoardClipping = false; //������ �°� �ڸ��� ����
        opts.blurAmount = 0.0; //�� ����
        opts.qualitySetting = 100; //����Ƽ�� 100���� (�⺻���� 30)
        //opts.horizontalScale = 100; //����ũ������
        //opts.verticalScale = 100; //����ũ������
        return opts;
    })();
    
    var targetFile = makeFilePath(currentDoc.name, destinationFolder)
    
    currentDoc.exportFile(targetFile, ExportType.JPEG, savingOptions);
    currentDoc.close(SaveOptions.DONOTSAVECHANGES);
}


function makeFilePath(title, path){  //������ �̸��� ���������� �Ķ���ͷ� ����
	var newName = title.substring(0,title.lastIndexOf('.')) + '.jpg';
	return new File(path + '/' + newName);
}