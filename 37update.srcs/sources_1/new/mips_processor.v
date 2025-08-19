`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/05/2025 03:40:25 PM
// Design Name: 
// Module Name: mips_processor
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


module mips_processor(
    input clk, reset,
    input [15:0] instruction,
    output reg [15:0] result
);
    reg [15:0] registers [0:7]; // 8 general-purpose registers
    reg [3:0] opcode;
    reg [2:0] rs, rt, rd;
    reg [7:0] immediate;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            result <= 16'b0;
            // Initial values for testing
            registers[0] <= 16'd0;
            registers[1] <= 16'd5;
            registers[2] <= 16'd3;
            registers[3] <= 16'd2;
            registers[4] <= 16'd10;
            registers[5] <= 16'd20;
            registers[6] <= 16'd4;
            registers[7] <= 16'd8;
        end else begin
            opcode    = instruction[15:12];
            rs        = instruction[11:9];
            rt        = instruction[8:6];
            rd        = instruction[5:3];
            immediate = instruction[7:0];

            case (opcode)
                4'b0001: begin // ADD
                    result <= registers[rs] + registers[rt];
                    registers[rd] <= registers[rs] + registers[rt];
                end
                4'b0010: begin // SUB
                    result <= registers[rs]-registers[rt];
                    registers[rd] <= registers[rs] - registers[rt];
                end
                4'b0011: begin // MUL
                    result <= registers[rs] * registers[rt];
                    registers[rd] <= registers[rs] * registers[rt];
                end
                4'b0100: begin // DIV
                    if (registers[rt] != 0)
                        result <= registers[rs] / registers[rt];
                    else
                        result <= 16'd0;
                    registers[rd] <= result;
                end
                4'b0101: begin // AND
                    result <= registers[rs] & registers[rt];
                    registers[rd] <= result;
                end
                4'b0110: begin // OR
                    result <= registers[rs] | registers[rt];
                    registers[rd] <= result;
                end
                4'b0111: begin // XOR
                    result <= registers[rs] ^ registers[rt];
                    registers[rd] <= result;
                end
                4'b1000: begin // NOR
                    result <= ~(registers[rs] | registers[rt]);
                    registers[rd] <= result;
                end
                4'b1001: begin // SLL
                    result <= registers[rs] << registers[rt][3:0];
                    registers[rd] <= result;
                end
                4'b1010: begin // SRL
                    result <= registers[rs] >> registers[rt][3:0];
                    registers[rd] <= result;
                end
                4'b1011: begin // LI
                    result <= {8'b0, immediate};
                    registers[rd] <= result;
                end
                default: begin
                    result <= 16'd0;
                end
            endcase
        end
    end
endmodule
