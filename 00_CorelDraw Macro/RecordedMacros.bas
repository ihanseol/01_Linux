

Sub SaveToPLT()
 	'macro for export to plt'
    ' Recorded 2020-05-05
    Dim expopt As StructExportOptions
    Set expopt = CreateStructExportOptions
    expopt.UseColorProfile = True
    Dim expflt As ExportFilter
    Set expflt = ActiveDocument.ExportEx("C:\Users\minhwasoo\Downloads\01_out.plt", cdrHPGL, cdrAllPages, expopt)
    With expflt
        .PenLibIndex = 0
        .FitToPage = False
        .ScaleFactor = 100#
        .PageWidth = 24.015749
        .PageHeight = 17.716536
        .FillType = 0 ' FilterHPGLLib.hpglNoFill
        .FillSpacing = 0.005
        .FillAngle = 0#
        .HatchAngle = 90#
        .CurveResolution = 0.02
        .RemoveHiddenLines = False
        .AutomaticWeld = False
        .ExcludeWVC = False
        .PlotterUnits = 1016
        .PlotterOrigin = 0 ' FilterHPGLLib.pltPageCenter
        .Finish
    End With
End Sub


