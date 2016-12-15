
set _signkey=AB19D2855D203E5AEEE13584AD3AAD1CA9FBAC3D

call "%VS140COMNTOOLS%..\..\VC\vcvarsall.bat" amd64_x86

signtool.exe sign /v /sha1 %_signkey% /sm /t http://timestamp.verisign.com/scripts/timstamp.dll grpc\bin\protobuf\release\protoc.exe
signtool.exe sign /as /v /fd sha256 /td sha256 /sha1 %_signkey% /sm /tr http://timestamp.comodoca.com/rfc3161 grpc\bin\protobuf\release\protoc.exe


signtool.exe sign /v /sha1 %_signkey% /sm /t http://timestamp.verisign.com/scripts/timstamp.dll grpc\bin\grpc_protoc_plugins\grpc_cpp_plugin.exe
signtool.exe sign /as /v /fd sha256 /td sha256 /sha1 %_signkey% /sm /tr http://timestamp.comodoca.com/rfc3161 grpc\bin\grpc_protoc_plugins\grpc_cpp_plugin.exe

