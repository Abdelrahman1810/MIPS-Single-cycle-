module BranchTargetAddress(
    input signed [31:0] PCadderResult, SignExtendOut,
    output signed [31:0] BranchTarget
);
    assign BranchTarget = (SignExtendOut << 2) + PCadderResult;
endmodule