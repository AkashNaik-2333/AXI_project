class axi_rst_config extends uvm_object;
	
	`uvm_object_utils(axi_rst_config)

	uvm_active_passive_enum is_active = UVM_ACTIVE;
	virtual axi_rst_if xvif;
	//virtual axi_if mvif;

	function new(string name = "axi_rst_config");
		super.new(name);
	endfunction

endclass
