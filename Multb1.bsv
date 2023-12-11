package Multb1;

import Connectable::*;
import bit_signed_multiplier_case1::*;

// Testbench module
module mkTestbench(Empty);
  
  MultiplierIfc dut <- mkbit_signed_multiplier();

  // Test procedure
  rule test;
    // Test values
    let multiplicand = 32'b11011010101101001011100011001011; 
    let multiplier =   32'b00110111001000101100101011011010; 

    // multiplication
    dut.start((multiplicand), (multiplier));

    // Wait for a while (simulation time)
   mkDelay(10);

    // Get the result
    let result = dut.getResult();

    $display("Multiplication Result: %0d x %0d = %0d", multiplicand, multiplier, (result));
    $finish;
  endrule

endmodule

endpackage

