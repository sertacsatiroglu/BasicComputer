`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2023 05:32:12 PM
// Design Name: 
// Module Name: ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU #(parameter WIDTH = 16
     )(
       input [WIDTH-1:0] AC,
       input [WIDTH-1:0] DR,
       input [2:0] alu_select,
       input E,
       output reg carry,
       output reg [3:0] flag_reg,  // (CO,OVF,N,Z)
       output reg [WIDTH-1:0] alu_out);
       
       wire overflow_flag,overflow1,overflow2;
       and and0(overflow1, AC[WIDTH-1], DR[WIDTH-1], !alu_out[WIDTH-1]);
       and and1(overflow2, !AC[WIDTH-1], !DR[WIDTH-1], alu_out[WIDTH-1]);
       or or0(overflow_flag, overflow1, overflow2);
       
    always @(*) begin

        
        flag_reg[3] <= E;                                       // carry out flag
        flag_reg[2] <= ((alu_select == 1) && (overflow_flag));  // overflow flag
        flag_reg[1] <= alu_out[WIDTH-1];                        // negative flag
        flag_reg[0] <= ~|alu_out;                               // zero flag

        case (alu_select)
            1: {carry,alu_out} <= AC + DR;
            2: alu_out <= AC & DR;
            3: alu_out <= DR;
            4: alu_out <= ~AC;
            5: alu_out <= ({E, AC[WIDTH-1:1]});  
            6: alu_out <= ({AC[WIDTH-2:0],E});
            default: alu_out <= alu_out;
        endcase
    end
endmodule

