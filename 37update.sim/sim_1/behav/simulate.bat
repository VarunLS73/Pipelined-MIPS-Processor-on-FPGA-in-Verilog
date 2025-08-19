@echo off
set xv_path=D:\\software\\Vivado\\2016.2\\bin
call %xv_path%/xsim mipstb_behav -key {Behavioral:sim_1:Functional:mipstb} -tclbatch mipstb.tcl -view C:/Users/DELL/37update/mipstb_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
