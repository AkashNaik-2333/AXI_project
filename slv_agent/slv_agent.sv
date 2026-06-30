class slv_agent extends uvm_agent;

	`uvm_component_utils(slv_agent)
	
	slv_drv 	slv_drvh;
	slv_mon 	slv_monh;
	slv_seqr 	slv_seqrh;

	slv_config s_cfg;

//	env_config	env_cfg;

	function new(string name = "slv_agent", uvm_component parent);
		super.new(name ,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
    $display("I am in the build phase");
			
		if(!uvm_config_db #(slv_config) :: get(this,"","slv_config",s_cfg))
			`uvm_fatal("MSTR CONFIG ","cannot get() m_cfg from uvm_config_db")

		slv_monh=slv_mon::type_id::create("slv_monh",this);

		if(s_cfg.is_active == UVM_ACTIVE)
			begin
			slv_drvh= slv_drv::type_id::create("slv_drvh",this);

			slv_seqrh=slv_seqr::type_id::create("slv_seqrh",this);
		end
	endfunction

	
/*	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		
		if(s_cfg.is_active == UVM_ACTIVE)
		begin
			slv_drvh.seq_item_port.connect(slv_seqrh.seq_item_export);
		end
	endfunction*/



endclass
			
			
