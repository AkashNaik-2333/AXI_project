class mstr_mon extends uvm_monitor;
	
	`uvm_component_utils(mstr_mon)
	mstr_config	m_cfg;

	function new(string name = "mstr_mon", uvm_component parent);
		super.new(name,parent);
	endfunction

	
	/*function void build_phase(uvm_phase phase);
	super.build_phase(phase);

	if(!uvm_config_db #(mstr_config)::get(this,"","mstr_config",m_cfg))
	`uvm_fatal("AGETNT CONFIG","cannot getting");
	endfunction*/
	


endclass
