class axi_rst_seq extends uvm_sequence #(axi_rst_xtn);

	`uvm_object_utils(axi_rst_seq)
	//axi_rst_config	x_cfg;
	
	rand bit aresetn;

	function new (string name = "axi_rst_seq");
		super.new(name);
	endfunction

endclass
class axi_rst_seq1 extends axi_rst_seq;

	`uvm_object_utils(axi_rst_seq1)

	function new(string name = "axi_rst_seq1");
		super.new(name);
	endfunction

	task body();
		req=axi_rst_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {aresetn==1'b0;});
		finish_item(req);
	endtask
endclass
