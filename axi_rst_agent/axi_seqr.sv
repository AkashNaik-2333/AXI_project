class axi_rst_seqr extends uvm_sequencer #(axi_rst_xtn);

	`uvm_component_utils(axi_rst_seqr)
	axi_rst_config	x_cfg;

	function new (string name = "axi_rst_seqr" ,uvm_component parent);
		super.new(name,parent);
	endfunction

	/*function void build_phase(uvm_phase phase);
		super.build_phase(phase);

	if(!uvm_config_db #(axi_rst_config)::get(this,"","axi_rst_config",x_cfg))
		`uvm_fatal("AGETNT CONFIG","cannot getting");
	endfunction*/
	
endclass
