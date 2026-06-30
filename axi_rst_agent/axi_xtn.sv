class axi_rst_xtn extends uvm_sequence_item ;
	
	`uvm_object_utils(axi_rst_xtn)

	rand bit aresetn;
	
	bit bvalid;
	bit rvalid;
	
	function  new(string name = "axi_rst_xtn");
		super.new(name);
	endfunction

	function void do_print(uvm_printer printer);
		super.do_print(printer);   
		printer.print_field("aresetn",this.aresetn,1,UVM_DEC);
		printer.print_field("bvalid",this.bvalid,1,UVM_DEC);
		printer.print_field("rvalid",this.rvalid,1,UVM_DEC);

	endfunction

endclass
