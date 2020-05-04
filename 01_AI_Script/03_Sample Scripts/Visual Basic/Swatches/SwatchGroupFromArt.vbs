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

' SwatchGroupFromArt.vbs

' DESCRIPTION

' Create a new swatch group using colors in selected path item art.

' ************************************************************

Set appRef = CreateObject("Illustrator.Application")

' Check there is at least 1 document open
If appRef.Documents.Count > 0  Then
	Set docRef = appRef.ActiveDocument
	
	' Check there is a selection in the document
	If Not IsEmpty(appRef.Selection)  Then		
		' Add a new swatch group if it does not already exist
		Set swatchGroup = docRef.SwatchGroups(1)
		swatchGroupExists = false
		For Each swatchGroupRef In docRef.SwatchGroups	
			If swatchGroupRef.Name = "SwatchGroupFromArt" Then
				Set swatchGroup = swatchGroupRef
				swatchGroupExists = true
				Exit For	
			End If		
		Next
	
		If Not swatchGroupExists Then
			' Create new swatch group
			Set swatchGroup = docRef.SwatchGroups.Add
			swatchGroup.Name = "SwatchGroupFromArt"
		End If
		
		' Iterate through selected items		
		IterateSelection(appRef.Selection)
	Else
		' Must use JavaScript to display an alert
		appRef.DoJavaScript("alert(""Select some path art with colors applied before running this script"");")
	End If

Else
	' Must use JavaScript to display an alert
	appRef.DoJavaScript("alert(""Open a document containing some colored path art before running this script"");")
End If

Sub IterateSelection(selectedItems)
	' Get the fill color of each selected item
	For Each pathRef In selectedItems
	
		' Iterate path items within group items
		If TypeName(pathRef) = "GroupItem" Then
			IterateSelection(pathRef.PathItems)		
		ElseIf TypeName(pathRef) = "PathItem" Then
			' Do not continue if fill color is a gradient or a pattern
			If TypeName(pathRef.FillColor) <> "GradientColor" And TypeName(pathRef.FillColor) <> "PatternColor" Then
				' Iterate through existing swatches, checking if the color already exists in a swatch
				swatchExists = false
				For Each swatchRef In docRef.Swatches
					Set currentSwatchColor = swatchRef.Color
					If ColorEquals(pathRef.FillColor, currentSwatchColor) Then
						' Add the existing swatch to the swatch group
						swatchGroup.AddSwatch(swatchRef)
						swatchExists = true
						Exit For
					End If
				Next
				If swatchExists = false Then
					' Create a new swatch in the swatch group
					Set newSwatch = docRef.Swatches.Add
					newSwatch.Color = pathRef.FillColor
					swatchGroup.AddSwatch(newSwatch)
				End If
			End If
		End If
	Next
End Sub

Function ColorEquals(fillColor, swatchColor)
	ColorEquals = false					
	' Compare colors
	If TypeName(fillColor) = TypeName(swatchColor) Then
		Select Case TypeName(swatchColor)
			Case "CMYKColor"
				ColorEquals = CMYKColorEquals(fillColor, swatchColor)
			Case "RGBColor"
				ColorEquals= RGBColorEquals(fillColor, swatchColor)
			Case "GrayColor"
				ColorEquals = GrayColorEquals(fillColor, swatchColor)
			Case "LabColor"
				ColorEquals = LabColorEquals(fillColor, swatchColor)
			Case "SpotColor"
				ColorEquals = SpotColorEquals(fillColor, swatchColor)
			Case "NoColor"
			Case "PatternColor"
			Case "GradientColor"
			Case Else
		End Select
	End If
End Function

Function CMYKColorEquals(fillColor, swatchColor)
	CMYKColorEquals = false
	If fillColor.Cyan = swatchColor.Cyan And fillColor.Magenta = swatchColor.Magenta And fillColor.Yellow = swatchColor.Yellow And fillColor.Black = swatchColor.Black Then
		CMYKColorEquals = true
	End If
End Function

Function RGBColorEquals(fillColor, swatchColor)
	RGBColorEquals = false
	If fillColor.Red = swatchColor.Red And fillColor.Green = swatchColor.Green And fillColor.Blue = swatchColor.Blue Then
		RGBColorEquals = true
	End If
End Function

Function GrayColorEquals(fillColor, swatchColor)
	GrayColorEquals = false
	If fillColor.Gray = swatchColor.Gray Then
		GrayColorEquals = true
	End If
End Function

Function LabColorEquals(fillColor, swatchColor)
	LabColorEquals = false
	If fillColor.L = swatchColor.L And fillColor.A = swatchColor.A And fillColor.B = swatchColor.B Then
		LabColorEquals = true
	End If
End Function

