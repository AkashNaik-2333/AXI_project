class mstr_agent_top extends uvm_env;

	`uvm_component_utils(mstr_agent_top)
	mstr_agent 	mstr_agenth[];
	env_config	env_cfg;
	
	mstr_config	m_cfg;

	function new(string name = "mstr_agent_top",uvm_component parent);
		super.new(name,parent);

	endfunction

	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db #(env_config)::get(this,"","env_config",env_cfg))
			`uvm_fatal("ENV CONFIG","cannot getting the config")
		
		mstr_agenth=new[env_cfg.no_of_mstr_agent];
		foreach(mstr_agenth[i])
		begin
			uvm_config_db #(mstr_config)::set(this,$sformatf("mstr_agenth[%0d]*",i),"mstr_config",env_cfg.m_cfg[i]);		
			mstr_agenth[i]=mstr_agent::type_id::create($sformatf("mstr_agenth[%0d]",i),this);
		end
	endfunction

	

endclass
