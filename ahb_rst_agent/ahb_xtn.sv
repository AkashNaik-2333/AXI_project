class ahb_rst_xtn extends uvm_sequence_item ;
	
	`uvm_object_utils(ahb_rst_xtn)

	rand bit hresetn;
	
	bit htrans;
	bit hready;

	
	function  new(string name = "ahb_rst_xtn");
		super.new(name);
	endfunction

	function void do_print(uvm_printer printer);
		super.do_print(printer);
		printer.print_field("hresetn",this.hresetn,1,UVM_DEC);
		printer.print_field("htrans",this.htrans,1,UVM_DEC);
		printer.print_field("hready",this.hready,1,UVM_DEC);
	endfunction

endclass
