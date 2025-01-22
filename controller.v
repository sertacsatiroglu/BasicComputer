`timescale 1ns / 1ps
`include "decoder_3x8.v"

module controller
                 (input clk,
                  input N,
                  input Z,
                  input DR_zero,
                  input E_zero,
                  input [15:0] IR,
                  input FGI,              // FOR INTERRUPT
                  output [2:0] bus_select,
                  output [2:0] alu_select,
                  
                  output write_En,
                  output clr_AC,
                  output clr_E,
                  output clr_AR,
                  output clr_PC,
                  output comp_E,
                  
                  output ldr_AR,
                  output ldr_PC,                
                  output ldr_IR,                
                  output ldr_DR,                
                  output ldr_AC,
                  output ldr_TR,
                  
                  output inc_AR,                             
                  output inc_AC,                             
                  output inc_DR,                             
                  output inc_PC,
                  
                  output set_IEN,
                  output clr_IEN                            
                  );
                  
   wire D0,D2,D3,D4,D5,D6,D7;
   wire T0,T1,T2,T3,T4,T5,T6,T7;
   
    reg [2:0] SC = 0;
    reg IEN = 1;
    reg R = 0;
    wire set_R;
    assign set_R = !T0 && !T1 && !T2 && (FGI) && IEN;
   
   wire I;
   assign I = IR[15];
   
   decoder_3x8 inst0(IR[14],IR[13],IR[12],D0,D1,D2,D3,D4,D5,D6,D7);
   decoder_3x8 inst1(SC[2],SC[1],SC[0],T0,T1,T2,T3,T4,T5,T6,T7);
   
   wire SC_clear;
   assign SC_clear = ((D7 && T3) || ((D3 || D4) && T4) || ((D0 || D1 || D2 || D5) && T5) || T6) || (R && T2);
   
   wire r;
   assign r = D7 && !I && T3;

   assign write_En = (D3 && T4) || (D5 && T4) || (D6 && T6) || (R && T1);
   assign clr_AC = (r && IR[11]);
   assign clr_E = (r && IR[10]);
   assign clr_AR = (R && T0);
   assign clr_PC = (R && T1);
   assign comp_E = (r && IR[8]);
   assign comp_AC = (r && IR[9]);
   
   assign ldr_AR = (T0 && !R) || (T2 && !R) || (!D7 && I && T3);
   assign ldr_PC = (D4 && T4) || (D5 && T5);
   assign ldr_IR = T1 && !R;
   assign ldr_DR = ((D0 || D1 || D2 || D6) && T4);
   assign ldr_AC = (D0 && T5) || (D1 && T5) || (D2 && T5) ||
                   (r && (IR[11] || IR[9] || IR[7] || IR[6]));
   assign ldr_TR = (R && T0);
   
   assign inc_AR = (D5 && T4);
   assign inc_AC = (r && IR[5]);
   assign inc_DR = (D6 && T5);
   assign inc_PC = (r && IR[4] && !N) || 
                   (r && IR[3] && N) ||
                   (r && IR[2] && Z) ||
                   (r && IR[1] && E_zero) ||
                   (D6 && T6 && DR_zero) ||
                    (T1 && !R) ||
                    (R && T2);
   assign set_IEN = (D7 && I && T3 && IR[7]);                 
   assign clr_IEN = (D7 && I && T3 && IR[6]) || (R && T2);
                      
   assign alu_select =  (comp_AC) ? 4 : 
                        ((D0 && T5) ? 2 : 
                        ((D1 && T5) ? 1 : 
                        ((D2 && T5) ? 3 : 
                        ((r && IR[7]) ? 5 : 
                        ((r && IR[6]) ? 6 : 
                        7)))));
                        
    assign bus_select = (((D0 || D1 || D2 || D6) && T4) || (T1 && !R) || (!D7 && I && T3)) ? 7 
                        : ((T2 && !R) ? 5 
                        : (((D4 && T4) || (D5 && T5) ? 1 
                        : ((T0 || (D5 && T4) ? 2 
                        : (((D6 && T6) || (D2 && T5)) ? 3 
                        : ((D3 && T4) ? 4 
                        : ((R && T1) ? 6 : bus_select ))))))));
    
    
    always @(posedge clk) begin
        SC <= SC + 1;
        if (SC_clear)
            SC <= 0; 
        if (set_R)
            R <= 1;
        if (R && T2) begin
            R <= 0;  
            SC <= 0;
        end
    end
   
endmodule
