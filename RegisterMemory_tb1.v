`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Create Date: 14.03.2024 18:17:57
// Module Name: RegisterMemory_tb
// Project Name: Excution Unit
// 
//////////////////////////////////////////////////////////////////////////////////  
module RegisterMemory_tb1; 

   localparam CLK_PERIOD = 10; // Clock period in ns 
 
    reg clk; 
    reg rst;
    reg [1:0] Select_Fn; 
    reg [7:0] data_in;
    reg read_en;
    reg write_en; 
    reg [4:0] address; 
    wire [7:0] data_out; 
    wire [3:0] flag; 
    reg [7:0] registers[5:0]; 
    reg [8:0] sum; 
    reg carry; 
  
    RegisterMemory  dut (.Select_Fn(Select_Fn), 
        .data_in(data_in),
        .read_en(read_en),
        .write_en(write_en), 
        .data_out(data_out), 
        .address(address), 
        .flag(flag)); 

    // Clock generation 
    always #((CLK_PERIOD / 2)) clk = ~clk; 
    // Testbench stimulus 
    initial begin 
        clk = 0; 
        rst = 1; 
        Select_Fn = 2'bzz; // Default to addition operation 
        read_en = 0;
        write_en = 0; 
        address = 0; 
        #10;
        rst = 0; // Deassert reset 
        #10;                                 

        //Load 141 to R4 
        data_in = 141; 
        address = 4; 
        write_en = 1; 
        #10; 
        write_en = 0; 
        #10; 
        
        //Load 208 to R5
        data_in = 208; 
        address = 5; 
        write_en = 1; 
        #10; 
        write_en = 0; 
        #10; 
        
        //Load 208 to R6 
        data_in = 208; 
        address = 6; 
        write_en = 1; 
        #10; 
        write_en = 0; 
        #10; 
        
        //Load 208 to R7 
        data_in = 208; 
        address = 7; 
        write_en = 1; 
        #10; 
        write_en = 0; 
        #10; 
        
        //Load 32 to R8 
        data_in = 32; 
        address = 8; 
        write_en = 1; 
        #10; 
        write_en = 0; 
        #10; 
        
        //Load 32 to R9
        data_in = 32; 
        address = 9; 
        write_en = 1; 
        #10; 
        write_en = 0; 
        #10;
        
        //loading
       
        data_in = 141; 
        address = 0; 
        write_en = 1; 
        #10; 
        write_en = 0; 
        #10; 

        begin
            for (integer i = 5; i <= 9;) begin
                // Load value into register i
       
                // Move value from register i to register 0 and 1
                address = i; read_en = 1; #10;  address = 1; write_en = 1; data_in = data_out; read_en = 0; #10; write_en = 0; #10;

                Select_Fn = 2'b00; 
                          #10;
                          Select_Fn = 2'bZZ; 
                          #10;
                      
             // Move value from register 2 to register 0
             address = 2; read_en = 1; #10; address = 0; write_en = 1; data_in = data_out; read_en = 0; write_en = 1; #10; write_en = 0; #10;

             i = i + 1;
            end
            
            data_in = 3; 
            address = 1; 
            write_en = 1'b1; 
            #10; 
            write_en = 1'b0; 
            #10;
            
            Select_Fn = 2'b00; 
            #10;
            Select_Fn = 2'bZZ; 
            #10;
             
            address = 2; read_en = 1; #10; address = 13; write_en = 1; data_in = data_out; read_en = 0; write_en = 1; #10; write_en = 0; #10;
          
        end

    $finish; 

 end 

endmodule 
