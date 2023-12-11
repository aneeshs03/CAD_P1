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
