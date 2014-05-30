SET ORIGINAL=%CD%

:: TODO: Find out why openmp doesn't work

:: helper variables
call :build_hesaff
goto :exit

:build_hesaff
:: helper variables
set INSTALL32=C:\Program Files (x86)
set HESAFF_INSTALL="%INSTALL32%\Hesaff"

mkdir build
cd build

cmake ^
-G "MSYS Makefiles" ^
-DCMAKE_INSTALL_PREFIX=%HESAFF_INSTALL% ^
-DCMAKE_C_FLAGS="-march=i486" ^
-DCMAKE_CXX_FLAGS="-march=i486" ^
-DOpenCV_DIR="%INSTALL32%\OpenCV" ^
.. && make

copy /y libhesaff.dll ..\pyhesaff
copy /y libhesaff.dll.a ..\pyhesaff

:: make command that doesn't freeze on mingw
:: mingw32-make -j7 "MAKE=mingw32-make -j3" -f CMakeFiles\Makefile2 all
exit /b

:exit
cd %ORIGINAL%
exit /b