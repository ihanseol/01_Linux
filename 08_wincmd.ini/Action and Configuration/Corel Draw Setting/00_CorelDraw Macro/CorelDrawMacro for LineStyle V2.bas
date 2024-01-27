
Public Enum MyType
    mtBoundary = 10
    mtCircleWell = 20
    mtCircle500 = 30
    mtCircleER = 40
    mtText = 50
End Enum


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





Sub LayerMove()
    ' Recorded 2021-02-17
    Dim OrigSelection As ShapeRange
    Set OrigSelection = ActiveSelectionRange
    
    ActivePage.Layers("라벨2").Activate
    ActiveLayer.MoveAbove ActivePage.Layers("00aa")
    
    ActivePage.Layers("라벨1").Activate
    ActiveLayer.MoveBelow ActivePage.Layers("라벨2")
    
    ActivePage.Layers("0").Activate
    ActiveLayer.MoveBelow ActivePage.Layers("라벨1")
End Sub


Function ConvertNowToString() As String
    Dim currentDate As Date
    Dim dateString As String
    
    currentDate = Now()
    dateString = Format(currentDate, "YYYY-MM-DD HH:NN:SS")
    
    ConvertNowToString = dateString
End Function


Function RandomString(Length As Integer)
    ' Create a Randomized String of Characters
    Dim CharacterBank As Variant
    Dim x As Long
    Dim str As String
    
    ' Test Length Input
    If Length < 1 Then
        MsgBox "Length variable must be greater than 0"
        Exit Function
    End If
    
    CharacterBank = Array("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", _
      "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", _
      "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "!", "@", _
      "#", "$", "%", "^", "&", "*", "A", "B", "C", "D", "E", "F", "G", "H", _
      "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", _
      "W", "X", "Y", "Z")
    
    ' Randomly Select Characters One-by-One
    For x = 1 To Length
        Randomize
        str = str & CharacterBank(Int((UBound(CharacterBank) - LBound(CharacterBank) + 1) * Rnd + LBound(CharacterBank)))
    Next x
    
    ' Output Randomly Generated String
    RandomString = str
End Function

Function TruncateDecimal(number As Double) As Double
    Dim truncatedNumber As Double
        
    truncatedNumber = Int(number * 100) / 100
    TruncateDecimal = truncatedNumber
End Function



Function FindCircle500() As Double
    Dim AllShapes As Shapes
    Dim shpCheck As Shape
    Dim sx, sy, max As Double
    
    max = 0
    ActivePage.Layers("0").Activate
    Set AllShapes = ActivePage.ActiveLayer.Shapes
         
    For Each shpCheck In AllShapes
        sx = TruncateDecimal(shpCheck.SizeWidth)
        sy = TruncateDecimal(shpCheck.SizeHeight)
        
        
        If sx = sy Then ' if circle
            If max < sx Then max = sx
        End If
    Next

    FindCircle500 = max
End Function


Function CheckShapeType(ByVal shpCheck As Shape, ByVal sx500 As Double) As MyType
    Dim sx, sy As Double
    
    sx = TruncateDecimal(shpCheck.SizeWidth)
    sy = TruncateDecimal(shpCheck.SizeHeight)
       
    If shpCheck.Type = cdrTextShape Then
        CheckShapeType = mtText
        Exit Function
    End If
        
    If shpCheck.Name = "cc" Then
        CheckShapeType = mtCircleWell
        Exit Function
    End If
    
    
    If sx <> sy Then
        CheckShapeType = mtBoundary
        Exit Function
    Else
        If sx500 = sx Then
            CheckShapeType = mtCircle500
            Exit Function
        Else
            CheckShapeType = mtCircleER
            Exit Function
        End If
    End If

End Function

Sub ZDoAllLineWork()
    Dim AllShapes As Shapes
    Dim shpCheck As Shape
    Dim sx500 As Double
    
    
    sx500 = FindCircle500()

    ActivePage.Layers("0").Activate
    Set AllShapes = ActivePage.ActiveLayer.Shapes
    
    
    For Each shpCheck In AllShapes
        Select Case CheckShapeType(shpCheck, sx500)
            Case mtBoundary
                Call DoBoundary(shpCheck)
                
            Case mtCircleWell
                Call DoCircleWell(shpCheck)
            
            Case mtCircleER
                Call DoCircleER(shpCheck)
                
            Case mtCircle500
                Call DoCircle500(shpCheck)
        
            Case mtText
                
        End Select
    Next
    
End Sub


Sub ZFinalWork()

    Call LayerMove
    Call ZDoAllLineWork

End Sub


