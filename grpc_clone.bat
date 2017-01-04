@echo off
pushd %~dp0

echo #### grpc clone start!

echo #### git clone
git clone -b v1.0.1 -c core.eol=lf -c core.autocrlf=input https://github.com/grpc/grpc grpc
cd grpc
git submodule update --init
git submodule foreach --recursive git config core.eol lf
git submodule foreach --recursive git config core.autocrlf input
git submodule foreach --recursive git rm -rf --cached .
git submodule foreach --recursive git reset --hard HEAD

cd third_party\protobuf
git checkout -b v3.1.0 v3.1.0
popd

pushd %~dp0

echo #### props edit
powershell -executionpolicy bypass -file edit_props.ps1

:: patch Protobuf with file version information
robocopy .\protobuf-patch .\grpc\third_party\protobuf /e /nfl /ndl
:: patch grpc and protoc plugins
robocopy .\grpc-patch .\grpc /e /nfl /ndl
powershell -executionpolicy bypass -file grpc_cpp_plugin_patch.ps1


echo #### nuget packages install
mkdir grpc\vsprojects\packages & cd grpc\vsprojects\packages
powershell -executionpolicy bypass -Command Invoke-WebRequest https://dist.nuget.org/win-x86-commandline/latest/nuget.exe -OutFile %cd%\nuget.exe
nuget.exe install ..\vcxproj\grpc\packages.config


echo #### grpc clone done!

popd
pause
