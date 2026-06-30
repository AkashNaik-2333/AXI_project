class env extends uvm_env;

	`uvm_component_utils(env)

	mstr_agent_top 		mstr_agent_toph;
	slv_agent_top		slv_agent_toph;
	ahb_rst_agent_top	ahb_rst_agent_toph;
	axi_rst_agent_top 	axi_rst_agent_toph;
	scoreboard		sb;
	env_config		env_cfg;	

	function new(string name = "env" ,uvm_component parent);
		super.new(name,parent);
	endfunction 

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		if(!uvm_config_db #(env_config)::get(this,"","env_config",env_cfg))
		`uvm_fatal("ENV CONFIG","cannot getting the config from uvm config db")

		if(env_cfg.has_scoreboard)
			sb=scoreboard::type_id::create("sb",this);
		
		mstr_agent_toph=mstr_agent_top::type_id::create("mstr_agent_toph",this);

		slv_agent_toph=slv_agent_top::type_id::create("slv_agent_toph",this);

		ahb_rst_agent_toph=ahb_rst_agent_top::type_id::create("ahb_rst_agent_top",this);
		
		axi_rst_agent_toph=axi_rst_agent_top::type_id::create("axi_rts_agent_toph",this);
		
	/*	if(env_cfg.has_mstr_agent)		
		//mstr_agenth=new[env_cfg.no_of_axi_rst_agent];
		foreach(env_cfg.x_cfg[i])
		begin
			uvm_config_db #(axi_rst_config)::set(this,$sformatf("mstr_agent_toph.axi_rst_agent_toph[%0d]*",i),"axi_rst_config",env_cfg.x_cfg[i]);

	

			uvm_config_db #(mstr_config)::set(this,$sformatf("mstr_agent_toph.mstr_agent_toph[%0d]*",i),"mstr_config",env_cfg.m_cfg[i]);
			mstr_agent_toph=mstr_agent_top::type_id::create("mstr_agent",this);
		
		end
		if(env_cfg.has_slv_agent)		
		//ahb_rst_agenth=new[env_cfg.no_of_ahb_rst_agent];
		foreach(env_cfg.a_cfg[i])
		begin
		//	uvm_config_db #(ahb_rst_config)::set(this,$sformatf("slv_agent_toph.slv_agent_toph[%0d]*",i),"ahb_rst_config",env_cfg.a_cfg[i]);

			uvm_config_db #(slv_config)::set(this,$sformatf("slv_agent_toph.slv_agent_toph[%0d]*",i),"slv_config",env_cfg.s_cfg[i]);

			slv_agent_toph=slv_agent_top::type_id::create("slv_agent_toph",this);

		end

		if(env_cfg.has_axi_rst_agent)
		//axi_rst_agenth=new[env_cfg.no_of_axi_];
		foreach(env_cfg.x_cfg[i])
		begin
			uvm_config_db #(axi_rst_config)::set(this,$sformatf("axi_rst_agent_toph.axi_rst_agent_toph[%0d]*",i),"axi_rst_config",env_cfg.x_cfg[i]);

	

			uvm_config_db #(mstr_config)::set(this,$sformatf("axi_rst_agent_toph.mstr_agent_toph[%0d]*",i),"mstr_config",env_cfg.m_cfg[i]);
			axi_rst_agent_toph=axi_rst_agent_top::type_id::create("axi_rst_agent_toph",this);

		end
		if(env_cfg.has_ahb_rst_agent)
		//axi_rst_agenth=new[env_cfg.no_of_axi_];
		foreach(env_cfg.a_cfg[i])
		begin
			uvm_config_db #(ahb_rst_config)::set(this,$sformatf("ahb_rst_agent_toph.ahb_rst_agent_toph[%0d]*",i),"ahb_rst_config",env_cfg.a_cfg[i]);

	

			uvm_config_db #(slv_config)::set(this,$sformatf("ahb_rst_agent_toph.slv_agent_toph[%0d]*",i),"slv_config",env_cfg.s_cfg[i]);
			ahb_rst_agent_toph=ahb_rst_agent_top::type_id::create("ahb_rst_agent_toph",this);
		end
		if(env_cfg.has_scoreboard)
			sb=scoreboard::type_id::create("sb",this);
*/

	


	endfunction

endclass