Sub DoBoundary(shpCheck As Shape)
    shpCheck.ObjectData("Name").Value = "BoundaryLine"
    shpCheck.Style.StringAssign "{""fill"":{""type"":""0"",""overprint"":""0"",""winding"":""0""},""outline"":{""type"":""0"",""overprint"":""0"",""angle"":""0"",""screenSpec"":""0,0,45000000,60,0"",""justification"":""0"",""behindFill"":""0"",""rightArrowAttributes"":""0|0|0|0|0|0|0"",""projectMatrix"":""1,0,0,0,1,0"",""matrix"":""1,0,0,0,1,0"",""joinType"":""2"",""shareArrow"":""0"",""width"":""35278"",""leftArrow"":""|0"",""scaleWithObject"":""0"",""miterLimit"":""5"",""color"":""RGB255,USER,0,0,0,100,00000000-0000-0000-0000-000000000000"",""leftArrowAttributes"":""0|0|0|0|0|0|0"",""overlapArrow"":""0"",""dashDotSpec"":""0"",""dotLength"":""0"",""dashAdjust"":""0"",""aspect"":""100"",""rightArrow"":""|0"",""endCaps"":""0""},""transparency"":{}}"
    shpCheck.Style.StringAssign "{""fill"":{""type"":""0"",""overprint"":""0"",""winding"":""0""},""outline"":{""type"":""0"",""overprint"":""0"",""angle"":""0"",""screenSpec"":""0,0,45000000,60,0"",""justification"":""0"",""behindFill"":""0"",""rightArrowAttributes"":""0|0|0|0|0|0|0"",""projectMatrix"":""1,0,0,0,1,0"",""matrix"":""1,0,0,0,1,0"",""joinType"":""2"",""shareArrow"":""0"",""width"":""35278"",""leftArrow"":""|0"",""scaleWithObject"":""0"",""miterLimit"":""5"",""color"":""RGB255,USER,0,0,0,100,00000000-0000-0000-0000-000000000000"",""leftArrowAttributes"":""0|0|0|0|0|0|0"",""overlapArrow"":""0"",""dashDotSpec"":""4,5,1,1,1"",""dotLength"":""0"",""dashAdjust"":""0"",""aspect"":""100"",""rightArrow"":""|0"",""endCaps"":""0""},""transparency"":{}}"
End Sub


Sub DoCircleER(shpCheck As Shape)
    ' 1.0 pt
    shpCheck.Style.StringAssign "{""fill"":{""type"":""0"",""overprint"":""0"",""winding"":""0""},""outline"":{""type"":""0"",""overprint"":""0"",""angle"":""0"",""screenSpec"":""0,0,45000000,60,0"",""justification"":""0"",""behindFill"":""0"",""rightArrowAttributes"":""0|0|0|0|0|0|0"",""projectMatrix"":""1,0,0,0,1,0"",""matrix"":""1,0,0,0,1,0"",""joinType"":""2"",""shareArrow"":""0"",""width"":""3528"",""leftArrow"":""|0"",""scaleWithObject"":""0"",""miterLimit"":""5"",""color"":""RGB255,USER,0,0,0,100,00000000-0000-0000-0000-000000000000"",""leftArrowAttributes"":""0|0|0|0|0|0|0"",""overlapArrow"":""0"",""dashDotSpec"":""0"",""dotLength"":""0"",""dashAdjust"":""0"",""aspect"":""100"",""rightArrow"":""|0"",""endCaps"":""0""},""transparency"":{}}"
    
    '1.5pt
    'shpCheck.Style.StringAssign "{""fill"":{""type"":""0"",""overprint"":""0"",""winding"":""0""},""outline"":{""type"":""0"",""overprint"":""0"",""angle"":""0"",""screenSpec"":""0,0,45000000,60,0"",""justification"":""0"",""behindFill"":""0"",""rightArrowAttributes"":""0|0|0|0|0|0|0"",""projectMatrix"":""1,0,0,0,1,0"",""matrix"":""1,0,0,0,1,0"",""joinType"":""2"",""shareArrow"":""0"",""width"":""5292"",""leftArrow"":""|0"",""scaleWithObject"":""0"",""miterLimit"":""5"",""color"":""RGB255,USER,0,0,0,100,00000000-0000-0000-0000-000000000000"",""leftArrowAttributes"":""0|0|0|0|0|0|0"",""overlapArrow"":""0"",""dashDotSpec"":""0"",""dotLength"":""0"",""dashAdjust"":""0"",""aspect"":""100"",""rightArrow"":""|0"",""endCaps"":""0""},""transparency"":{}}"
End Sub


Sub DoCircle500(shpCheck As Shape)
    shpCheck.Style.StringAssign "{""fill"":{""type"":""0"",""overprint"":""0"",""winding"":""0""},""outline"":{""type"":""0"",""overprint"":""0"",""angle"":""0"",""screenSpec"":""0,0,45000000,60,0"",""justification"":""0"",""behindFill"":""0"",""rightArrowAttributes"":""0|0|0|0|0|0|0"",""projectMatrix"":""1,0,0,0,1,0"",""matrix"":""1,0,0,0,1,0"",""joinType"":""2"",""shareArrow"":""0"",""width"":""5292"",""leftArrow"":""|0"",""scaleWithObject"":""0"",""miterLimit"":""5"",""color"":""RGB255,USER,0,0,0,100,00000000-0000-0000-0000-000000000000"",""leftArrowAttributes"":""0|0|0|0|0|0|0"",""overlapArrow"":""0"",""dashDotSpec"":""0"",""dotLength"":""0"",""dashAdjust"":""0"",""aspect"":""100"",""rightArrow"":""|0"",""endCaps"":""0""},""transparency"":{}}"
End Sub


Sub DoCircleWell(shpCheck As Shape)
    shpCheck.Fill.UniformColor.CMYKAssign 0, 100, 100, 0
End Sub











