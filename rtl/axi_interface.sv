 interface axi_if(input bit clock);
   logic aresetn;
   //aw channel
   logic [7:0] awid;
   logic [31:0] awaddr;
   logic [7:0] awlen;
   logic [2:0] awsize;
   logic [1:0] awburst;
   logic awvalid;
   logic awready;
   //w channel
   logic [7:0] wid;
   logic [63:0] wdata;
   logic [7:0] wstrb;
   logic wlast;
   logic wvalid;
   logic wready;
   //ar channel
   logic [7:0] arid;
   logic [31:0] araddr;
   logic [7:0] arlen;
   logic [2:0] arsize;
   logic [1:0] arburst;
   logic arvalid;
   logic arready;
   //b response
   logic [7:0] bid;
   logic [1:0] bresp;
   logic bvalid;
   logic bready;
   //r response
   logic [7:0] rid;
   logic [63:0] rdata;
   logic [1:0] rresp;
   logic rlast;
   logic rvalid;
   logic rready;
   clocking axi_drv_cb @(posedge clock);
     default input #1 output #1;
     output aresetn;
     output		awid;
     output		awaddr;
     output		awlen;
     output		awsize;
     output		awburst;
     output	awvalid;
     input 	awready;
     output		wid;
     output		wdata;
     output		wstrb;
     output	wlast;
     output	wvalid;
     input 	wready;
     output		arid;
     output		araddr;
     output		arlen;
     output		arsize;
     output		arburst;
     output	arvalid;
     input	arready;
     input 		bid;
     input 		bresp;
     input 	bvalid;
     output	bready;
     input		rid;
     input	rdata;
     input	rlast;
     input	rvalid;
     input 	rresp;
     output 	rready;
   endclocking
   clocking axi_mon_cb @(posedge clock);
     default input #1 output #1;
     input aresetn;
     input    awid;
     input    awaddr;
     input     awlen;
     input     awsize;
     input     awburst;
     input  awvalid;
     input   awready;
     input     wid;
     input    wdata;
     input     wstrb;
     input  wlast;
     input  wvalid;
     input   wready;
     input    arid;
     input    araddr;
     input     arlen;
     input     arsize;
     input     arburst;
     input  arvalid;
     input   arready;
     input      bid;
     input      bresp;
     input   bvalid;
     input  bready;
     input      rid;
     input     rdata;
     input   rlast;
     input   rvalid;
     input 	rresp;
     input  rready;
   endclocking
   modport AXI_DRV_MP (clocking axi_drv_cb);
   modport AXI_MON_MP (clocking axi_mon_cb);





function logic [7:0] strobe(input logic [2:0] awsize);
        case (awsize)
            2'b00: strobe = 'b0000_0001 || 'b0000_0010 || 'b0000_0100 || 'b0000_1000 || 'b0001_0000 || 'b0010_0000 || 'b0100_0000 || 'b1000_0000;
            2'b01: strobe = 'b0000_0011 || 'b0000_1100 || 'b0011_0000 || 'b1100_0000; 
            2'b10: strobe = 'b0000_1111 || 'b1111_0000;
	    2'b11: strobe = 'b11111111;
            default: strobe = 'b0000; //Invalid 
        endcase
endfunction


 property stb_cal1;

	@(posedge clock) (wvalid) |=> if(awburst==0)
						$stable(wstrb)
						else (wstrb==strobe(awsize)[->1]);

endproperty

STRB: assert property(stb_cal1)
		else $display("STRB","STRB assertion is not passing");

/*
   property awvalid_awready;
   @(posedge clock) (awvalid && !awready) |=> awvalid;
   endproperty 
  
   property wvalid_wready;
   @(posedge clock) (wvalid && !wready) |=> wvalid;
   endproperty 
   
   property arvalid_arready;
   @(posedge clock) (arvalid && !arready) |=> arvalid;
   endproperty 


   assert property (awvalid_awready);
  // assert property (wvalid_wready);
   assert property (arvalid_arready);
*/
/*
   property bvalid_bready;
   @(posedge clock) (bvalid && !bready) |=> bvalid;
   endproperty 
*/

   property rvalid_rready;
   @(posedge clock) (rvalid && !rready) |=> rvalid;
   endproperty 

  // assert property (bvalid_bready);
   assert property (rvalid_rready);


/*
property wlast_check;
@(posedge clock) wlast |-> (wvalid)&&(!wready) |=> wvalid;
endproperty
*/

property rlast_check;
@(posedge clock) rlast |-> (rvalid)&&(!rready) |=> rvalid;
endproperty

//assert property (wlast_check);
assert property (rlast_check);


property R_wrap_type;
 @(posedge clock) (arburst==2)|->(arsize==1) |-> araddr%2==0;
endproperty

property R_wrap_type1;
 @(posedge clock)  (arburst==2)|->(arsize==2) |-> araddr%4==0;
endproperty

property W_wrap_type;
 @(posedge clock)  (awburst==2)|->(awsize==1) |-> awaddr%2==0;
endproperty 

property W_wrap_type1;
 @(posedge clock) (awburst==2)|-> (awsize==2) |-> awaddr%4==0;
endproperty

assert property (R_wrap_type);
assert property (R_wrap_type1);
assert property (W_wrap_type);
assert property (W_wrap_type1);




	



  property aw_valid;
        @(posedge clock) $rose(awvalid) |-> ( $stable(awid)   
                                            &&$stable(awaddr)
                                            &&$stable(awlen)
                                            &&$stable(awsize) 
                                            &&$stable(awburst)) until awready[->1];
    endproperty

    // Property to check whether all write address channel remains stable after awvalid is asserted
    property w_valid;
        @(posedge clock) $rose(wvalid) |-> (  $stable(wid) 
                                            && $stable(wdata)
                                            && $stable(wstrb)
                                            && $stable(wlast)) until wready[->1];
    endproperty

    // Property to check whether all write address channel remains stable after awvalid is asserted
    property b_valid;
        @(posedge clock) $rose(bvalid) |-> (  $stable(bid) 
                                            && $stable(bresp)) until bready[->1];
    endproperty

    // Property to check whether all write address channel remains stable after awvalid is asserted
    property ar_valid;
        @(posedge clock) $rose(arvalid) |-> ( $stable(arid)   
                                            &&$stable(araddr)
                                            &&$stable(arlen)
                                            &&$stable(arsize) 
                                            &&$stable(arburst)) until arready[->1];
    endproperty

    // Property to check whether all write address channel remains stable after awvalid is asserted
    property r_valid;
        @(posedge clock) $rose(rvalid) |-> (  $stable(rid) 
                                            && $stable(rdata)
                                            && $stable(rresp)
                                            && $stable(rlast)) until rready[->1];
    endproperty

    assert property (aw_valid);
    assert property (w_valid);
    assert property (b_valid);
    assert property (ar_valid);
    assert property (r_valid);



 endinterface
