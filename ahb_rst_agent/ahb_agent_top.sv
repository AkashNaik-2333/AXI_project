class ahb_rst_agent_top extends uvm_env;

	`uvm_component_utils(ahb_rst_agent_top)
	ahb_rst_agent 	ahb_rst_agenth[];
	env_config	env_cfg;
	
	ahb_rst_config	a_cfg;
	slv_config	s_cfg;
	function new(string name = "ahb_rst_agent_top",uvm_component parent);
		super.new(name,parent);

	endfunction

	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db #(env_config)::get(this,"","env_config",env_cfg))
			`uvm_fatal("ENV CONFIG","cannot getting the config")


	//	if(env_cfg.has_rst_agent)		
		ahb_rst_agenth=new[env_cfg.no_of_ahb_rst_agent];
		foreach(ahb_rst_agenth[i])
		begin
			uvm_config_db #(ahb_rst_config)::set(this,$sformatf("ahb_rst_agenth[%0d]*",i),"ahb_rst_config",env_cfg.a_cfg[i]);

			uvm_config_db #(slv_config)::set(this,$sformatf("ahb_rst_agenth[%0d]*",i),"slv_config",env_cfg.s_cfg[i]);

			ahb_rst_agenth[i]=ahb_rst_agent::type_id::create($sformatf("ahb_rst_agenth[%0d]",i),this);

		//	slv_agenth[i]=slv_agent::type_id::create($sformatf("slv_agenth[%0d]",i),this);


		end
	endfunction

	

endclass
