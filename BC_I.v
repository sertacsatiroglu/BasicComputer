`timescale 1ns / 1ns
`include "controller.v"
`include "datapath.v"



module BC_I (
            input clk,
            input FGI,
            output [11:0] PC,
            output [11:0] AR,
            output [15:0] IR,
            output [15:0] AC,
            output [15:0] DR
);
 
            wire [2:0] bus_select;
            wire [2:0] alu_select;
            
            wire write_En;
            wire clr_AC;
            wire clr_E;
            wire clr_AR;
            wire clr_PC;
            wire comp_E;
            
            wire ldr_AR;
            wire ldr_PC;                
            wire ldr_IR;                
            wire ldr_DR;                
            wire ldr_AC;
            wire ldr_TR;
            
            wire inc_AR;                             
            wire inc_AC;                             
            wire inc_DR;                             
            wire inc_PC;
            
            wire set_IEN;
            wire clr_IEN;
             
            wire E;
            wire [3:0] flag_reg;
            wire DR_zero;
            assign DR_zero = ~|DR;
            
            controller inst_controller(clk, flag_reg[1], flag_reg[0], DR_zero, E, IR, FGI, bus_select, alu_select, write_En, clr_AC, clr_E, clr_AR, clr_PC, comp_E, ldr_AR, ldr_PC, ldr_IR, ldr_DR, ldr_AC, ldr_TR, inc_AR, inc_AC, inc_DR, inc_PC,
            set_IEN, clr_IEN);
            datapath inst_datapath(clk, bus_select, alu_select, write_En, clr_AC, clr_E, clr_AR, clr_PC, comp_E, ldr_AR, ldr_PC, ldr_IR, ldr_DR, ldr_AC, ldr_TR, inc_AR, inc_AC, inc_DR, inc_PC,
            set_IEN, clr_IEN, AR, PC, DR, AC, IR, E, flag_reg);
endmodule