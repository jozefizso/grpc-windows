signtool.exe sign /v /sha1 AB19D2855D203E5AEEE13584AD3AAD1CA9FBAC3D /sm /t http://timestamp.verisign.com/scripts/timstamp.dll protoc.exe
signtool.exe sign /as /v /fd sha256 /td sha256 /sha1 AB19D2855D203E5AEEE13584AD3AAD1CA9FBAC3D /sm /tr http://timestamp.comodoca.com/rfc3161 protoc.exe
