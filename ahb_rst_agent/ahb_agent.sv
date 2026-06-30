class ahb_rst_agent extends uvm_agent;

	`uvm_component_utils(ahb_rst_agent)
	
	ahb_rst_drv	ahb_rst_drvh;
	ahb_rst_mon 	ahb_rst_monh;
	ahb_rst_seqr 	ahb_rst_seqrh;

	ahb_rst_config a_cfg;
	slv_config	s_cfg;

//	env_config	env_cfg;

	function new(string name = "ahb_rst_agent", uvm_component parent);
		super.new(name ,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
    $display("I am in the build phase");
			
		if(!uvm_config_db #(ahb_rst_config) :: get(this,"","ahb_rst_config",a_cfg))
			`uvm_fatal("AHB_RST_AGENT CONFIG ","cannot get() a_cfg from uvm_config_db")

		/*if(!uvm_config_db #(slv_config) :: get(this,"","slv_config",s_cfg))
			`uvm_fatal("AHB_AGENT CONFIG ","cannot get() a_cfg from uvm_config_db")*/

	
		ahb_rst_monh=ahb_rst_mon::type_id::create("ahb_rst_monh",this);

		if(a_cfg.is_active == UVM_ACTIVE)
			begin
			ahb_rst_drvh= ahb_rst_drv::type_id::create("ahb_rst_drvh",this);

			ahb_rst_seqrh=ahb_rst_seqr::type_id::create("ahb_rst_seqrh",this);
		end
	endfunction

	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		
		if(a_cfg.is_active == UVM_ACTIVE)
		begin
			ahb_rst_drvh.seq_item_port.connect(ahb_rst_seqrh.seq_item_export);
		end
	endfunction



endclass

