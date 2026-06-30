class mstr_xtn extends uvm_sequence_item ;
	
	`uvm_object_utils(mstr_xtn)

	rand bit aresetn;
	rand bit [7:0] awid;
	rand bit [31:0] awaddr;
	rand bit [7:0] awlen;
	rand bit [2:0] awsize;
	rand bit [1:0] awburst;
	rand bit awvalid;
	bit awready;

	rand bit [7:0] wid;
	rand bit [63:0] wdata[];
	bit [7:0] wstrb[];
	bit wlast;
	rand bit wvalid;
	bit wready;

	rand bit [7:0] arid;
	rand bit [31:0] araddr;
	rand bit [7:0] arlen;
	rand bit [2:0] arsize;
	rand bit [1:0] arburst;
	rand bit arvalid;
	bit arready;

	bit [7:0] bid;
	bit [1:0] bresp;
	bit bvalid;
	bit bready;

	bit [7:0] rid;
	bit [63:0] rdata[];
	bit [1:0] rresp;
	bit rlast;
	bit rvalid;
	bit rready;
	bit [63:0] temp_wdata;
	bit [63:0] temp_rdata;

	int delay_cycles;

	constraint write_id_c {awid == wid; bid==wid;}
	constraint read_id_c {rid == arid;}
	constraint arburst_c {arburst inside{0,1,2};}
	constraint awvurst_c {awburst inside{0,1,2};}

	constraint arsize_c {arsize inside {0,1,2,3};}
	constraint awsize_c {awsize inside {0,1,2,3};}
	
	constraint write_align {((awburst ==2'b10)&& awsize==1) -> awaddr%2==0;}
	constraint write_align2 {((awburst ==2'b10)&& awsize==2) -> awaddr%4==0;}
	constraint write_align3 {((awburst ==2'b10)&& awsize==3) -> awaddr%8==0;}

	constraint read_align {((arburst ==2'b10)&& arsize==1) -> araddr%2==0;}
	constraint read_align2 {((arburst ==2'b10)&& arsize==2) -> araddr%4==0;}
	constraint read_align3 {((arburst ==2'b10)&& arsize==3) -> araddr%8==0;}


	constraint wdat_c {wdata.size==awlen+1;}
	
	function  new(string name = "mstr_xtn");
		super.new(name);
	endfunction

	function void post_randomize();
	
	int j=0;
	bit [31:0] start_address = awaddr;
	int number_of_bytes = 2**awsize;
	int burst_length=awlen+1;

	bit[31:0] aligned_address = (start_address/number_of_bytes)*number_of_bytes;
	wstrb = new[awlen+1];

	for (int i=(start_address%8);i<((aligned_address%8)+number_of_bytes);i++)
	begin
 		wstrb[j][i]=1'b1;
	end

	for(int l=1; l<burst_length;l++)
	begin
		aligned_address=aligned_address+number_of_bytes;
		j++;
		for(int k = (aligned_address%8);k<((aligned_address%8)+number_of_bytes);k++)
		wstrb[j][k]=1'b1;
	end

	endfunction

	function void do_print(uvm_printer printer);
	//	super.do_print();
		printer.print_field("aresetn",this.aresetn,1,UVM_DEC);
                printer.print_field("awid",this.awid,8,UVM_DEC);
                printer.print_field("awaddr",this.awaddr,32,UVM_DEC);
                printer.print_field("awlen",this.awlen,8,UVM_DEC);
                printer.print_field("awsize",this.awsize,3,UVM_DEC);
                printer.print_field("awburst",this.awburst,2,UVM_DEC);
                printer.print_field("awvalid",this.awvalid,1,UVM_DEC);
                printer.print_field("awready",this.awready,1,UVM_DEC);

                printer.print_field("wid",this.wid,8,UVM_DEC);
              //  printer.print_field("wdata",this.wdata,64,UVM_DEC);
                printer.print_field("wstrb",this.wstrb,8,UVM_DEC);
                printer.print_field("wlast",this.wlast,1,UVM_DEC);
                printer.print_field("wvalid",this.wvalid,1,UVM_DEC);
                printer.print_field("wready",this.wready,1,UVM_DEC);

                printer.print_field("bid",this.bid,8,UVM_DEC);
                printer.print_field("bresp",this.bresp,2,UVM_DEC);
                printer.print_field("bvalid",this.bvalid,1,UVM_DEC);
                printer.print_field("bready",this.bready,1,UVM_DEC);
                printer.print_field("arid",this.arid,8,UVM_DEC);
                printer.print_field("araddr",this.araddr,32,UVM_DEC);
                printer.print_field("arlen",this.arlen,8,UVM_DEC);
                printer.print_field("arsize",this.arsize,3,UVM_DEC);
                printer.print_field("arburst",this.arburst,2,UVM_DEC);
                printer.print_field("arvalid",this.arvalid,1,UVM_DEC);
                printer.print_field("arready",this.arready,1,UVM_DEC);
                printer.print_field("rid",this.rid,8,UVM_DEC);

		foreach(rdata[i])
                printer.print_field($sformatf("rdata[%0d]",i),this.rdata[i],64,UVM_DEC);
                printer.print_field("rlast",this.rlast,1,UVM_DEC);
		foreach(rresp[i])
                printer.print_field($formatf("rresp[%0d]",i),this.rreso[i],2,UVM_DEC);
                printer.print_field("rvalid",this.rvalid,1,UVM_DEC);
                printer.print_field("rready",this.rready,1,UVM_DEC);

	endfunction

endclass
