package Multb1;

import Connectable::*;
import bit_signed_multiplier_case1::*;

// Define a testbench module
module mkTestbench(Empty);
  // Instantiate the multiplier module
  MultiplierIfc dut <- mkbit_signed_multiplier();

  // Test procedure
  rule test;
    // Test values
    let multiplicand = 1101; // Example value (1101 in binary)
    let multiplier = 1010;   // Example value (1010 in binary)

    // Start the multiplication
    dut.start((multiplicand), (multiplier));

    // Wait for a while (simulation time)
   //mkDelay(10);

    // Get the result
    let result = dut.getResult();

    $display("Multiplication Result: %0d x %0d = %0d", multiplicand, multiplier, (result));
    $finish;
  endrule

endmodule

endpackage

