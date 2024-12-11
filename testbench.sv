module testbench();
    bit clk, rst;

    initial begin
        forever 
            #1 clk = ~clk;
    end
DataPath datapath(
    clk, rst
);

    initial begin
        $readmemh("InstructionData.dat", datapath.insMem.InstructionData);
        $readmemh("DataMemory.dat",datapath.datamem.DataMem);
        $readmemh("RegisterData.dat",datapath.regfile.regmem);

        rst = 1;
        repeat(2) @(posedge clk);
        rst = 0;
        repeat(100) @(posedge clk);

            // at the end of simulation check the folowing value:
            // Register t2 represent MAX  =>  regmem[10] = 0x00000019
            // Register t3 represent MIN  =>  regmem[11] = 0x00000001
            // Register s0 represent SUM  =>  regmem[16] = 0x0000004F   

            $display("$t2 = 0x%08h (Hex), $t2 = %032b (bin)", datapath.regfile.regmem[10], datapath.regfile.regmem[10]);
            $display("$t3 = 0x%08h (Hex), $t3 = %032b (bin)", datapath.regfile.regmem[11], datapath.regfile.regmem[11]);
        $stop;
    end
endmodule