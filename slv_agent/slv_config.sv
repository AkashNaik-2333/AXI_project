class slv_config extends uvm_object;
	
	`uvm_object_utils(slv_config)

	uvm_active_passive_enum is_active = UVM_ACTIVE;
	virtual ahb_if svif;
	virtual ahb_rst_if avif;

	function new(string name = "slv_config");
		super.new(name);
	endfunction

endclass
