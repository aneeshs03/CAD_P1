package PipelinedsignedMultiplier;

//  Interface for 32-bit signed multiplier
interface SignedMulInterface;
  method Action start(Int#(32) multiplicand, Int#(32) multiplier);
  method Action done();
  method Int#(64) getResult();
endinterface

// Pipelined signed multiplier definition
module mkPipelinedSignedMultiplier (SignedMulInterface);
  // Pipeline registers
  Reg#(Int#(32)) multiplicandReg <- mkReg(0);
  Reg#(Int#(32)) multiplierReg <- mkReg(0);
  Reg#(Int#(64)) prodReg <- mkReg(0);

  // Control signals for pipeline stages
  Reg#(Bool) startStage <- mkReg(True);
  Reg#(Bool) multiplyStage <- mkReg(False);
  Reg#(Bool) accumulateStage <- mkReg(False);

  // Rule used for pipeline stages: Multiplication and Accumulation
// Consolidated rule for pipeline stages: Multiply and Accumulate
rule processStages;
  if (startStage) begin
    startStage <= False;
    multiplyStage <= True;  // Move to the multiplication stage

  end else if (multiplyStage) begin
    // Stage 1: Multiply
    multiplyStage <= False;
    productReg <= extend(multiplicandReg) * extend(multiplierReg);
    accumulateStage <= True;  // Move to the accumulation stage

  end else if (accumulateStage) begin
    // Stage 2: Accumulate
    accumulateStage <= False;
    productReg <= productReg + ((zeroExtend(multiplicandReg) << 32) >> 32);
  end
endrule

  // Interface to indicate the end of computation
  method Action done();
    accumulateStage <= False;
  endmethod

  // Method to get the result
  method Int#(64) getResult();
    return productReg;
  endmethod

  // Method to start the multiplication  method Action start(Int#(32) multiplicand, Int#(32) multiplier);
   // Reset pipeline registers
    multiplicandReg <= multiplicand;
    multiplierReg <= multiplier;
    productReg <= 0;
    startStage <= True;
    multiplyStage <= False;
    accumulateStage <= False;
  endmethod

endmodule
endpackage

