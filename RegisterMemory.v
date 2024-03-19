`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: IITM
// Engineer: Venkatesh H
// Create Date: 14.03.2024 18:13:01
// Design Name: EE6361
// Module Name: RegisterMemory
// Project Name: Execution Unit
// 
//////////////////////////////////////////////////////////////////////////////////

module RegisterMemory( 
    input [1:0] Select_Fn, 
    input wire [7:0] data_in,
    input read_en,
    input write_en, 
    output reg [7:0] data_out, 
    input [4:0] address, 
    output reg [3:0] flag 
); 

    reg [7:0] registers[31:0]; 
    reg [7:0] sum; 
    reg [7:0] difference; 
    reg [7:0] carry;  
    reg zero;
    reg borrow; 
    reg cmpflag; 

    always @(*) begin 

        // Read or write data based on control signals 
        if (read_en) 
            data_out <= registers[address]; 
        else if (write_en) 
            registers[address] <= data_in; 

        // ALU operations based on the select bit 
        case (Select_Fn) 
            2'b00: begin // Addition 
                // Perform addition and update flags 
                {carry, sum} = registers[0] + registers[1]; 
                flag[0] = carry; 
                registers[2] <= sum; 

            end  

            2'b01: begin // ALU Subtraction 
                // Perform subtraction and update flags 
                {borrow, difference} = registers[0] - registers[1]; 
                zero = (difference == 8'b00000000); // Check if the result is zero 
                flag[2] = zero; 
                flag[0] = borrow; // Borrow flag, if needed for your implementation 
                registers[2] <= difference; // Store the result in R2 
            end 

            2'b10: begin // ALU Comparison 
                // Perform comparison and update flags 
                cmpflag = (registers[4] >= registers[5]) ? 1 : 0; 
                flag[3] = cmpflag; 
                if (registers[4] >= registers[5])
                        registers[15] <= registers[4]; 
                else
                        registers[15] <= registers[5]; 
            end 
              
            2'b11: begin // ALU Increment 
                // Increment the value in reg[0] and update R2 
                registers[2] = registers[0] + 8'b00000001; 
            end 
        endcase 
    end
endmodule 
