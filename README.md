# CAD_P1
Our project is P1 - Pipelined 32 bit & 64 bit signed integer Multiplier

Bluespec SystemVerilog (BSV), contains two components:
1. "Module file" contains the hardware description of a module written in Bluespec. It defines the implementation of the hardware component, 

2. "Testbench file"contains the logic for verifying the functionality of a Bluespec module. It includes code to create instances of the module, apply inputs, and observe outputs during simulation.

We have done the signed multiplication for 5 cases:
    Case 1: Both multiplicand and multiplier are positive.
    Case 2: Multiplicand is negative, and the multiplier is positive.
    Case 3: Both multiplicand and multiplier are negative.
    Case 4: Multiplicand is positive, and the multiplier is negative.
    Case 5: Handles the case when both multiplicand and multiplier are negative or both are positive.
This Bluespec SystemVerilog code implements a 32-bit signed multiplier using two's complement arithmetic. The MultiplierIfc interface defines methods for starting the multiplication and retrieving the result. The module mkbit_signed_multiplier contains various registers to store operands, results, and intermediate values. The start method performs multiplication based on the signs of the input operands, using bitwise operations and two's complement conversion. It handles four cases: positive multiplicand/multiplier, negative multiplicand, negative multiplier, and both negative multiplicand/multiplier. The result is stored in the productResult register, which is returned by the getResult method.

Description of the code:

1. Interface Definition (MultiplierIfc):

    MultiplierIfc is an interface with two methods:
        start: Takes two 32-bit input values (multiplicand and multiplier) and initiates the multiplication process.
        getResult: Retrieves the 64-bit result of the multiplication.

2. Module Definition (mkbit_signed_multiplier):

    The module takes an instance of MultiplierIfc as a parameter.

3. Registers:

    Registers are declared to store intermediate values during the multiplication process, such as multiplicand64, bitmultiplier, productReg, productResult, multiplicand_twos, multiplier_twos, and variables.

4. Multiplication Logic:

    The start method calculates the product of the input multiplicand and multiplier based on their signed values using a case-based         approach.
    Four cases are considered based on the sign bits of multiplicand and multiplier.
    The multiplication is performed using a loop, where the product is accumulated based on the bits of the multiplier.

5. Result Handling:

    The result of the multiplication is stored in productResult.
    For negative results, two's complement is used to handle signed multiplication.

Note:

    The code uses the zeroExtend function to extend the width of the multiplicand.
 
Default Case:

    If none of the specified cases match, the result is set to 0.
    
6. Output
   The output is obtained (returned).

   TESTBENCH:
   
      1. Package necessary, and modules and interfaces for the testbench are included.

    2. Testbench Module 
        Begins the instance of the multiplier (dut).
        The test rule initializes test values for the multiplicand and multiplier.
        The dut.start method initiates the multiplication, followed by a delay (mkDelay) for simulation purposes.
        The result is obtained using dut.getResult().
        The multiplication result is displayed, and the simulation is finished.

    3. Test Procedure (rule test):
        Test values for multiplicand and multiplier are specified in binary format.
        The multiplier is started with these values, introducing a delay for simulation.
        The result is obtained & displayed.

    4. Product Result Display:
        The multiplication result is displayed using $display with a formatted string showing the multiplicand, multiplier, and the result.
