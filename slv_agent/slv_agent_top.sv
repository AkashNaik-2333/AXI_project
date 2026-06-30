class slv_agent_top extends uvm_env;

	`uvm_component_utils(slv_agent_top)
	slv_agent 	slv_agenth[];
	env_config	env_cfg;
	
	slv_config	s_cfg;

	function new(string name = "slv_agent_top",uvm_component parent);
		super.new(name,parent);

	endfunction

	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db #(env_config)::get(this,"","env_config",env_cfg))
			`uvm_fatal("ENV CONFIG","cannot getting the config")
		
		slv_agenth=new[env_cfg.no_of_slv_agent];
		foreach(slv_agenth[i])
		begin
			uvm_config_db #(slv_config)::set(this,$sformatf("slv_agenth[%0d]*",i),"slv_config",env_cfg.s_cfg[i]);
			
			slv_agenth[i]=slv_agent::type_id::create($sformatf("slv_agenth[%0d]",i),this);
		end
	endfunction

	

endclass
