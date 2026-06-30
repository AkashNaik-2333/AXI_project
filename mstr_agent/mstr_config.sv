class mstr_config extends uvm_object;
	
	`uvm_object_utils(mstr_config)

	uvm_active_passive_enum is_active = UVM_ACTIVE;
	virtual axi_if mvif;
	virtual axi_rst_if xvif;	

	function new(string name = "mstr_config");
		super.new(name);
	endfunction

endclass
