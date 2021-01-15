`timescale 100ns/1ns

`define BITS 4
`define SCALE 0.7

module testbench_pwldac();
integer d [0:`BITS-1];
integer i;

initial begin
	//$dumpfile("testbench.vcd");
	//$dumpvars();
	for (i = 0; i < `BITS; i = i + 1) begin
		d[i] = $fopen($sformatf("d%0dpwl.txt", i),"w");
	end
	$timeformat(0, 10, "", 0);
	#10000;
	for (i = 0; i < `BITS; i = i + 1) begin
		$fclose(d[i]);
	end
	$finish;
end

reg clk;
always begin
	clk = 0; #300;
	clk = 1; #300;
end 

reg [`BITS-1:0] cnt = 0;
reg [`BITS-1:0] cnt_prev = 0;
always @(posedge clk) begin
	cnt_prev <= cnt;
	cnt <= cnt + 1'b1;
	for (i = 0; i < `BITS; i = i + 1) begin
		$fwrite(d[i], "%t %f\n", $time*10, cnt_prev[i]*`SCALE);
		$fwrite(d[i], "%t00001 %f\n", $time*10, cnt[i]*`SCALE);
	end
end


endmodule
