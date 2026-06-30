class ahb_rst_seq extends uvm_sequence #(ahb_rst_xtn);

	`uvm_object_utils(ahb_rst_seq)
	ahb_rst_config	a_cfg;

	function new (string name = "ahb_rst_seq");
		super.new(name);
	endfunction

endclass

class ahb_rst_seq1 extends ahb_rst_seq;

	`uvm_object_utils(ahb_rst_seq1)

	function new(string name = "ahb_rst_seq1");
		super.new(name);
	endfunction

	task body();
		req=ahb_rst_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {hresetn==1'b0;});
		finish_item(req);
	endtask
endclass
