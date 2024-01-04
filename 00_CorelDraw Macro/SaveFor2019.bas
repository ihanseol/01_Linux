
Sub Save2019()
    ' Recorded 2024-01-04
    Dim SaveOptions As StructSaveAsOptions
    Dim strFileName As String
    
    
    Set SaveOptions = CreateStructSaveAsOptions
    With SaveOptions
        .EmbedVBAProject = False
        .Filter = cdrCDR
        .IncludeCMXData = False
        .Range = cdrAllPages
        .EmbedICCProfile = False
        .Version = cdrVersion21
        .KeepAppearance = True
    End With
    
    
    strFileName = GetCurrentFileDirectory() & GetCurrentDocumentName()
    ' MsgBox strFileName
    
    
    ' ActiveDocument.SaveAs "D:\09_hardRain\09_ihanseol - 2024\01_지열공 - 서울사이버대학교, 13공 - 한일지하수\02_map & whpa\filesave.cdr", SaveOptions
    ActiveDocument.SaveAs strFileName, SaveOptions
End Sub


Function GetCurrentDocumentName() As String
    ' Check if there is an active document
    If Documents.Count > 0 Then
        ' Get the current document
        Dim currentDocument As Document
        Set currentDocument = ActiveDocument

        ' Get and display the document name
        Dim documentName As String
        documentName = currentDocument.Name
        ' MsgBox "Current Document Name: " & documentName
    Else
        MsgBox "No active document."
    End If
    
    GetCurrentDocumentName = documentName
End Function


Function GetCurrentFileDirectory() As String
    ' Check if there is an active document
    If Documents.Count > 0 Then
        ' Get the current document
        Dim currentDocument As Document
        Set currentDocument = ActiveDocument

        ' Get the full path of the current document
        Dim fullPath As String
        fullPath = currentDocument.FullFileName

        ' Extract the directory from the full path
        Dim currentDirectory As String
        currentDirectory = Left(fullPath, InStrRev(fullPath, "\"))

        ' Display the current directory
        ' MsgBox "Current File Directory: " & currentDirectory
        
        GetCurrentFileDirectory = currentDirectory
        
    Else
        MsgBox "No active document."
    End If
End Function

Sub GetCurrentDirectory()

    Dim currentDirectory As String
    currentDirectory = CurDir
    MsgBox "Current Directory: " & currentDirectory
End Sub






