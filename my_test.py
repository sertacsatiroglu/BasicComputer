

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge
    
def value_checker(AR,PC,IR,AC,DR,dut):
    assert AR == dut.AR.value   
    assert PC == dut.PC.value
    assert IR == dut.IR.value
    assert AC == dut.AC.value
    assert DR == dut.DR.value

@cocotb.test()
async def basic_computer(dut):
    
    cocotb.start_soon(Clock(dut.clk, 10, units = "ns").start())
    rising_edge = RisingEdge(dut.clk)
    dut.FGI.value = 0
    await rising_edge
 
    for i in range(4):
        await rising_edge
    value_checker(32,1,0x7020,1,0,dut)
                                                        ### I KNOW, DOING THE TEST WITH A BUNCH OF FOR LOOPS IS NOT PRACTICAL.. BUT ASSIGNMENT WAS SIMPLE
    for i in range(4):
        await rising_edge
    value_checker(32,2,0x7020,2,0,dut)
    
    for i in range(4):
        await rising_edge
    value_checker(64,3,0x7040,4,0,dut)
    
    for i in range(4):
        await rising_edge
    value_checker(2048,4,0x7800,0,0,dut)
    
    for i in range(4):
        await rising_edge
    value_checker(32,5,0x7020,1,0,dut)
    
    for i in range(6):
        await rising_edge
    value_checker(17,6,0x1011,976,975,dut)  
    
    for i in range(4):
        await rising_edge
    value_checker(128,7,0x7080,488,975,dut)

    for i in range(6):
        await rising_edge
    value_checker(16,8,0x2010,64888,64888,dut)  
    
    for i in range(4):
        await rising_edge
    value_checker(512,9,0x7200,647,64888,dut)
    
    for i in range(6):
        await rising_edge
    value_checker(19,10,0x0013,5,5,dut)  

    for i in range(4):
        await rising_edge
    value_checker(128,11,0x7080,2,5,dut)  
    
    for i in range(4):
        await rising_edge
    value_checker(1024,12,0x7400,2,5,dut) 
    
    for i in range(7):
        await rising_edge
    value_checker(20,13,0x6014,2,65535,dut)  
    
    for i in range(7):
        await rising_edge
    value_checker(20,15,0x6014,2,0,dut)

    for i in range(5):
        await rising_edge
    value_checker(0,0,0x4000,2,0,dut)  
    
    for i in range(4):
        await rising_edge
    value_checker(32,1,0x7020,3,0,dut)  
    
    for i in range(4):
        await rising_edge
    value_checker(32,2,0x7020,4,0,dut)  
 
