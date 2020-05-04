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

' CreatePaths.vbs

' DESCRIPTION

' This example shows how to create a path of straight lines and
' how to create a path with smooth lines.
'
'*************************************************************

Set appRef = CreateObject("Illustrator.Application")
Set docRef = appRef.Documents.Add

Rem Create a color to use for the paths

Set greenColor = CreateObject("Illustrator.CMYKColor")
greenColor.Black = 0
greenColor.Cyan = 81.96
greenColor.Magenta = 0
greenColor.Yellow = 100

Rem Create the first path from 4 straight lines

Set linePath = appRef.ActiveDocument.PathItems.Add
linePath.SetEntirePath Array(Array(100, 100), _
			Array(300, 300), _
			Array(100, 300), _
			Array(300, 100))
linePath.Closed = False
linePath.Stroked = True
linePath.StrokeWidth = 2
linePath.StrokeColor = greenColor
linePath.Filled = False
linePath.StrokeJoin = 3 ' aiRoundEndJoin

Rem Create the smooth path
greenColor.Yellow = 32

Set smoothPath = appRef.ActiveDocument.PathItems.Add

smoothPath.Closed = False
smoothPath.Stroked = True
smoothPath.StrokeWidth = 2
smoothPath.StrokeColor = greenColor
smoothPath.Filled = False

' Create the PathPoints that the smooth path is constructed from

Set newPathPoint = smoothPath.PathPoints.Add
newPathPoint.Anchor = Array(100, 100)
newPathPoint.LeftDirection = Array(100, 20)
newPathPoint.RightDirection = Array(100, 180)
newPathPoint.PointType = 2 ' aiSmooth

Set newPathPoint = smoothPath.PathPoints.Add
newPathPoint.Anchor = Array(300, 300)
newPathPoint.LeftDirection = Array(330, 250)
newPathPoint.RightDirection = Array(270, 350)
newPathPoint.PointType = 2 ' aiSmooth

Set newPathPoint = smoothPath.PathPoints.Add
newPathPoint.Anchor = Array(100, 300)
newPathPoint.LeftDirection = Array(130, 350)
newPathPoint.RightDirection = Array(70, 250)
newPathPoint.PointType = 2 ' aiSmooth

Set newPathPoint = smoothPath.PathPoints.Add
newPathPoint.Anchor = Array(300, 100)
newPathPoint.LeftDirection = Array(300, 180)
newPathPoint.RightDirection = Array(300, 20)
newPathPoint.PointType = 2 ' aiSmooth


'' SIG '' Begin signature block
'' SIG '' MIIeWgYJKoZIhvcNAQcCoIIeSzCCHkcCAQExDzANBglg
'' SIG '' hkgBZQMEAgEFADB3BgorBgEEAYI3AgEEoGkwZzAyBgor
'' SIG '' BgEEAYI3AgEeMCQCAQEEEE7wKRaZJ7VNj+Ws4Q8X66sC
'' SIG '' AQACAQACAQACAQACAQAwMTANBglghkgBZQMEAgEFAAQg
'' SIG '' 2oyxOZvhHeBUU7Vv1GChEliBXb7tTa+J1E6kufNE2SOg
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
'' SIG '' AQQBgjcCARUwLwYJKoZIhvcNAQkEMSIEID0R0aNSZlHM
'' SIG '' JM5768zedstaEGsE0obpZZl1lTs2wAGxMDYGCisGAQQB
'' SIG '' gjcCAQwxKDAmoCSAIgBBAGQAbwBiAGUAIABJAGwAbAB1
'' SIG '' AHMAdAByAGEAdABvAHIwDQYJKoZIhvcNAQEBBQAEggEA
'' SIG '' VzFjEV759Id7uQqnSi/LY2jnDhFzy9VqT0YrrpQDx6RA
'' SIG '' dNkdNGPqMZPWeKdxeWQcjMl6svlqZ2eWCD2hA4dQ0VMZ
'' SIG '' IOukS3SkqReSFa1ipjvStGQTTAOUhUOLZ6HypDb4u3Fv
'' SIG '' Mx7FJhQCHAN3R+GYjDS/4ppOxKnDN3RXYUDyN0AA+jjt
'' SIG '' HcVF6wuItLrB/EF5gRmK31QgCoJ6cjKm8Ur+PJK077lw
'' SIG '' GgQCA8erOHKt8g2pr0EQE7QypuxQ5tXgRkwkdXoOh0IU
'' SIG '' NXUe4lY4RRE8551rBUz6M4cNhjbigvmAJy4XJR3Cy/B+
'' SIG '' w0L1FDCv4i2PyfAFOmNgyR6LEajuUD7glaGCDskwgg7F
'' SIG '' BgorBgEEAYI3AwMBMYIOtTCCDrEGCSqGSIb3DQEHAqCC
'' SIG '' DqIwgg6eAgEDMQ8wDQYJYIZIAWUDBAIBBQAweAYLKoZI
'' SIG '' hvcNAQkQAQSgaQRnMGUCAQEGCWCGSAGG/WwHATAxMA0G
'' SIG '' CWCGSAFlAwQCAQUABCArSHNIjDRa+/7mkbDE8n0nTZ1G
'' SIG '' 7pL3EUgnjG2GOmQjwQIRAKLA4A5BvKE5dDWAvaoTU20Y
'' SIG '' DzIwMjAwNDA2MjAyMjMxWqCCC7swggaCMIIFaqADAgEC
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
'' SIG '' MjAwNDA2MjAyMjMxWjArBgsqhkiG9w0BCRACDDEcMBow
'' SIG '' GDAWBBQDJb1QXtqWMC3CL0+gHkwovig0xTAvBgkqhkiG
'' SIG '' 9w0BCQQxIgQgJxvRzkCYs1AgRr6Mk9aPFcpFWo1pOJE+
'' SIG '' cSLjww2UPqYwDQYJKoZIhvcNAQEBBQAEggEAYxfGRTo7
'' SIG '' JHLcF+X9yAkK+H5TTQocm6fIxpjXJESSkt5JwMatc3fs
'' SIG '' 620yedxxizd4toBcMh9xl3QPhrRmoeGL7Mcmk3KSwbw6
'' SIG '' +bghtONIjMNLeYr3UZXjwctnfXdnpYvUBa1urwiqn1aD
'' SIG '' J5Cy7xYI3xoidjRvWty14dBWhl1wV0PN1kWL5CDt6H6L
'' SIG '' osQAHjJQzsQ9PXN7ouVfk2Q4mrneMP9SSQDuzGWSMcUD
'' SIG '' uRwYAhD+rKzeDiM7x7YvAwhAMDv1nHW9zpnVSiPTDUTQ
'' SIG '' Y4Kls1SiEWF6O7+E0KrzWewz5UJDEsiKCwHFR/nsruk1
'' SIG '' gsqTlxrRStDf1iLIwZ6BDwyovA==
'' SIG '' End signature block
