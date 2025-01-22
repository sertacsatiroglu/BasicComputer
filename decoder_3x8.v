`timescale 1ns / 1ps


module decoder_3x8(
    input wire A,B,C,
    output wire D0,D1,D2,D3,D4,D5,D6,D7
    );
    
    and and0(D0,!A,!B,!C);
    and and1(D1,!A,!B,C);
    and and2(D2,!A,B,!C);
    and and3(D3,!A,B,C);
    and and4(D4,A,!B,!C);
    and and5(D5,A,!B,C);
    and and6(D6,A,B,!C);
    and and7(D7,A,B,C);
    
   
endmodule
