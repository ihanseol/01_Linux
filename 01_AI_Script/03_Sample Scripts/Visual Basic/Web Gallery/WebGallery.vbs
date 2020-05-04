'*************************************************************
' 
' ADOBE SYSTEMS INCORPORATED 
' Copyright 2005-2010 Adobe Systems Incorporated 
' All Rights Reserved 

' NOTICE:  Adobe permits you to use, modify, and 
' distribute this file in accordance with the terms
' of the Adobe license agreement accompanying it.  
' If you have received this file from a source 
' other than Adobe, then your use, modification,
' or distribution of it requires the prior 
' written permission of Adobe. 
' 
'*************************************************************

' WebGallery.vbs

' DESCRIPTION

' This example demonstrates how a gallery can be created from 
' several Illustrator compatible files.
' The script first creates .ai and .pdf files then saves them 
' in a 'WebGallery' folder on the desktop, Illustrator 
' will then scan the WebGallery folder for files 
' and load them into Illustrator. Once in Illustrator the 
' documents are exported to JPEG and HTML format and an HTML file 
' is created which displays the files in a gallery format.
'
'*************************************************************
    Dim objApp
    Dim objExportOptions
    Dim objFileSys
    Dim objFile
    Dim objFiles
    Dim objFolder
    Dim objFolderGall
    Dim objFolderImg
    Dim objFolderPage
    Dim objFolderThumb
    Dim theFiles
    Dim f1 
    Dim myName
    Dim myPath
    Dim htmlFrame
    Dim htmlPage
    Dim htmlIndex
    Dim htmlIndexRow
    Dim htmlIndexRows
    Dim success
    Dim objFolderSamp
    Dim newItem
    Dim itemColor
    Dim pdfSvOpts
    Dim textRef
    
    const DESKTOP = &H0&
	set myShell = CreateObject("Shell.Application")
	set myDesktopFolder = myShell.Namespace(DESKTOP)
	set myDesktopFolderItem = myDesktopFolder.Self
	myDesktopPath = myDesktopFolderItem.Path
    
    Set objApp = CreateObject("Illustrator.Application")
    Set objExportOptions = CreateObject("Illustrator.ExportOptionsJPEG")
    Set objFileSys = CreateObject("Scripting.FileSystemObject")
    Set objFolder = objFileSys.GetFolder(myDesktopPath)
    Set pdfSvOpts = CreateObject("Illustrator.PDFSaveOptions")
    Set aiSvOpts = CreateObject("Illustrator.IllustratorSaveOptions")
    myMsg = "alert(""Creates 3 documents, saves the documents to a folder " & _
    "called \'WebGallery\' on the Desktop, exports each document as jpeg " & _
    "and html then creates the html gallery file - index.html."")"
    objApp.DoJavaScript myMsg
    
    ' check for folders and create if they don't exist
    If (objFileSys.FolderExists(objFolder & "\WebGallery")) Then
        Set objFolderSamp = objFileSys.GetFolder(objFolder & "\WebGallery")
	Else
        Set objFolderSamp = objFolder.SubFolders.Add("WebGallery")
    End If
    
	If (objFileSys.FolderExists(objFolderSamp & "\gallery")) Then
		Set objFolderGall = objFileSys.GetFolder(objFolderSamp & "\gallery")
	Else
		Set objFolderGall = objFolderSamp.SubFolders.Add("gallery")
	End If
	
	If (objFileSys.FolderExists(objFolderGall & "\images")) Then
		Set objFolderImg = objFileSys.GetFolder(objFolderGall & "\images")
	Else
		Set objFolderImg = objFolderGall.SubFolders.Add("images")
	End If

	If (objFileSys.FolderExists(objFolderGall & "\pages")) Then
		Set objFolderPage = objFileSys.GetFolder(objFolderGall & "\pages")
	Else
		Set objFolderPage = objFolderGall.SubFolders.Add("pages")
	End If
	
	If (objFileSys.FolderExists(objFolderGall & "\thumbnails")) Then
		Set objFolderThumb = objFileSys.GetFolder(objFolderGall & "\thumbnails")
	Else
		Set objFolderThumb = objFolderGall.SubFolders.Add("thumbnails")
	End If    
    
    'reserved characters (can't be in filenames processed)
    ' ^ (repeating index rows)
    ' ~ (image number)
    
    'create and save a document with a star in it
    Set docRef = objApp.Documents.Add
    Set newItem = docRef.PathItems.Star(300,400,100,50,5)
    Set itemColor = CreateObject("Illustrator.CMYKColor")
    itemColor.Magenta = 100
    newItem.FillColor = itemColor
    docRef.SaveAs (objFolderSamp & "\star.ai")

    'create and save a document with an ellipse in it
    Set docRef = objApp.Documents.Add
    Set newItem = docRef.PathItems.Ellipse(200,200,200,100)
    Set itemColor = CreateObject("Illustrator.CMYKColor")
    itemColor.Yellow = 100
    newItem.FillColor = itemColor
    docRef.SaveAs (objFolderSamp & "\ellipse.ai")

    'create and save a pdf file with some text
    Set docRef = objApp.Documents.Add
    Set textRef = docRef.TextFrames.Add()
    textRef.Contents = "Here is text from the PDF file."
    textRef.Top = 400
    textRef.Left = 100
    textRef.TextRange.CharacterAttributes.Size = 18
    objApp.Redraw
    pdfSvOpts.AcrobatLayers = true
    docRef.SaveAs objFolderSamp & "\text.pdf",pdfSvOpts

    'standard frameset html
    htmlFrame = ""
    htmlFrame = htmlFrame & "<HTML>" & vbCrLf
    htmlFrame = htmlFrame & "<HEAD>" & vbCrLf
    htmlFrame = htmlFrame & "<TITLE>Web Gallery</TITLE>" & vbCrLf
    htmlFrame = htmlFrame & "<META name=""generator"" content=""Adobe Illustrator Script-Generated Web Gallery"">" & vbCrLf
    htmlFrame = htmlFrame & "<META http-equiv=""Content-Type"" content=""text/html; charset=iso-8859-1"">" & vbCrLf
    htmlFrame = htmlFrame & "</HEAD>" & vbCrLf
    htmlFrame = htmlFrame & "<FRAMESET frameborder=1 cols=""20%,80%"">" & vbCrLf
    htmlFrame = htmlFrame & "<FRAME src=""index.html""  NAME=""LeftFrame""  scrolling=YES>" & vbCrLf
    htmlFrame = htmlFrame & "<FRAME src=""pages/1.html""  name=""RightFrame"" scrolling=YES>" & vbCrLf
    htmlFrame = htmlFrame & "<NOFRAMES>" & vbCrLf
    htmlFrame = htmlFrame & "<BODY>" & vbCrLf
    htmlFrame = htmlFrame & "Viewing this page requires a browser capable of displaying frames." & vbCrLf
    htmlFrame = htmlFrame & "</BODY>" & vbCrLf
    htmlFrame = htmlFrame & "</NOFRAMES>" & vbCrLf
    htmlFrame = htmlFrame & "</FRAMESET>" & vbCrLf
    htmlFrame = htmlFrame & "</HTML>" & vbCrLf
    'write frameset
    Set objFile = objFileSys.CreateTextFile(objFolderGall.Path & "\" & "frameset.html", True, False)
    objFile.Write htmlFrame
    objFile.Close
    
    'standard thumb index html
    htmlIndex = ""
    htmlIndex = htmlIndex & "<HTML>" & vbCrLf
    htmlIndex = htmlIndex & "<HEAD>" & vbCrLf
    htmlIndex = htmlIndex & "<TITLE>Web Gallery</TITLE>" & vbCrLf
    htmlIndex = htmlIndex & "<META name=""generator"" content=""Adobe Illustrator Script-Generated Web Gallery"">" & vbCrLf
    htmlIndex = htmlIndex & "<META http-equiv=""Content-Type"" content=""text/html; charset=iso-8859-1"">" & vbCrLf
    htmlIndex = htmlIndex & "</HEAD>" & vbCrLf
    htmlIndex = htmlIndex & "<BODY bgcolor=""#FFFFFF""  text=""#000000""  link=""#FF0000""  vlink=""#CCCC99""  alink=""#0000FF"" >" & vbCrLf
    htmlIndex = htmlIndex & "Thumbnails with hyperlinks" & vbCrLf
    htmlIndex = htmlIndex & "<P><TABLE border=""0"" cellspacing=""2"" cellpadding=""0"">" & vbCrLf
    htmlIndex = htmlIndex & "^" & vbCrLf
    'repeating row
    htmlIndexRow = ""
    htmlIndexRow = htmlIndexRow & "<TR><TD>" & vbCrLf
    htmlIndexRow = htmlIndexRow & "<P><A href=""pages/~.html"" target=""RightFrame""><IMG src=""thumbnails/~.jpg"" border=""0"" alt=1 align=""BOTTOM""></A><BR><BR>" & vbCrLf
    htmlIndexRow = htmlIndexRow & "<A href=""pages/~.html"" target=""RightFrame""><FONT size=""2""  face=""Arial"" >~.jpg</FONT></A><FONT size=""2""  face=""Arial"" ></FONT><BR><BR>" & vbCrLf
    htmlIndexRow = htmlIndexRow & "</TD></TR>" & vbCrLf
    '
    htmlIndex = htmlIndex & "</TABLE>" & vbCrLf
    htmlIndex = htmlIndex & "</BODY>" & vbCrLf
    htmlIndex = htmlIndex & "</HTML>" & vbCrLf
    'clear running string for final insertion
    htmlIndexRows = ""
    
    'standard image page html
    htmlPage = ""
    htmlPage = htmlPage & "</HTML>" & vbCrLf
    htmlPage = htmlPage & "<HTML>" & vbCrLf
    htmlPage = htmlPage & "<HEAD>" & vbCrLf
    htmlPage = htmlPage & "<TITLE>~</TITLE>" & vbCrLf
    htmlPage = htmlPage & "<META name=""generator"" content=""Adobe Illustrator Script-Generated Web Gallery"">" & vbCrLf
    htmlPage = htmlPage & "<META http-equiv=""Content-Type"" content=""text/html; charset=iso-8859-1"">" & vbCrLf
    htmlPage = htmlPage & "</HEAD>" & vbCrLf
    htmlPage = htmlPage & "<BODY bgcolor=""#FFFFFF""  text=""#000000""  link=""#FF0000""  vlink=""#CCCC99""  alink=""#0000FF"" >" & vbCrLf
    htmlPage = htmlPage & "<TABLE border=""0"" cellpadding=""5"" cellspacing=""2"" width=""100%"" bgcolor=""#F0F0F0"" >" & vbCrLf
    htmlPage = htmlPage & "<TR>" & vbCrLf
    htmlPage = htmlPage & "<TD><FONT size=""2"" face=""Arial"" >Web Gallery / ~<BR><BR>" & Date & "</FONT>" & vbCrLf
    htmlPage = htmlPage & "</TD>" & vbCrLf
    htmlPage = htmlPage & "</TR>" & vbCrLf
    htmlPage = htmlPage & "</TABLE>" & vbCrLf
    htmlPage = htmlPage & "<P><CENTER><IMG src=""../images/~.jpg""  border=""0"" alt=1></CENTER></P>" & vbCrLf
    htmlPage = htmlPage & "</BODY>" & vbCrLf
    
    'loop thru all files that Illustrator can open
        Set theFiles = objFolderSamp.Files
        Dim i
        i = 0
        For Each f1 In theFiles
        i = i + 1
            myPath = f1.Path
            'open document in illustrator
            objApp.Open (myPath)
            
            If objApp.Documents.Count > 0 Then
                objExportOptions.HorizontalScale = 20
                objExportOptions.VerticalScale = 20
                objApp.Documents(1).Export objFolderThumb.Path & "\" & i & ".jpg", 1, objExportOptions
                objExportOptions.HorizontalScale = 75
                objExportOptions.VerticalScale = 75
                objApp.Documents(1).Export objFolderImg.Path & "\" & i & ".jpg", 1, objExportOptions
                objApp.Documents(1).Close (2) 'aiDoNotSaveChanges
                htmlIndexRows = htmlIndexRows & Replace(htmlIndexRow, "~", i)
                'and creating a page html file
                Set objFile = objFileSys.CreateTextFile(objFolderPage.Path & "\" & i & ".html", True, False)
                objFile.Write Replace(htmlPage, "~", i)
                objFile.Close
            End If
        Next
    
        'save thumbnail index
        htmlIndex = Replace(htmlIndex, "^", htmlIndexRows)
        Set objFile = objFileSys.CreateTextFile(objFolderGall.Path & "\" & "index.html", True, False)
        objFile.Write Replace(htmlIndex, "~", i)
        objFile.Close
'' SIG '' Begin signature block
'' SIG '' MIIeWgYJKoZIhvcNAQcCoIIeSzCCHkcCAQExDzANBglg
'' SIG '' hkgBZQMEAgEFADB3BgorBgEEAYI3AgEEoGkwZzAyBgor
'' SIG '' BgEEAYI3AgEeMCQCAQEEEE7wKRaZJ7VNj+Ws4Q8X66sC
'' SIG '' AQACAQACAQACAQACAQAwMTANBglghkgBZQMEAgEFAAQg
'' SIG '' st6g3LVEPHXk1y9pR4SiL2/Qffgk2tyRiwRlC7X67Jug
'' SIG '' ggyUMIIF0DCCBLigAwIBAgIQB3XcWt35KITbGdVVTAfs
'' SIG '' STANBgkqhkiG9w0BAQsFADBsMQswCQYDVQQGEwJVUzEV
'' SIG '' MBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3
'' SIG '' d3cuZGlnaWNlcnQuY29tMSswKQYDVQQDEyJEaWdpQ2Vy
'' SIG '' dCBFViBDb2RlIFNpZ25pbmcgQ0EgKFNIQTIpMB4XDTE5
'' SIG '' MDEzMTAwMDAwMFoXDTIxMDIwMzEyMDAwMFowgeYxEzAR
'' SIG '' BgsrBgEEAYI3PAIBAxMCVVMxGTAXBgsrBgEEAYI3PAIB
'' SIG '' AhMIRGVsYXdhcmUxHTAbBgNVBA8MFFByaXZhdGUgT3Jn
'' SIG '' YW5pemF0aW9uMRAwDgYDVQQFEwcyNzQ4MTI5MQswCQYD
'' SIG '' VQQGEwJVUzELMAkGA1UECBMCY2ExETAPBgNVBAcTCFNh
'' SIG '' biBKb3NlMRMwEQYDVQQKEwpBZG9iZSBJbmMuMSwwKgYD
'' SIG '' VQQLEyNJbGx1c3RyYXRvciwgSW5EZXNpZ24sIEluQ29w
'' SIG '' eSwgTXVzZTETMBEGA1UEAxMKQWRvYmUgSW5jLjCCASIw
'' SIG '' DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAIiKXEE3
'' SIG '' 5FJAWPRPxAu4g1GRRZmzrPW3SZL40s8opqkFWksx2dBE
'' SIG '' yP6+N6visRXUyDy+I979oO9tEtHBeYKx1XHy4NOLPl3u
'' SIG '' Lr8rWv5E3hrNw+QRwJvsMJLzBTS44811Rym8ddkt8lpj
'' SIG '' dG1PmC2aZQ73miR88+46IaZDtuabo3corXvrG0wmLFZb
'' SIG '' SrB80HAigwQiwHgh33cI2pPIYA2VdmEv5V3iI+AuYybL
'' SIG '' BPJ32YPqdvcoR3Ml/oYFcFlUb1sliNdngwqEeUTKBWVu
'' SIG '' OTeuRo2gOioizpUxR3cce25eoH8wONWUozkjPwcUEY8I
'' SIG '' RCePRf21c4kjjLGFSmpwEVQVQJcCAwEAAaOCAfEwggHt
'' SIG '' MB8GA1UdIwQYMBaAFI/ofvBtMmoABSPHcJdqOpD/a+rU
'' SIG '' MB0GA1UdDgQWBBSVoz2+cIajBhNjiGb0VJBYxDX9vzAu
'' SIG '' BgNVHREEJzAloCMGCCsGAQUFBwgDoBcwFQwTVVMtREVM
'' SIG '' QVdBUkUtMjc0ODEyOTAOBgNVHQ8BAf8EBAMCB4AwEwYD
'' SIG '' VR0lBAwwCgYIKwYBBQUHAwMwewYDVR0fBHQwcjA3oDWg
'' SIG '' M4YxaHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0VWQ29k
'' SIG '' ZVNpZ25pbmdTSEEyLWcxLmNybDA3oDWgM4YxaHR0cDov
'' SIG '' L2NybDQuZGlnaWNlcnQuY29tL0VWQ29kZVNpZ25pbmdT
'' SIG '' SEEyLWcxLmNybDBLBgNVHSAERDBCMDcGCWCGSAGG/WwD
'' SIG '' AjAqMCgGCCsGAQUFBwIBFhxodHRwczovL3d3dy5kaWdp
'' SIG '' Y2VydC5jb20vQ1BTMAcGBWeBDAEDMH4GCCsGAQUFBwEB
'' SIG '' BHIwcDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGln
'' SIG '' aWNlcnQuY29tMEgGCCsGAQUFBzAChjxodHRwOi8vY2Fj
'' SIG '' ZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRFVkNvZGVT
'' SIG '' aWduaW5nQ0EtU0hBMi5jcnQwDAYDVR0TAQH/BAIwADAN
'' SIG '' BgkqhkiG9w0BAQsFAAOCAQEADtCQA7go0Xu2UKN6dFPe
'' SIG '' YJbS/OXx3n3IP0K9CGPDozeGV62MvbCp+DuptFa44FYR
'' SIG '' ZuljRXMxCjsjJmkJLD9Hhuik+a23iSwfOAnWK6AY/VoD
'' SIG '' ZatWvGG6mZzMRs/s5Whztt8IRxLMrLbA+ulDkDKTlqqf
'' SIG '' BWN8xAM23VX2IMmPYFXMf1TgyT3rCr2oontG6eWT0VYa
'' SIG '' j8DrYJuWtoNQaHIxSg3lGWyvqi1RwJc7GjVwJObnRCTH
'' SIG '' Faqmfxwry/5jEDjPNNUyDiMWIr2xxCbe5pu759mb9Hjl
'' SIG '' rSakmU9AhIxEURqKA3wmnF9Sw+OnazRGp4bvfkCeWDtK
'' SIG '' LdN4JKj5eh21hDCCBrwwggWkoAMCAQICEAPxtOFfOoLx
'' SIG '' FJZ4s9fYR1wwDQYJKoZIhvcNAQELBQAwbDELMAkGA1UE
'' SIG '' BhMCVVMxFTATBgNVBAoTDERpZ2lDZXJ0IEluYzEZMBcG
'' SIG '' A1UECxMQd3d3LmRpZ2ljZXJ0LmNvbTErMCkGA1UEAxMi
'' SIG '' RGlnaUNlcnQgSGlnaCBBc3N1cmFuY2UgRVYgUm9vdCBD
'' SIG '' QTAeFw0xMjA0MTgxMjAwMDBaFw0yNzA0MTgxMjAwMDBa
'' SIG '' MGwxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2Vy
'' SIG '' dCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20x
'' SIG '' KzApBgNVBAMTIkRpZ2lDZXJ0IEVWIENvZGUgU2lnbmlu
'' SIG '' ZyBDQSAoU0hBMikwggEiMA0GCSqGSIb3DQEBAQUAA4IB
'' SIG '' DwAwggEKAoIBAQCnU/oPsrUT8WTPhID8roA10bbXx6Ms
'' SIG '' rBosrPGErDo1EjqSkbpX5MTJ8y+oSDy31m7clyK6UXlh
'' SIG '' r0MvDbebtEkxrkRYPqShlqeHTyN+w2xlJJBVPqHKI3zF
'' SIG '' QunEemJFm33eY3TLnmMl+ISamq1FT659H8gTy3WbyeHh
'' SIG '' ivgLDJj0yj7QRap6HqVYkzY0visuKzFYZrQyEJ+d8FKh
'' SIG '' 7+g+03byQFrc+mo9G0utdrCMXO42uoPqMKhM3vELKlhB
'' SIG '' iK4AiasD0RaCICJ2615UOBJi4dJwJNvtH3DSZAmALeK2
'' SIG '' nc4f8rsh82zb2LMZe4pQn+/sNgpcmrdK0wigOXn93b89
'' SIG '' OgklAgMBAAGjggNYMIIDVDASBgNVHRMBAf8ECDAGAQH/
'' SIG '' AgEAMA4GA1UdDwEB/wQEAwIBhjATBgNVHSUEDDAKBggr
'' SIG '' BgEFBQcDAzB/BggrBgEFBQcBAQRzMHEwJAYIKwYBBQUH
'' SIG '' MAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBJBggr
'' SIG '' BgEFBQcwAoY9aHR0cDovL2NhY2VydHMuZGlnaWNlcnQu
'' SIG '' Y29tL0RpZ2lDZXJ0SGlnaEFzc3VyYW5jZUVWUm9vdENB
'' SIG '' LmNydDCBjwYDVR0fBIGHMIGEMECgPqA8hjpodHRwOi8v
'' SIG '' Y3JsMy5kaWdpY2VydC5jb20vRGlnaUNlcnRIaWdoQXNz
'' SIG '' dXJhbmNlRVZSb290Q0EuY3JsMECgPqA8hjpodHRwOi8v
'' SIG '' Y3JsNC5kaWdpY2VydC5jb20vRGlnaUNlcnRIaWdoQXNz
'' SIG '' dXJhbmNlRVZSb290Q0EuY3JsMIIBxAYDVR0gBIIBuzCC
'' SIG '' AbcwggGzBglghkgBhv1sAwIwggGkMDoGCCsGAQUFBwIB
'' SIG '' Fi5odHRwOi8vd3d3LmRpZ2ljZXJ0LmNvbS9zc2wtY3Bz
'' SIG '' LXJlcG9zaXRvcnkuaHRtMIIBZAYIKwYBBQUHAgIwggFW
'' SIG '' HoIBUgBBAG4AeQAgAHUAcwBlACAAbwBmACAAdABoAGkA
'' SIG '' cwAgAEMAZQByAHQAaQBmAGkAYwBhAHQAZQAgAGMAbwBu
'' SIG '' AHMAdABpAHQAdQB0AGUAcwAgAGEAYwBjAGUAcAB0AGEA
'' SIG '' bgBjAGUAIABvAGYAIAB0AGgAZQAgAEQAaQBnAGkAQwBl
'' SIG '' AHIAdAAgAEMAUAAvAEMAUABTACAAYQBuAGQAIAB0AGgA
'' SIG '' ZQAgAFIAZQBsAHkAaQBuAGcAIABQAGEAcgB0AHkAIABB
'' SIG '' AGcAcgBlAGUAbQBlAG4AdAAgAHcAaABpAGMAaAAgAGwA
'' SIG '' aQBtAGkAdAAgAGwAaQBhAGIAaQBsAGkAdAB5ACAAYQBu
'' SIG '' AGQAIABhAHIAZQAgAGkAbgBjAG8AcgBwAG8AcgBhAHQA
'' SIG '' ZQBkACAAaABlAHIAZQBpAG4AIABiAHkAIAByAGUAZgBl
'' SIG '' AHIAZQBuAGMAZQAuMB0GA1UdDgQWBBSP6H7wbTJqAAUj
'' SIG '' x3CXajqQ/2vq1DAfBgNVHSMEGDAWgBSxPsNpA/i/RwHU
'' SIG '' mCYaCALvY2QrwzANBgkqhkiG9w0BAQsFAAOCAQEAGTNK
'' SIG '' DIEzN9utNsnkyTq7tRsueqLi9ENCF56/TqFN4bHb6YHd
'' SIG '' nwHy5IjV6f4J/SHB7F2A0vDWwUPC/ncr2/nXkTPObNWy
'' SIG '' GTvmLtbJk0+IQI7N4fV+8Q/GWVZy6OtqQb0c1UbVfEnK
'' SIG '' ZjgVwb/gkXB3h9zJjTHJDCmiM+2N4ofNiY0/G//V4BqX
'' SIG '' i3zabfuoxrI6Zmt7AbPN2KY07BIBq5VYpcRTV6hg5ucC
'' SIG '' EqC5I2SiTbt8gSVkIb7P7kIYQ5e7pTcGr03/JqVNYUvs
'' SIG '' RkG4Zc64eZ4IlguBjIo7j8eZjKMqbphtXmHGlreKuWEt
'' SIG '' k7jrDgRD1/X+pvBi1JlqpcHB8GSUgDGCER4wghEaAgEB
'' SIG '' MIGAMGwxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdp
'' SIG '' Q2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5j
'' SIG '' b20xKzApBgNVBAMTIkRpZ2lDZXJ0IEVWIENvZGUgU2ln
'' SIG '' bmluZyBDQSAoU0hBMikCEAd13Frd+SiE2xnVVUwH7Ekw
'' SIG '' DQYJYIZIAWUDBAIBBQCggaIwGQYJKoZIhvcNAQkDMQwG
'' SIG '' CisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEOMAwGCisG
'' SIG '' AQQBgjcCARUwLwYJKoZIhvcNAQkEMSIEIKIU+KmqhVe0
'' SIG '' MH9ia2HqdwWO3WpKFuj4acAa7i4sct8sMDYGCisGAQQB
'' SIG '' gjcCAQwxKDAmoCSAIgBBAGQAbwBiAGUAIABJAGwAbAB1
'' SIG '' AHMAdAByAGEAdABvAHIwDQYJKoZIhvcNAQEBBQAEggEA
'' SIG '' cj5aCyy8c3GP+OGxc2YoWztG6WF4WXEbz4+hsTRt9ODm
'' SIG '' 4oERp2PCAaMp7UYji7rNkp8GQHkmvjafI2/RQd3t8vOi
'' SIG '' ZEo+hokyw+5WANXVwUnJQQ0V8zO6OLxvZSyesTyo2j/N
'' SIG '' 7DT3K6orITMVYICky7orEoiF/aPTEDHiAurXwJji058v
'' SIG '' Cx6McUcRHmACrdvjIuulzVqfSnoCts/GKLrf8mADkKft
'' SIG '' sWEMUVSlfCiQCx1hViLcjr0wd5zS3EUGcYv6MDsNjHyq
'' SIG '' cz7REFaLJIH5lvZmusRhjTGQzAqggab5aph5xHl+e2Cp
'' SIG '' ZlzZdAznBELOU+nywL1/z+doSGajJHpBraGCDskwgg7F
'' SIG '' BgorBgEEAYI3AwMBMYIOtTCCDrEGCSqGSIb3DQEHAqCC
'' SIG '' DqIwgg6eAgEDMQ8wDQYJYIZIAWUDBAIBBQAweAYLKoZI
'' SIG '' hvcNAQkQAQSgaQRnMGUCAQEGCWCGSAGG/WwHATAxMA0G
'' SIG '' CWCGSAFlAwQCAQUABCDEtDfMKtX9tooFv21MyPIWzdeC
'' SIG '' h+jLdcCOe9fAujas3gIRALwq/dc7vFDSpumzJymld7MY
'' SIG '' DzIwMjAwNDA2MjAyMjM0WqCCC7swggaCMIIFaqADAgEC
'' SIG '' AhAEzT+FaK52xhuw/nFgzKdtMA0GCSqGSIb3DQEBCwUA
'' SIG '' MHIxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2Vy
'' SIG '' dCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20x
'' SIG '' MTAvBgNVBAMTKERpZ2lDZXJ0IFNIQTIgQXNzdXJlZCBJ
'' SIG '' RCBUaW1lc3RhbXBpbmcgQ0EwHhcNMTkxMDAxMDAwMDAw
'' SIG '' WhcNMzAxMDE3MDAwMDAwWjBMMQswCQYDVQQGEwJVUzEX
'' SIG '' MBUGA1UEChMORGlnaUNlcnQsIEluYy4xJDAiBgNVBAMT
'' SIG '' G1RJTUVTVEFNUC1TSEEyNTYtMjAxOS0xMC0xNTCCASIw
'' SIG '' DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAOlkNZz6
'' SIG '' qZhlZBvkF9y4KTbMZwlYhU0w4Mn/5Ts8EShQrwcx4l0J
'' SIG '' GML2iYxpCAQj4HctnRXluOihao7/1K7Sehbv+EG1HTl1
'' SIG '' wc8vp6xFfpRtrAMBmTxiPn56/UWXMbT6t9lCPqdVm99a
'' SIG '' T1gCqDJpIhO+i4Itxpira5u0yfJlEQx0DbLwCJZ0xOiy
'' SIG '' SKKhFKX4+uGJcEQ7je/7pPTDub0ULOsMKCclgKsQSxYS
'' SIG '' YAtpIoxOzcbVsmVZIeB8LBKNcA6Pisrg09ezOXdQ0EIs
'' SIG '' LnrOnGd6OHdUQP9PlQQg1OvIzocUCP4dgN3Q5yt46r8f
'' SIG '' cMbuQhZTNkWbUxlJYp16ApuVFKMCAwEAAaOCAzgwggM0
'' SIG '' MA4GA1UdDwEB/wQEAwIHgDAMBgNVHRMBAf8EAjAAMBYG
'' SIG '' A1UdJQEB/wQMMAoGCCsGAQUFBwMIMIIBvwYDVR0gBIIB
'' SIG '' tjCCAbIwggGhBglghkgBhv1sBwEwggGSMCgGCCsGAQUF
'' SIG '' BwIBFhxodHRwczovL3d3dy5kaWdpY2VydC5jb20vQ1BT
'' SIG '' MIIBZAYIKwYBBQUHAgIwggFWHoIBUgBBAG4AeQAgAHUA
'' SIG '' cwBlACAAbwBmACAAdABoAGkAcwAgAEMAZQByAHQAaQBm
'' SIG '' AGkAYwBhAHQAZQAgAGMAbwBuAHMAdABpAHQAdQB0AGUA
'' SIG '' cwAgAGEAYwBjAGUAcAB0AGEAbgBjAGUAIABvAGYAIAB0
'' SIG '' AGgAZQAgAEQAaQBnAGkAQwBlAHIAdAAgAEMAUAAvAEMA
'' SIG '' UABTACAAYQBuAGQAIAB0AGgAZQAgAFIAZQBsAHkAaQBu
'' SIG '' AGcAIABQAGEAcgB0AHkAIABBAGcAcgBlAGUAbQBlAG4A
'' SIG '' dAAgAHcAaABpAGMAaAAgAGwAaQBtAGkAdAAgAGwAaQBh
'' SIG '' AGIAaQBsAGkAdAB5ACAAYQBuAGQAIABhAHIAZQAgAGkA
'' SIG '' bgBjAG8AcgBwAG8AcgBhAHQAZQBkACAAaABlAHIAZQBp
'' SIG '' AG4AIABiAHkAIAByAGUAZgBlAHIAZQBuAGMAZQAuMAsG
'' SIG '' CWCGSAGG/WwDFTAfBgNVHSMEGDAWgBT0tuEgHf4prtLk
'' SIG '' YaWyoiWyyBc1bjAdBgNVHQ4EFgQUVlMPwcYHp03X2G5X
'' SIG '' coBQTOTsnsEwcQYDVR0fBGowaDAyoDCgLoYsaHR0cDov
'' SIG '' L2NybDMuZGlnaWNlcnQuY29tL3NoYTItYXNzdXJlZC10
'' SIG '' cy5jcmwwMqAwoC6GLGh0dHA6Ly9jcmw0LmRpZ2ljZXJ0
'' SIG '' LmNvbS9zaGEyLWFzc3VyZWQtdHMuY3JsMIGFBggrBgEF
'' SIG '' BQcBAQR5MHcwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3Nw
'' SIG '' LmRpZ2ljZXJ0LmNvbTBPBggrBgEFBQcwAoZDaHR0cDov
'' SIG '' L2NhY2VydHMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0U0hB
'' SIG '' MkFzc3VyZWRJRFRpbWVzdGFtcGluZ0NBLmNydDANBgkq
'' SIG '' hkiG9w0BAQsFAAOCAQEALoOhRAVKBOO5MlL62YHwGrv4
'' SIG '' CY0juT3YkqHmRhxKL256PGNuNxejGr9YI7JDnJSDTjkJ
'' SIG '' sCzox+HizO3LeWvO3iMBR+2VVIHggHsSsa8Chqk6c2r+
'' SIG '' +J/BjdEhjOQpgsOKC2AAAp0fR8SftApoU39aEKb4Iub4
'' SIG '' U5IxX9iCgy1tE0Kug8EQTqQk9Eec3g8icndcf0/pOZgr
'' SIG '' V5JE1+9uk9lDxwQzY1E3Vp5HBBHDo1hUIdjijlbXST9X
'' SIG '' /AqfI1579JSN3Z0au996KqbSRaZVDI/2TIryls+JRtwx
'' SIG '' spGQo18zMGBV9fxrMKyh7eRHTjOeZ2ootU3C7VuXgvjL
'' SIG '' qQhsUwm09zCCBTEwggQZoAMCAQICEAqhJdbWMht+QeQF
'' SIG '' 2jaXwhUwDQYJKoZIhvcNAQELBQAwZTELMAkGA1UEBhMC
'' SIG '' VVMxFTATBgNVBAoTDERpZ2lDZXJ0IEluYzEZMBcGA1UE
'' SIG '' CxMQd3d3LmRpZ2ljZXJ0LmNvbTEkMCIGA1UEAxMbRGln
'' SIG '' aUNlcnQgQXNzdXJlZCBJRCBSb290IENBMB4XDTE2MDEw
'' SIG '' NzEyMDAwMFoXDTMxMDEwNzEyMDAwMFowcjELMAkGA1UE
'' SIG '' BhMCVVMxFTATBgNVBAoTDERpZ2lDZXJ0IEluYzEZMBcG
'' SIG '' A1UECxMQd3d3LmRpZ2ljZXJ0LmNvbTExMC8GA1UEAxMo
'' SIG '' RGlnaUNlcnQgU0hBMiBBc3N1cmVkIElEIFRpbWVzdGFt
'' SIG '' cGluZyBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
'' SIG '' AQoCggEBAL3QMu5LzY9/3am6gpnFOVQoV7YjSsQOB0Uz
'' SIG '' URB90Pl9TWh+57ag9I2ziOSXv2MhkJi/E7xX08PhfgjW
'' SIG '' ahQAOPcuHjvuzKb2Mln+X2U/4Jvr40ZHBhpVfgsnfsCi
'' SIG '' 9aDg3iI/Dv9+lfvzo7oiPhisEeTwmQNtO4V8CdPuXcia
'' SIG '' C1TjqAlxa+DPIhAPdc9xck4Krd9AOly3UeGheRTGTSQj
'' SIG '' MF287DxgaqwvB8z98OpH2YhQXv1mblZhJymJhFHmgudG
'' SIG '' UP2UKiyn5HU+upgPhH+fMRTWrdXyZMt7HgXQhBlyF/EX
'' SIG '' Bu89zdZN7wZC/aJTKk+FHcQdPK/P2qwQ9d2srOlW/5MC
'' SIG '' AwEAAaOCAc4wggHKMB0GA1UdDgQWBBT0tuEgHf4prtLk
'' SIG '' YaWyoiWyyBc1bjAfBgNVHSMEGDAWgBRF66Kv9JLLgjEt
'' SIG '' UYunpyGd823IDzASBgNVHRMBAf8ECDAGAQH/AgEAMA4G
'' SIG '' A1UdDwEB/wQEAwIBhjATBgNVHSUEDDAKBggrBgEFBQcD
'' SIG '' CDB5BggrBgEFBQcBAQRtMGswJAYIKwYBBQUHMAGGGGh0
'' SIG '' dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBDBggrBgEFBQcw
'' SIG '' AoY3aHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL0Rp
'' SIG '' Z2lDZXJ0QXNzdXJlZElEUm9vdENBLmNydDCBgQYDVR0f
'' SIG '' BHoweDA6oDigNoY0aHR0cDovL2NybDQuZGlnaWNlcnQu
'' SIG '' Y29tL0RpZ2lDZXJ0QXNzdXJlZElEUm9vdENBLmNybDA6
'' SIG '' oDigNoY0aHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0Rp
'' SIG '' Z2lDZXJ0QXNzdXJlZElEUm9vdENBLmNybDBQBgNVHSAE
'' SIG '' STBHMDgGCmCGSAGG/WwAAgQwKjAoBggrBgEFBQcCARYc
'' SIG '' aHR0cHM6Ly93d3cuZGlnaWNlcnQuY29tL0NQUzALBglg
'' SIG '' hkgBhv1sBwEwDQYJKoZIhvcNAQELBQADggEBAHGVEulR
'' SIG '' h1Zpze/d2nyqY3qzeM8GN0CE70uEv8rPAwL9xafDDiBC
'' SIG '' LK938ysfDCFaKrcFNB1qrpn4J6JmvwmqYN92pDqTD/iy
'' SIG '' 0dh8GWLoXoIlHsS6HHssIeLWWywUNUMEaLLbdQLgcseY
'' SIG '' 1jxk5R9IEBhfiThhTWJGJIdjjJFSLK8pieV4H9YLFKWA
'' SIG '' 1xJHcLN11ZOFk362kmf7U2GJqPVrlsD0WGkNfMgBsbko
'' SIG '' dbeZY4UijGHKeZR+WfyMD+NvtQEmtmyl7odRIeRYYJu6
'' SIG '' DC0rbaLEfrvEJStHAgh8Sa4TtuF8QkIoxhhWz0E0tmZd
'' SIG '' tnR79VYzIi8iNrJLokqV2PWmjlIxggJNMIICSQIBATCB
'' SIG '' hjByMQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNl
'' SIG '' cnQgSW5jMRkwFwYDVQQLExB3d3cuZGlnaWNlcnQuY29t
'' SIG '' MTEwLwYDVQQDEyhEaWdpQ2VydCBTSEEyIEFzc3VyZWQg
'' SIG '' SUQgVGltZXN0YW1waW5nIENBAhAEzT+FaK52xhuw/nFg
'' SIG '' zKdtMA0GCWCGSAFlAwQCAQUAoIGYMBoGCSqGSIb3DQEJ
'' SIG '' AzENBgsqhkiG9w0BCRABBDAcBgkqhkiG9w0BCQUxDxcN
'' SIG '' MjAwNDA2MjAyMjM0WjArBgsqhkiG9w0BCRACDDEcMBow
'' SIG '' GDAWBBQDJb1QXtqWMC3CL0+gHkwovig0xTAvBgkqhkiG
'' SIG '' 9w0BCQQxIgQgaXNrZOz+5R9z9QzzjltBwdr/BbScTLtB
'' SIG '' Noe/xWJO3AEwDQYJKoZIhvcNAQEBBQAEggEA4BOuxybk
'' SIG '' rctqz2slwnp/VnBUru+0dKTaKhWaM1qgD0d1lZdhGQfY
'' SIG '' KE/u79bcBCZIlhjqE+ghkhRSvoNkETjBAY9WVfT0h6dW
'' SIG '' Lij7koPlvC04YGlj3+/R1YfZQkqJRRjoLe2GCJz9psQ9
'' SIG '' V0Cauo4hdcg6ka8TrPGl+zyTH0pXiJkdTokA29qX+wip
'' SIG '' ZJEAT2mKugaXGy5mUueYqdcOQHU7qo/KMCNDfjSjW6cG
'' SIG '' 4+KxT5kqHQ4hR4DXNwGYh070YuK8QY9NxJLhqhPRxw7r
'' SIG '' WmKL6oOkw7exnrg5p2l+YxOSw+hpomVmD0hy0OC3INa2
'' SIG '' fqVU80mp2oWPWaRmbfh4O2hWUg==
'' SIG '' End signature block
