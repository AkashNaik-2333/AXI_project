class test extends uvm_test;
	
	`uvm_component_utils(test)

	
	mstr_config 	m_cfg[];
	slv_config	s_cfg[];
	ahb_rst_config	a_cfg[];
	axi_rst_config 	x_cfg[];
	
	env_config	env_cfg;

	int no_of_mstr_agent=1;
	int no_of_slv_agent=1;
	int no_of_ahb_rst_agent=1;
	int no_of_axi_rst_agent=1;
	
	bit has_scoreboard=1;
	bit has_mstr_agent=1;
	bit has_slv_agent=1;
	bit has_ahb_rst_agent=1;
	bit has_axi_rst_agent=1;
	
	env envh;
	
	
	function new (string name ="test",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	
	env_cfg=env_config::type_id::create("env_cfg");

	env_cfg.no_of_mstr_agent=this.no_of_mstr_agent;
	env_cfg.no_of_slv_agent=this.no_of_slv_agent;
	env_cfg.no_of_ahb_rst_agent=this.no_of_ahb_rst_agent;
	env_cfg.no_of_axi_rst_agent=this.no_of_axi_rst_agent;
	env_cfg.has_scoreboard=this.has_scoreboard;
	env_cfg.has_mstr_agent=this.has_mstr_agent;
	env_cfg.has_slv_agent=this.has_slv_agent;
	env_cfg.has_ahb_rst_agent=this.has_ahb_rst_agent;
	env_cfg.has_axi_rst_agent=this.has_axi_rst_agent;
	env_cfg.m_cfg=new[no_of_mstr_agent];
	env_cfg.s_cfg=new[no_of_slv_agent];
	env_cfg.a_cfg=new[no_of_ahb_rst_agent];
	env_cfg.x_cfg=new[no_of_axi_rst_agent];

	if(env_cfg.has_mstr_agent)
	begin
		m_cfg=new[no_of_mstr_agent];
		env_cfg.m_cfg=new[no_of_mstr_agent];
		
		foreach(m_cfg[i])
		begin
			m_cfg[i]=mstr_config::type_id::create($sformatf("m_cfg[%0d]",i));
			if(!uvm_config_db #(virtual axi_if)::get(this,"","axi_if",m_cfg[i].mvif))
				`uvm_fatal("AXI_MASTER","cannot getting from config_data")
			m_cfg[i].is_active=UVM_ACTIVE;
			env_cfg.m_cfg[i]=m_cfg[i];
		end
	end

	if(env_cfg.has_slv_agent)
	begin
		s_cfg=new[no_of_slv_agent];
		
		foreach(s_cfg[i])
		begin
			s_cfg[i]=slv_config::type_id::create($sformatf("s_cfg[%0d",i));
			if(!uvm_config_db #(virtual ahb_if)::get(this,"","ahb_if",s_cfg[i].svif))
				`uvm_fatal("AHB_MASTER","cannot getting from config_data")
			s_cfg[i].is_active=UVM_ACTIVE;
			env_cfg.s_cfg[i]=s_cfg[i];
		end
	end

	if(env_cfg.has_ahb_rst_agent)
	begin
		a_cfg=new[no_of_ahb_rst_agent];
		
		foreach(a_cfg[i])
		begin
			a_cfg[i]=ahb_rst_config::type_id::create($sformatf("a_cfg[%0d",i));
			if(!uvm_config_db #(virtual ahb_rst_if)::get(this,"","ahb_rst_if",a_cfg[i].avif))
				`uvm_fatal("AHB_RST_MASTER","cannot getting from config_data")
			a_cfg[i].is_active=UVM_ACTIVE;
			env_cfg.a_cfg[i]=a_cfg[i];
		end
	end

	if(env_cfg.has_axi_rst_agent)
	begin
		x_cfg=new[no_of_axi_rst_agent];
		
		foreach(x_cfg[i])
		begin
			x_cfg[i]=axi_rst_config::type_id::create($sformatf("x_cfg[%0d",i));
			if(!uvm_config_db #(virtual axi_rst_if)::get(this,"","axi_rst_if",x_cfg[i].xvif))
				`uvm_fatal("AXI_MASTER","cannot getting from config_data")
			x_cfg[i].is_active=UVM_ACTIVE;
			env_cfg.x_cfg[i]=x_cfg[i];
		end
	end

	uvm_config_db #(env_config)::set(this,"*","env_config",env_cfg);
	
	envh = env::type_id::create("env",this);
	endfunction

	function void end_of_elaboration_phase(uvm_phase phase);
	super.end_of_elaboration_phase(phase);
	uvm_top.print_topology();
	endfunction
	
endclass


class reset_case1 extends test;
	
	`uvm_component_utils(reset_case1)

	ahb_rst_seq1 ahb_rsth;

	axi_rst_seq1 axi_rsth;

	function new( string name = "reset_case1",uvm_component parent);
		super.new(name,parent);
	endfunction

	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		ahb_rsth= ahb_rst_seq1::type_id::create("ahb_rsth");
		axi_rsth= axi_rst_seq1::type_id::create("axi_rsth");

	endfunction

	
	task run_phase(uvm_phase phase);

		phase.raise_objection(this);
		//#100;
		begin
		axi_rsth.start(envh.axi_rst_agent_toph.axi_rst_agenth[0].axi_rst_seqrh);
		//#100;
		ahb_rsth.start(envh.ahb_rst_agent_toph.ahb_rst_agenth[0].ahb_rst_seqrh);
		end

		#50;
		phase.drop_objection(this);
	endtask
endclass
		
class axi_case extends test;

	`uvm_component_utils(axi_case)
	//ahb_rst_seq1 ahb_rsth;

	axi_write_seq axi_wr;
	axi_read_seq axi_rd;

	function new( string name = "axi_case",uvm_component parent);
		super.new(name,parent);
	endfunction

	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		axi_wr= axi_write_seq::type_id::create("axi_wr");
		axi_rd= axi_read_seq::type_id::create("axi_rd");

	endfunction

	
	task run_phase(uvm_phase phase);

		phase.raise_objection(this);
		begin
		axi_wr.start(envh.axi_agent_toph.axi_agenth[0].axi_seqrh);
	//	#100;
		axi_rd.start(envh.axi_agent_toph.axi_agenth[0].axi_seqrh);
		end
	//	#100;
		phase.drop_objection(this);
	endtask
endclass
		
