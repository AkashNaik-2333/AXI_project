class env_config extends uvm_object;

	`uvm_object_utils(env_config);
	
	mstr_config 	m_cfg[];
	slv_config	s_cfg[];

	ahb_rst_config	a_cfg[];
	axi_rst_config 	x_cfg[];

	int no_of_mstr_agent;
	int no_of_slv_agent;
	int no_of_ahb_rst_agent;
	int no_of_axi_rst_agent;
	
	bit has_scoreboard;
	bit has_mstr_agent;
	bit has_slv_agent;
	bit has_ahb_rst_agent;
	bit has_axi_rst_agent;

	function new(string name = "env_config");
		super.new(name);
	endfunction
endclass
