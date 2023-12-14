# Script for FPGA

## ModelSim独立仿真脚本
### 所需文件
- modelsim/Sim
- RTL源文件
- RTL仿真文件
  
### 操作步骤
1. 载入文件
    在modelsim/Sim/src和modelsim/Sim/sim中分别载入源文件和仿真文件
    （sim文件中只放一个主要仿真的文件，其他文件都放在src中）
2. 双击do.bat即可看到波形


## Vivado non-project tcl脚本
### 说明
默认型号为 xc7a200t fbg484  -2
若为不同型号，则需在 run.tcl、runhardware.tcl 中相应位置修改


### 操作步骤
1. 载入源文件
    在Sources中放入.v文件，xdc约束文件等
2. 综合-实现
   1. 打开Vivado并进入工程目录 cd ./Non-prj
   （注意，目录中斜杠为正斜杠/，若复制的为反斜杠/）
   （则需在每个斜杠前再加一个反斜杠/）
   2. 初始化 `source initiate.tcl`
   3. 执行综合-实现 `source run.tcl`
3. 烧录
   1. 连接好设备(打开电源)
   2. 执行烧录 `source run_hw.tcl`
   

## 代码说明
└─ Non-prj
   ├─ initiate.tcl                              初始化
   ├─ readme.md                           说明文件
   ├─ run_bitstream.tcl                   生成比特流
   ├─ run_hw.tcl                             烧录到硬件
   ├─ run_impl.tcl                           实现
   ├─ run_ns.tcl                              命名空间和执行过程
   ├─ run_read_src.tcl                    读取设计源
   ├─ run_synth_ip.tcl                    ip综合
   ├─ run_synth.tcl                         综合
   ├─ run.tcl                                   执行