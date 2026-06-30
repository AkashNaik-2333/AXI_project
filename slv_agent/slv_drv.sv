class slv_drv extends uvm_driver ; //#(mstr_xtn);

	`uvm_component_utils(slv_drv)
	slv_config	s_cfg;

	function new (string name = "slv_drv" ,uvm_component parent);
		super.new(name,parent);
	endfunction

	/*function void build_phase(uvm_phase phase);
		super.build_phase(phase);

	if(!uvm_config_db #(slv_config)::get(this,"","slv_config",s_cfg))
		`uvm_fatal("AGETNT CONFIG","cannot getting");
	endfunction*/
	
endclass
