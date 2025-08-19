`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/05/2025 03:41:35 PM
// Design Name: 
// Module Name: mipstb
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


module mipstb;
       reg clk, reset;
    reg [15:0] instruction;
    wire [15:0] result;

    // Instantiate the processor
    mips_processor uut (
        .clk(clk),
        .reset(reset),
        .instruction(instruction),
        .result(result)
    );

    // Clock generation (20 ns period)
    always #10 clk = ~clk;

    initial begin
        $display("==== Starting 16-bit MIPS Testbench ====");
        $monitor("Time=%0t | Instruction=%b | Result=%0d (0x%h)",
                 $time, instruction, result, result);

        clk = 0;
        reset = 1;
        #20 reset = 0;

        // === INSTRUCTIONS ===

        // ADD R1 = R2 + R3 (5 + 3 = 8)
        instruction = 16'b0001_010_011_001_000; #20;


        // MUL R1 = R2 * R3 (5 * 3 = 15)
        instruction = 16'b0011_010_011_001_000; #20;

        // DIV R4 = R5 / R6 (20 / 4 = 5)
        instruction = 16'b0100_101_110_100_000; #20;

        // AND R7 = R5 & R6 (20 & 4 = 4)
        instruction = 16'b0101_101_110_111_000; #20;

        // OR R7 = R5 | R6 (20 | 4 = 20)
        instruction = 16'b0110_101_110_111_000; #20;

        // XOR R0 = R2 ^ R3 (5 ^ 3 = 6)
        instruction = 16'b0111_010_011_000_000; #20;

        // NOR R0 = ~(R2 | R3) = ~(5 | 3) = ~7 = FFF8
        instruction = 16'b1000_010_011_000_000; #20;
 // SUB R4 = R5 - R6 (20 - 4 = 16)
               instruction = 16'b0010_101_110_100_000; #20;
        // SLL R1 = R2 << R3 (5 << 3 = 40)
        instruction = 16'b1001_010_011_001_000; #20;

        // SRL R1 = R2 >> R3 (5 >> 3 = 0)
        instruction = 16'b1010_010_011_001_000; #20;

        // LI R6 = 25
        instruction = 16'b1011_000_000_110_00011001; #20;

        $display("==== Simulation Completed ====");
        $stop;
    end
endmodule
