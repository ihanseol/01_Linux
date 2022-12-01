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

