`timescale 1ns / 1ps
module mux_8to1#(parameter WIDTH = 16
     )(
       input [WIDTH-5:0] AR,
       input [WIDTH-5:0] PC,
       input [WIDTH-1:0] DR,
       input [WIDTH-1:0] AC,
       input [WIDTH-1:0] IR,
       input [WIDTH-1:0] TR,
       input [WIDTH-1:0] Memory,
       input [2:0] bus_select,
       output [WIDTH-1:0] bus_content);
       
     assign bus_content = (bus_select == 1) ? AR 
                       : ((bus_select == 2) ? PC 
                       : ((bus_select == 3) ? DR 
                       : ((bus_select == 4) ? AC 
                       : ((bus_select == 5) ? IR 
                       : ((bus_select == 6) ? TR
                       : ((bus_select == 7) ? Memory 
                       : 0))))));

endmodule
