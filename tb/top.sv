module top;

	import uvm_pkg::*;
	import	test_pkg::*;

	`include "uvm_macros.svh"

	bit aclock1 ;
	always #5 aclock1 = ~aclock1;

	bit aclock2;
	always #10 aclock2 = ~aclock2;
	
	bit hclock1;
	always #5 hclock1 = ~hclock1;
	
	bit hclock2;
	always #10 hclock2 = ~hclock2;
	

	axi_if 		 in0(aclock1);
	axi_rst_if	 in1(aclock2);
	ahb_if 		 in2(hclock1);
	ahb_rst_if 	 in3(hclock2);

	axi2ahb_bridge_top DUT(.aclk(aclock1),
			.aresetn(in0.aresetn),
			.hclk(hclock1),
			.hresetn(in2.hresetn),

	//axi side
	//aw channel
			.awid(in0.awid),
			.awaddr(in0.awaddr),
			.awlen(in0.awlen),
			.awsize(in0.awsize),
			.awburst(in0.awburst),
			.awvalid(in0.awvalid),
			.awready(in0.awready),
	//w channel
			.wid(in0.wid),
			.wdata(in0.wdata),
			.wstrb(in0.wstrb),
			.wlast(in0.wlast),
			.wvalid(in0.wvalid),
			.wready(in0.wready),
	//ar channel
			.arid(in0.arid),
			.araddr(in0.araddr),
			.arlen(in0.arlen),
			.arsize(in0.arlen),
			.arburst(in0.arburst),
			.arvalid(in0.arvalid),
			.arready(in0.arready),
	//b response
			.bid(in0.bid),
			.bresp(in0.bresp),
			.bvalid(in0.bvalid),
			.bready(in0.bready),
	//r response
			.rid(in0.rid),
			.rdata(in0.rdata),
			.rresp(in0.rresp),
			.rlast(in0.rlast),
			.rvalid(in0.rvalid),
			.rready(in0.rready),

	//ahb_side
	//ahb output
			.haddr(in2.haddr),
			.htrans(in2.htrans),
			.hwrite(in2.hwrite),
			.hsize(in2.hsize),
			.hburst(in2.hburst),
			.hwdata(in2.hwdata),
			.hbusreq(in2.hbusreq),
			.hlock(in2.hlock),
	//ahb input
			.hrdata(in2.hrdata),
			.hready(in2.hready),
			.hresp(in2.hresp),
			.hgrant(in2.hgrant),
			.hmaster(in2.hmaster));


	initial
		begin
			uvm_config_db #(virtual axi_if)::set(null,"*","axi_if",in0);
			uvm_config_db #(virtual axi_rst_if)::set(null,"*","axi_rst_if",in1);
			uvm_config_db #(virtual ahb_if)::set(null,"*","ahb_if",in2);
			uvm_config_db #(virtual ahb_rst_if)::set(null,"*","ahb_rst_if",in3);

			run_test();
		end
endmodule
