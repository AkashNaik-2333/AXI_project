class axi_rst_agent_top extends uvm_env;

	`uvm_component_utils(axi_rst_agent_top)
	axi_rst_agent 	axi_rst_agenth[];
	env_config	env_cfg;
	
	axi_rst_config	x_cfg;
	mstr_config	m_cfg;
	function new(string name = "axi_rst_agent_top",uvm_component parent);
		super.new(name,parent);

	endfunction

	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db #(env_config)::get(this,"","env_config",env_cfg))
			`uvm_fatal("ENV CONFIG","cannot getting the config")
		
		axi_rst_agenth=new[env_cfg.no_of_axi_rst_agent];
		foreach(axi_rst_agenth[i])
		begin
			uvm_config_db #(axi_rst_config)::set(this,$sformatf("axi_rst_agenth[%0d]*",i),"axi_rst_config",env_cfg.x_cfg[i]);

	

			uvm_config_db #(mstr_config)::set(this,$sformatf("axi_rst_agenth[%0d]*",i),"mstr_config",env_cfg.m_cfg[i]);
			axi_rst_agenth[i]=axi_rst_agent::type_id::create($sformatf("axi_rst_agenth[%0d]",i),this);
		
//		//	mstr_agenth[i]=mstr_agent::type_id::create($sformatf("mstr_agenth[%0d]",i),this);

		end
	endfunction
endclass
