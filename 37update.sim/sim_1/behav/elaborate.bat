@echo off
set xv_path=D:\\software\\Vivado\\2016.2\\bin
call %xv_path%/xelab  -wto bb7bafd28eb8487c80060b9511aa59e3 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot mipstb_behav xil_defaultlib.mipstb xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
