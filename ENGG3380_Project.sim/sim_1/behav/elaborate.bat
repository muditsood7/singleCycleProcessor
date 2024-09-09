@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.3\\bin
call %xv_path%/xelab  -wto fadce9deb5624c77a2ec0aa839532f94 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot CPU_Test_behav xil_defaultlib.CPU_Test -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
