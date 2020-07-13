
mkdir build_release_windows
cd build_release_windows
del /F/Q/S *.*
cmake -DUSE_CUDA=OFF -DUSE_JULIA=OFF -DCMAKE_BUILD_TYPE=Release ..
if %errorlevel% neq 0 exit /b %errorlevel%
REM msbuild -m:6 -p:Configuration=Release Thetis.sln
cmake --build . --config Release
if %errorlevel% neq 0 exit /b %errorlevel%
copy Release\*.exe .
copy Release\*.dll .
.\TestThetis.exe
if %errorlevel% neq 0 exit /b %errorlevel%
cd ..
zip -r thetis-windows.zip build_release_windows/*.dll build_release_windows/*.exe testData/* licenses LICENSE
echo "CD = " %CD%
