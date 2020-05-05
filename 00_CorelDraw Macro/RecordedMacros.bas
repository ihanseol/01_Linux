Sub ExportToPLT()
    ' Recorded 2020-05-05
    ActiveLayer.Shapes.All.CreateSelection
    
    ActiveLayer.Shapes(2).Style.StringAssign "{""fill"":{""primaryColor"":""CMYK,USER,0,0,0,100,100,00000000-0000-0000-0000-000000000000"",""secondaryColor"":""CMYK,USER,0,0,0,0,100,00000000-0000-0000-0000-000000000000""},""outline"":{""color"":""CMYK,USER,0,0,0,100,100,00000000-0000-0000-0000-000000000000"",""width"":""762""},""transparency"":{}}"
    ActiveLayer.Shapes(1).Shapes(1).Shapes(1).Style.StringAssign "{""fill"":{""type"":""0"",""overprint"":""0"",""winding"":""0""},""outline"":{""type"":""0"",""overprint"":""0"",""angle"":""0"",""behindFill"":""0"",""scaleWithObject"":""0"",""screenSpec"":""0,0,45000000,60,0"",""miterLimit"":""5"",""endCaps"":""0"",""dashAdjust"":""0"",""overlapArrow"":""0"",""color"":""CMYK,USER,0,0,0,100,100,cccd19cb-4675-4a5e-8bda-d0bbbaab8af0"",""dashDotSpec"":""0"",""aspect"":""100"",""justification"":""0"",""dotLength"":""0"",""leftArrow"":""|0"",""rightArrow"":""|0"",""width"":""762"",""rightArrowAttributes"":""0|0|0|0|0|0|0"",""leftArrowAttributes"":""0|0|0|0|0|0|0"",""matrix"":""1,0,0,0,1,0"",""shareArrow"":""0"",""joinType"":""0""},""transparency"":{}}"
    
    Dim expopt As StructExportOptions
    Set expopt = CreateStructExportOptions
    expopt.UseColorProfile = True
    Dim expflt As ExportFilter
    Set expflt = ActiveDocument.ExportEx("C:\Users\minhwasoo\Downloads\01.plt", cdrHPGL, cdrAllPages, expopt)
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


Sub Macro1()
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


