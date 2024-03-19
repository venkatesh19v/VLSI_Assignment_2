`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Create Date: 14.03.2024 18:17:57
// Module Name: RegisterMemory_tb
// Project Name: Excution Unit
// 
//////////////////////////////////////////////////////////////////////////////////  
module RegisterMemory_tb2; 

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

        // 1. Loading Values into the registers 
        // a) Load 141 to R4 
        data_in = 141;
        address = 4; 
        write_en = 1; 
        #10; 
        write_en = 0; 
        #10; 
  
        // b) Load 208 to R6 
        data_in = 208;
        address = 6; 
        write_en = 1; 
        #10; 
        write_en = 0; 
        #10; 
  
        // c) Load 32 to R8 
        data_in = 32;
        address = 8; 
        write_en = 1; 
        #10; 
        write_en = 0; 
        #10; 
  
        // 2. Moving Values Across Registers 
        // a) Move R4 to R5 

        address = 4; 
        read_en = 1;
        #10; 
        address = 5; 
        write_en = 1; 
        data_in = data_out; 
        read_en = 0;
        write_en = 1; 
        #10; 
  
        // b) Move R8 to R9 
        address = 8; 
        read_en = 1;
        #10; 
        address = 9; 
        write_en = 1; 
        data_in = data_out; 
        read_en = 0;
        write_en = 1; 
        #10; 
  
        // c) Move R6 to R7 
        address = 6; 
        read_en = 1;
        #10; 
        address = 7; 
        write_en = 1; 
        data_in = data_out; 
        read_en = 0;
        write_en = 1; 
        #10; 
        
        //3. Addition 
        //R4 + R6 => R10
        //Move R4 to R0 
        address = 4; 
        read_en = 1;
        #10; 
        address = 0; 
        write_en = 1; 
        data_in = data_out; 
        read_en = 0;
        write_en = 1; 
        #10;
        write_en = 0; 
        #10;   
        
        // Move R6 to R1 
        address = 6; 
        read_en = 1;
        #10; 
        address = 1; 
        write_en = 1; 
        data_in = data_out; 
        read_en = 0;
        write_en = 1; 
        #10; 
        write_en = 0; 
        #10;
        
        Select_Fn = 2'b00; //Addition ALU function select line  
        #10;
        Select_Fn = 2'bZZ;
           
        #10; 
        address = 2; 
        read_en = 1;
        #10; 
        address = 10; 
        write_en = 1; 
        data_in = data_out; 
        read_en = 0;
        write_en = 1; 
        #10;
        write_en = 0; 
        #10;
        
        //4. Subtraction 
        //R6-R8 => R11
        //Move R6 to R0        
        
        address = 6; 
        read_en = 1;
        #10; 
        address = 0; 
        write_en = 1; 
        data_in = data_out; 
        read_en = 0;
        write_en = 1; 
        #10;
        write_en = 0; 
        #10;   
          
        //Move R8 to R0 

        address = 8; 
        read_en = 1;
        #10; 
        address = 1; 
        write_en = 1; 
        data_in = data_out; 
        read_en = 0;
        write_en = 1; 
        #10;
        write_en = 0; 
        #10; 
        
        //Subtraction ALU function select line
        Select_Fn = 2'b01; 
        #10; 
        Select_Fn = 2'bZZ;
         
        #10; 
        address = 2; 
        read_en = 1;
        #10; 
        address = 11; 
        write_en = 1; 
        data_in = data_out; 
        read_en = 0;
        write_en = 1; 
        #10;
        write_en = 0; 
        #10;
        
        //5. Subtraction R8 - R4 = R12
        //R8 to R0 
        address = 8; 
        read_en = 1;
        #10; 
        address = 0; 
        write_en = 1; 
        data_in = data_out; 
        read_en = 0;
        write_en = 1; 
        #10;
        write_en = 0; 
        #10;
        
        //R4 to R1
        address = 4; 
        read_en = 1;
        #10; 
        address = 1; 
        write_en = 1; 
        data_in = data_out; 
        read_en = 0;
        write_en = 1; 
        #10;
        write_en = 0; 
        #10; 
        
        
        // Select bit 0 for R0 + R1 
        Select_Fn = 2'b01; 
        #10;
        Select_Fn = 2'bZZ;
        #10;
        
        //R2 to R12 
        address = 2; 
        read_en = 1;
        #10; 
        address = 12; 
        write_en = 1; 
        data_in = data_out; 
        read_en = 0;
        write_en = 1; 
        #10; 
         write_en = 0; 
        #10; 
        
        //6. Increment
        //Increment the R12 value
        //R12 to R0
        
        address = 12; 
        read_en = 1;
        #10; 
        address = 0; 
        write_en = 1; 
        data_in = data_out; 
        read_en = 0;
        write_en = 1; 
        #10; 
        write_en = 0; 
        #10;
        
        Select_Fn = 2'b11; //INCREMENT ALU function select line          
        #10;
        Select_Fn = 2'bZZ;
        #10;    
        
        // Move R2 to R12 
        address = 2; 
        read_en = 1;
        #10; 
        address = 12; 
        write_en = 1; 
        data_in = data_out; 
        read_en = 0;
        write_en = 1; 
        #10; 
        write_en = 0; 
        #10; 
        
        //7. Compare
        //Move R6 to R5 
        address = 6; 
        read_en = 1;
        #10; 
        address = 5; 
        write_en = 1; 
        data_in = data_out; 
        read_en = 0;
        write_en = 1; 
        #10;
        write_en = 0; 
        #10;
        
        Select_Fn = 2'b10;  //COMPARING ALU function select line  
        #10;
        Select_Fn = 2'bZZ;
        #10;
         
        
        // 8. Subraction R4 - R4 => R13 
        address = 4; 
        read_en = 1;
        #10;     
        address = 0; 
        write_en = 1; 
        data_in = data_out; 
        read_en = 0;
        write_en = 1; 
        #10;
        write_en = 0;  
        #10;
        
        ///    
        Select_Fn = 2'b01; // ALU Subtraction operation 
        #10;
        Select_Fn = 2'bZZ; // ALU Subtraction operation 
        #10;
        
        //R2 to R13
        address = 2; 
        read_en = 1;
        #10;     
        address = 13; 
        write_en = 1; 
        data_in = data_out; 
        read_en = 0;
        write_en = 1; 
        #10;
        write_en = 0;  
        #10;
                
        //10. Largest from R5-R10
        //Value in R4 and R5
        //Move R15 to R4
        address = 15; 
        read_en = 1;
        #10;     
        address = 4; 
        write_en = 1; 
        data_in = data_out; 
        read_en = 0;
        write_en = 1; 
        #10;
        write_en = 0;  
        #10;
        
        //Move R6 to R5
        address = 6; 
        read_en = 1;
        #10;     
        address = 5; 
        write_en = 1; 
        data_in = data_out; 
        read_en = 0;
        write_en = 1; 
        #10;
        write_en = 0;  
        #10;
        
        Select_Fn = 2'b10; //COMPARING ALU function select line 
        #10;
        Select_Fn = 2'bZZ; 
        #10;
        
        //Move R15 to R4 but both values are same
        //Move R8 TO r5
        address = 8; 
        read_en = 1;
        #10;     
        address = 5; 
        write_en = 1; 
        data_in = data_out; 
        read_en = 0;
        write_en = 1; 
        #10;
        write_en = 0;  
        #10;
        
        Select_Fn = 2'b10; //COMPARING ALU function select line 
        #10;
        Select_Fn = 2'bZZ; 
        #10;
        
       
        //Move R9 to R5
        address = 9; 
        read_en = 1; 
        #10;     
        address = 5; 
        write_en = 1; 
        data_in = data_out; 
        read_en = 0; 
        write_en = 1; 
        #10;
        write_en = 0; 
        #10;
        
        Select_Fn = 2'b10; //COMPARING ALU function select line 
        #10;
        Select_Fn = 2'bZZ;
        #10;
        
        //Move R10 to R5
        address = 10; 
        read_en = 1; 
        #10;     
        address = 5; 
        write_en = 1; 
        data_in = data_out; 
        read_en = 0; 
        write_en = 1; 
        #10;
        write_en = 0; 
        #10;
        
        Select_Fn = 2'b10; //COMPARING ALU function select line 
        #10;
        Select_Fn = 2'bZZ;
        #10;
        
        address = 15; 
        read_en = 1; 
        #10;     
        address = 13; 
        write_en = 1; 
        data_in = data_out; 
        read_en = 0; 
        write_en = 1; 
        #10;
        write_en = 0; 
        #10;
        


    $finish; 

 end 

endmodule 
