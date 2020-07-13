
mkdir build_release_julia_windows
cd build_release_julia_windows
del /F/Q/S *.*
del /F/Q/S julia-tree-windows
rmdir /Q/S julia-tree-windows
git clone git@github.com:AkillesAILimited/julia-tree-windows.git
cd julia-tree-windows 
call make-tree.bat
SET PATH=%CD%\Julia-1.4.2\bin;%PATH%
SET JULIA_HOME=%CD%\Julia-1.4.2
cd ..
dir
cd ..
julia install-juliapkgs.jl
julia gen_ThetisSupport.jl
mkdir %JULIA_HOME%\org
move %JULIA_HOME%\lib\julia\sys.dll %JULIA_HOME%\org
move sys.dll %JULIA_HOME%\lib\julia\

echo %CD%
dir

REM goto :END

cd build_release_julia_windows
cmake -DUSE_CUDA=OFF -USE_JULIA=ON -DCMAKE_BUILD_TYPE=Release ..
if %errorlevel% neq 0 exit /b %errorlevel%
cmake --build . --config Release
if %errorlevel% neq 0 exit /b %errorlevel%
copy Release\*.exe .
copy Release\*.dll .
copy julia-tree-windows\Julia-1.4.2\bin\*.* .

xcopy /I/Y/E/H julia-tree-windows\Julia-1.4.2\etc ..\etc
xcopy /I/Y/E/H julia-tree-windows\Julia-1.4.2\include ..\include
xcopy /I/Y/E/H julia-tree-windows\Julia-1.4.2\lib ..\lib
xcopy /I/Y/E/H julia-tree-windows\Julia-1.4.2\libexec ..\lib
xcopy /I/Y/E/H julia-tree-windows\Julia-1.4.2\org ..\lib
xcopy /I/Y/E/H julia-tree-windows\Julia-1.4.2\share ..\lib
xcopy /I/Y/E/H julia-tree-windows\VCRT ..\VCRT

cd ..
REM goto :END

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
jar cvf thetis-windows.zip build_release_windows/*.dll build_release_windows/*.exe testData/* licenses LICENSE build_release_julia_windows/*.dll build_release_julia_windows/*.exe etc include lib libexec org share
echo "CD = " %CD%

:END