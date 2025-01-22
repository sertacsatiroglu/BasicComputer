`timescale 1ns / 1ps


module register_unit #(parameter WIDTH = 16, parameter INITIAL = 0
       )(
         input clk,
         input reset,
         input write_enable,
         input increment,
         input [WIDTH-1:0] DATA,
         output reg [WIDTH-1:0] out = INITIAL
        );
        
     always @(posedge clk) begin
        if (reset) out <= 0;
        else if (write_enable) out <= DATA;
        else if (increment) out <= out + 1;
     end       
        
endmodule
