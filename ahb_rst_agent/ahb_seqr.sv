class ahb_rst_seqr extends uvm_sequencer #(ahb_rst_xtn);

	`uvm_component_utils(ahb_rst_seqr)
	ahb_rst_config	a_cfg;

	function new (string name = "ahb_rst_seqr" ,uvm_component parent);
		super.new(name,parent);
	endfunction

	/*function void build_phase(uvm_phase phase);
		super.build_phase(phase);

	if(!uvm_config_db #(ahb_rst_config)::get(this,"","ahb_rst_config",a_cfg))
		`uvm_fatal("AGETNT CONFIG","cannot getting");
	endfunction*/
	
endclass
