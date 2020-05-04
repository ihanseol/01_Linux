// 지정한 폴더내의 모든 .ai 파일을 JPG 파일로 변환하여 일괄 저장한다.
// coded by sooop - 2017.07.12

// 파일이름에 한글이 들어있더라도 경고를 표시하지 않는다. 
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

// 원본폴더로부터 처리할 파일의 배열을 리턴하는 함수
function getSourceFiles(){
    var sourceFolder = Folder.selectDialog("Select source folder", new Folder('C:/'));  // 폴더 지정 대화상자
    if(sourceFolder != null){  
        var sfiles = sourceFolder.getFiles("*.ai"); 
        if(sfiles != null && sfiles.length > 0){
             alert(sfiles.length + " AI files found");  // ai 파일의 갯수를 보고한다.
             return sfiles;
        }
        else{
            alert("No AI file found. Process canceled."); //ai 파일이 없으면 장난치냐며 작업 종료.
        }
    }
    return null;
}

// 파일 하나를 처리하는 함수
function processFile(aFile, destinationFolder) {
    
    if(destinationFolder == undefined){
        destinationFolder = Folder.selectDialog("Select destination folder", new Folder('C:/'));
    }
    
    var currentDoc = app.open(aFile, DocumentColorSpace.RGB);
    
    var savingOptions = (function (){
        var opts = new ExportOptionsJPEG();
        opts.antiAliasing = true;  //안티앨리어싱 적용
        opts.artBoardClipping = false; //대지에 맞게 자르기 안함
        opts.blurAmount = 0.0; //블러 없음
        opts.qualitySetting = 100; //퀄리티는 100으로 (기본값이 30)
        //opts.horizontalScale = 100; //가로크기지정
        //opts.verticalScale = 100; //세로크기지정
        return opts;
    })();
    
    var targetFile = makeFilePath(currentDoc.name, destinationFolder)
    
    currentDoc.exportFile(targetFile, ExportType.JPEG, savingOptions);
    currentDoc.close(SaveOptions.DONOTSAVECHANGES);
}


function makeFilePath(title, path){  //문서의 이름과 목적폴더를 파라메터로 받음
	var newName = title.substring(0,title.lastIndexOf('.')) + '.jpg';
	return new File(path + '/' + newName);
}