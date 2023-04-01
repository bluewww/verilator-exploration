// SPDX-License-Identifier: MIT
// Author: Robert Balas <balasr@iis.ee.ethz.ch>

// Test verilator 5 timing features

module hello (
);
    logic clk;
    logic rst_n;

    initial begin
        rst_n = 1'b0;
        #100ns;
        rst_n = 1'b1;
        #100ns;

        forever begin
            clk = !clk;
            #5ns;
            $display("clk @%t ns counter=%d", $realtime, counter_q);
        end
    end

    initial begin
        $display("hello world!");
    end

    initial begin
        $dumpfile("hello.fst");
        $dumpvars;
    end

    always_comb begin
        if (counter_q > 10000)
            $finish;
    end

    logic [31:0] counter_q, counter_d;

    always_comb begin
        counter_d = counter_q + 32'h1;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            counter_q <= '0;
        end else begin
            counter_q <= counter_d;
        end

    end
endmodule // hello
