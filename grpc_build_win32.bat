@echo off
pushd %~dp0

call "%VS140COMNTOOLS%..\..\VC\vcvarsall.bat" amd64_x86

echo #### grpc build start!

mkdir grpc\bin\zlib
mkdir grpc\bin\zlib\debug
mkdir grpc\bin\zlib\release

cd grpc\third_party\zlib
mkdir build & cd build
mkdir debug & cd debug
cmake -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=../../../../bin/zlib/debug ../..
nmake & nmake install

cd ..
mkdir release & cd release
cmake -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=../../../../bin/zlib/release ../..
nmake & nmake install

cd ../../../../bin/zlib/release
set PATH=%PATH%;%cd%\bin

popd
pushd %~dp0

cd grpc\third_party\protobuf\cmake
cmake -G "Visual Studio 14 2015" -Dprotobuf_BUILD_TESTS=OFF -Dprotobuf_WITH_ZLIB=ON
devenv.com protobuf.sln /build "Debug|Win32" /project ALL_BUILD
if not %ERRORLEVEL% == 0 goto Finish
robocopy /mir .\Debug ..\..\..\bin\protobuf\debug

devenv.com protobuf.sln /build "Release|Win32" /project ALL_BUILD
if not %ERRORLEVEL% == 0 goto Finish
robocopy /mir .\Release ..\..\..\bin\protobuf\release

cd ..\..\..\vsprojects
devenv.com grpc_protoc_plugins.sln /build "Release|Win32"
if not %ERRORLEVEL% == 0 goto Finish
robocopy .\Release\ ..\bin\grpc_protoc_plugins\ /XF *.lib *.iobj *.ipdb
devenv.com grpc_protoc_plugins.sln /clean "Release|Win32"

devenv.com grpc.sln /clean "Debug"
devenv.com grpc.sln /clean "Release"
devenv.com grpc.sln /build "Debug|Win32" /project grpc++
devenv.com grpc.sln /build "Debug|Win32" /project grpc++_unsecure
if not %ERRORLEVEL% == 0 goto Finish
robocopy /mir .\Debug ..\bin\grpc\debug

devenv.com grpc.sln /build "Release|Win32" /project grpc++
devenv.com grpc.sln /build "Release|Win32" /project grpc++_unsecure
if not %ERRORLEVEL% == 0 goto Finish
robocopy /mir .\Release ..\bin\grpc\release /XF *grpc_cpp_plugin*

:: devenv.com grpc.sln /clean "Debug"
:: devenv.com grpc.sln /clean "Release"
:: devenv.com grpc.sln /build "Debug-DLL|Win32" /project grpc++
:: devenv.com grpc.sln /build "Debug-DLL|Win32" /project grpc++_unsecure
:: if not %ERRORLEVEL% == 0 goto Finish
:: robocopy /mir .\Debug-DLL ..\bin\grpc\debug_dll

:: devenv.com grpc.sln /build "Release-DLL|Win32" /project grpc++
:: devenv.com grpc.sln /build "Release-DLL|Win32" /project grpc++_unsecure
:: if not %ERRORLEVEL% == 0 goto Finish
:: robocopy /mir .\Release-DLL ..\bin\grpc\release_dll /XF *grpc_cpp_plugin*

echo #### grpc build done!

:Finish
rem devenv.com protobuf.sln /clean "Debug|Win32"
rem devenv.com protobuf.sln /clean "Release|Win32"
rem devenv.com grpc_protoc_plugins.sln /clean "Release|Win32" /project grpc_cpp_plugin
rem devenv.com grpc.sln /clean "Debug|Win32" /project grpc++
rem devenv.com grpc.sln /clean "Release|Win32" /project grpc++
popd
pause
