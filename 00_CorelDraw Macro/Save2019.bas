Sub Save2019()
    ' Recorded 2024-01-04
    Dim SaveOptions As StructSaveAsOptions
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
    ActiveDocument.SaveAs "D:\09_hardRain\09_ihanseol - 2024\01_지열공 - 서울사이버대학교, 13공 - 한일지하수\02_map & whpa\filesave.cdr", SaveOptions
End Sub
