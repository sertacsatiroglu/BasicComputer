`timescale 1ns / 1ns
module memory_unit
      (input clk,
       input write_enable,
       input [15:0] write_data,
       input [11:0] memory_address,
       output [15:0] memory_content);
    

reg [15:0] mem [0:4095];


initial begin
    mem[0] = 16'h7020;
    mem[1] = 16'h7020;
    mem[2] = 16'h7040;
    mem[3] = 16'h7800;
    mem[4] = 16'h7020;
    mem[5] = 16'h1011;
    mem[6] = 16'h7080;
    mem[7] = 16'h2010;
    mem[8] = 16'h7200;
    mem[9] = 16'h0013;
    mem[10] = 16'h7080;
    mem[11] = 16'h7400;
    mem[12] = 16'h6014;
    mem[13] = 16'h6014;
    mem[14] = 16'h7020;
    mem[15] = 16'h4000;
    mem[16] = 16'hFD78;
    mem[17] = 16'h03CF;
    mem[18] = 16'h0014;
    mem[19] = 16'h0005;
    mem[20] = 16'hFFFE;

end

//initial $readmemh("interrupt_routine_test.mem",mem, 0, 31);

assign memory_content = mem[memory_address];

always @(posedge clk) begin
    if (write_enable)
         mem[memory_address] <= write_data;
end

endmodule
