#获取仿真文件名
set folder_path "./sim"
set file [glob -directory $folder_path *.v]


# 使用正则表达式匹配目标文字
if {[regexp {/([^/]+)\.v} $file match group]} {
    set Testbench $group
} else {
    puts "error"
}



#建立库
vlib work
vmap work work

#编译文件
vlog ./src/*.v
vlog ./sim/*.v

#开始仿真
vsim -voptargs=+acc work.$Testbench

#波形
view wave
view structure

#打开信号窗口
view signals

#添加波形
add wave -radix hexadecimal $Testbench/*

#运行
run 100ms