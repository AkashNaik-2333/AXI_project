class mstr_agent extends uvm_agent;

	`uvm_component_utils(mstr_agent)
	
	mstr_drv	mstr_drvh;
	mstr_mon 	mstr_monh;
	mstr_seqr 	mstr_seqrh;

	mstr_config m_cfg;

//	env_config	env_cfg;

	function new(string name = "mstr_agent", uvm_component parent);
		super.new(name ,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
    $display("I am in the build phase");
			
		if(!uvm_config_db #(mstr_config) :: get(this,"","mstr_config",m_cfg))
			`uvm_fatal("MSTR CONFIG ","cannot get() m_cfg from uvm_config_db")

		mstr_monh=mstr_mon::type_id::create("mstr_monh",this);

		if(m_cfg.is_active == UVM_ACTIVE)
			begin
			mstr_drvh= mstr_drv::type_id::create("mstr_drvh",this);

			mstr_seqrh=mstr_seqr::type_id::create("mstr_seqrh",this);
		end
	endfunction

	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		
		if(m_cfg.is_active == UVM_ACTIVE)
		begin
			mstr_drvh.seq_item_port.connect(mstr_seqrh.seq_item_export);
		end
	endfunction



endclass
			
			
