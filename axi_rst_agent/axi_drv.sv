class axi_rst_drv extends uvm_driver #(axi_rst_xtn);

	`uvm_component_utils(axi_rst_drv)
	
	virtual axi_rst_if.AXI_RST_DRV_MP xvif;
	virtual axi_if.AXI_DRV_MP mvif;

	axi_rst_config	x_cfg;
	mstr_config 	m_cfg;
	axi_rst_xtn 	xtn;

	function new (string name = "axi_rst_drv" ,uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

	if(!uvm_config_db #(axi_rst_config)::get(this,"","axi_rst_config",x_cfg))
		`uvm_fatal("AXI_RST_DRV_AGETNT","cannot getting")
	if(!uvm_config_db #(mstr_config)::get(this,"","mstr_config",m_cfg))
		`uvm_fatal("AXI_DRV_AGENT","cannot getting from database")

	endfunction

	function void connect_phase(uvm_phase phase);
		xvif=x_cfg.xvif;
		mvif=m_cfg.mvif;
	endfunction


	task run_phase(uvm_phase phase);
	forever
		begin
	//	$display("inside reset axi drv");

			seq_item_port.get_next_item(req);
			send_to_dut(req);
			seq_item_port.item_done();
		end
	endtask

	task send_to_dut(axi_rst_xtn xtn);
	//$display("inside reset axi driver");

		@(xvif.axi_rst_drv_cb);
		xvif.axi_rst_drv_cb.aresetn<= xtn.aresetn;

		@(xvif.axi_rst_drv_cb);
		@(xvif.axi_rst_drv_cb);
		xvif.axi_rst_drv_cb.aresetn<=1'b1;
		//`uvm_info("AXI_drv",$sformatf("printing from drv \n %s",xtn.sprint),UVM_LOW)

	endtask
endclass