Function SpotColorEquals(fillColor, swatchColor)
	SpotColorEquals = false
	Select Case TypeName(swatchColor.Spot.Color)
		Case "CMYKColor"
			SpotColorEquals = CMYKColorEquals(fillColor.Spot.Color, swatchColor.Spot.Color)
		Case "RGBColor"
			SpotColorEquals = RGBColorEquals(fillColor.Spot.Color, swatchColor.Spot.Color)
		Case "GrayColor"
			SpotColorEquals = GrayColorEquals(fillColor.Spot.Color, swatchColor.Spot.Color)
		Case "LabColor"
			SpotColorEquals = LabColorEquals(fillColor.Spot.Color, swatchColor.Spot.Color)
		Case Else
	End Select
End Function
'' SIG '' Begin signature block
'' SIG '' MIIeWgYJKoZIhvcNAQcCoIIeSzCCHkcCAQExDzANBglg
'' SIG '' hkgBZQMEAgEFADB3BgorBgEEAYI3AgEEoGkwZzAyBgor
'' SIG '' BgEEAYI3AgEeMCQCAQEEEE7wKRaZJ7VNj+Ws4Q8X66sC
'' SIG '' AQACAQACAQACAQACAQAwMTANBglghkgBZQMEAgEFAAQg
'' SIG '' J6r+QgWyN6qtS9fsJgoumnSdBpusjX5+z5zHJgB5JDag
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
'' SIG '' AQQBgjcCARUwLwYJKoZIhvcNAQkEMSIEIBDjtqqWFrhB
'' SIG '' ME3bXAhjsXHVYuuIIvD1SEr4+3Nyx441MDYGCisGAQQB
'' SIG '' gjcCAQwxKDAmoCSAIgBBAGQAbwBiAGUAIABJAGwAbAB1
'' SIG '' AHMAdAByAGEAdABvAHIwDQYJKoZIhvcNAQEBBQAEggEA
'' SIG '' eLs12qKJpuPUwOU/KcFcEckVg0fI4662FI2ufvg/rqdd
'' SIG '' mpJse/PQdino0h7Z7V+EEaYnrPAzstgN50G26z/CZaNn
'' SIG '' az7pxUKK5GpL7Yk3OHSvQe6Jhefdh1pMacNeNlhzcFYx
'' SIG '' 9v0ukkJfgI7bTwU4NYwQxn1LEFmI2t7IzfYa3mWm9C0h
'' SIG '' mCpDc2BWVtXEbkm382P0hluI+fsZVEbDQmmvCwI76wd0
'' SIG '' msuNe9D6MuvLNt0v9oepFvHhwZwj/+MNDgbxNooW1Q1S
'' SIG '' yhJpdQ9D1ECrBGTTeiX9P3trLN60MYy6UWyAa2meScHs
'' SIG '' KVbPEblKjwhtoTM8OUXMitOrojhiFFpfpqGCDskwgg7F
'' SIG '' BgorBgEEAYI3AwMBMYIOtTCCDrEGCSqGSIb3DQEHAqCC
'' SIG '' DqIwgg6eAgEDMQ8wDQYJYIZIAWUDBAIBBQAweAYLKoZI
'' SIG '' hvcNAQkQAQSgaQRnMGUCAQEGCWCGSAGG/WwHATAxMA0G
'' SIG '' CWCGSAFlAwQCAQUABCDQHdS9dABH5XHoxgDdg2vtAv7B
'' SIG '' K06HJs5ZH8CLh9yBdQIRAKxSZC4Bx1vNCBZu7Z3M9doY
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
'' SIG '' 9w0BCQQxIgQgCKatLHk0SsfC+pnI9GFFqwHO3b+CP520
'' SIG '' UFpG+CGbop0wDQYJKoZIhvcNAQEBBQAEggEAOJZFgA2y
'' SIG '' Dx/bOrfK+noWraQO5usD5+fy6VszkMkLulj0NuFcENZV
'' SIG '' fTjbfVaKz4mhSHFrw4z5fskd5c7iVy3RlMOLQ7X/mo08
'' SIG '' gRDwKrlUAfpLgdwg73L51yEEs/XUoQZKttRLBVDLJEuo
'' SIG '' HJO4YnTNFcK9JvZDDpo2wqXo56082u4uKPvX4ymemF7s
'' SIG '' jaRNPMcSFo/B6xqcvxLHVuEkK2PxT6gtFlt1CdXk+Pl4
'' SIG '' TwzXcjfxuBm8Cv+d2Ks7qy4D1TV55naMBluy9ROeIarM
'' SIG '' XxXArM0ImvEan7bebH5Cc2sBzC5wIQrb3cYcDltUzDpC
'' SIG '' uvGPHCTmbAxytt3UDROZYOZohg==
'' SIG '' End signature block
