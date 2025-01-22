`timescale 1ns / 1ps
`include "ALU.v"
`include "register_unit.v"
`include "mux_8to1.v"
`include "memory_unit.v"


module datapath #(parameter WIDTH = 16
     )(input clk,
       input [2:0] bus_select,
       input [2:0] alu_select,
       
       input write_En,
       input clr_AC,
       input clr_E,
       input clr_AR,
       input clr_PC,
       input comp_E,
       
       input ldr_AR,
       input ldr_PC,                
       input ldr_IR,                
       input ldr_DR,                
       input ldr_AC,
       input ldr_TR,
       
       input inc_AR,                             
       input inc_AC,                             
       input inc_DR,                             
       input inc_PC,
       
       input set_IEN,
       input clr_IEN,        

       output [WIDTH-5:0] AR,
       output [WIDTH-5:0] PC,
       output [WIDTH-1:0] DR,
       output [WIDTH-1:0] AC,
       output [WIDTH-1:0] IR,
       
       output reg E_reg,
       output [3:0] flag_reg);  // (CO,OVF,N,Z)
       
       wire [WIDTH-1:0] AC_in;
       wire carry;  
       wire E;
       initial E_reg <= 0;
       assign E = E_reg;
       wire [WIDTH-1:0] TR;
       wire [WIDTH-1:0] Memory_out;
       reg IEN;
       
       wire [WIDTH-1:0] bus_content;
        
       mux_8to1 inst0(AR,PC,DR,AC,IR,TR,Memory_out,bus_select,bus_content);    
       register_unit #(.WIDTH(12)) instAR(clk,clr_AR,ldr_AR,inc_AR, bus_content, AR);
       register_unit #(.WIDTH(12),.INITIAL(0)) instPC(clk,clr_PC,ldr_PC,inc_PC, bus_content, PC);     //// INITIAL PARAMETER IS THE INITIAL VALUE OF PC
       register_unit instDR(clk,1'b0,ldr_DR,inc_DR, bus_content, DR);
       register_unit instAC(clk,clr_AC,ldr_AC,inc_AC, AC_in, AC);
       register_unit instIR(clk,1'b0,ldr_IR,1'b0, bus_content, IR);
       register_unit instTR(clk,1'b0,ldr_TR,1'b0, bus_content, TR);
       ALU instALU(AC, DR, alu_select, E, carry, flag_reg, AC_in);
       memory_unit instMEMORY(clk, write_En, bus_content, AR, Memory_out);
       
       always @(posedge clk) begin
          ////  BELOW 2 CODE LINES ARE FOR "IEN" REGISTER 
            if (set_IEN) IEN <= 1;
            else if (clr_IEN) IEN <= 0;
         ////   BELOW 5 CODE LINES ARE FOR "E" REGISTER   
            if (clr_E) E_reg <= 0;
            if (comp_E) E_reg <= ~E_reg;
            if ((alu_select == 1) && carry) E_reg <= 1;
            if (alu_select == 5) E_reg <= AC[0]; 
            if (alu_select == 6) E_reg <= AC[WIDTH-1];

       end
       
endmodule
