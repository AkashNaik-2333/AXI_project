class ahb_rst_config extends uvm_object;
	
	`uvm_object_utils(ahb_rst_config)

	uvm_active_passive_enum is_active = UVM_ACTIVE;
	virtual ahb_rst_if avif;
	//virtual ahb_if svif;
	
	function new(string name = "ahb_rst_config");
		super.new(name);
	endfunction

endclass
