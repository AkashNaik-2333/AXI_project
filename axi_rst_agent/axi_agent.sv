class axi_rst_agent extends uvm_agent;

	`uvm_component_utils(axi_rst_agent)
	
	axi_rst_drv	axi_rst_drvh;
	axi_rst_mon 	axi_rst_monh;
	axi_rst_seqr 	axi_rst_seqrh;

	axi_rst_config x_cfg;

//	env_config	env_cfg;

	function new(string name = "axi_rst_agent", uvm_component parent);
		super.new(name ,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
    $display("I am in the build phase");
			
		if(!uvm_config_db #(axi_rst_config) :: get(this,"","axi_rst_config",x_cfg))
			`uvm_fatal("MSTR CONFIG ","cannot get() a_cfg from uvm_config_db")

		axi_rst_monh=axi_rst_mon::type_id::create("axi_rst_monh",this);

		if(x_cfg.is_active == UVM_ACTIVE)
			begin
			axi_rst_drvh= axi_rst_drv::type_id::create("axi_rst_drvh",this);

			axi_rst_seqrh=axi_rst_seqr::type_id::create("axi_rst_seqrh",this);
		end
	endfunction

	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		
		if(x_cfg.is_active == UVM_ACTIVE)
		begin
			axi_rst_drvh.seq_item_port.connect(axi_rst_seqrh.seq_item_export);
		end
	endfunction



endclass

