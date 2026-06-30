class axi_rst_mon extends uvm_monitor ;//mstr_xtn);

	`uvm_component_utils(axi_rst_mon)
	virtual axi_rst_if.AXI_RST_MON_MP xvif;
	virtual axi_if.AXI_MON_MP mvif;

	uvm_analysis_port #(axi_rst_xtn)xmon_port;	

	axi_rst_config	x_cfg;
	mstr_config 	m_cfg;
	axi_rst_xtn	 xtn;
	
	function new (string name = "axi_rst_mon" ,uvm_component parent);
		super.new(name,parent);
		xmon_port=new("xmon_port",this);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db #(axi_rst_config)::get(this,"","axi_rst_config",x_cfg))
			`uvm_fatal("AXI_RST_MON_AGETNT","cannot getting")
		if(!uvm_config_db #(mstr_config)::get(this,"","mstr_config",m_cfg))
			`uvm_fatal("AXI_MON_AGENT","cannot getting from database")
	endfunction
	

	function void connect_phase(uvm_phase phase);
		xvif=x_cfg.xvif;
		mvif=m_cfg.mvif;
	endfunction

	task run_phase(uvm_phase phase);
	//	xtn=axi_rst_xtn::type_id::create("xtn");
		forever
			//begin
				collect_data();
		//	end
	endtask
	
	task collect_data();
	axi_rst_xtn xtn;
	xtn=axi_rst_xtn::type_id::create("xtn");
		$display("inside reset axi monitor");
		wait(xvif.axi_rst_mon_cb.aresetn==0)
		@(xvif.axi_rst_mon_cb);
		xtn.aresetn=xvif.axi_rst_mon_cb.aresetn;
		xtn.bvalid=mvif.axi_mon_cb.bvalid;
		xtn.rvalid=mvif.axi_mon_cb.rvalid;

		@(xvif.axi_rst_mon_cb);
		
		xmon_port.write(xtn);
	$display("inside reset axi2 monitor");
		`uvm_info("AXI_MON",$sformatf("printing from mon \n %s",xtn.sprint),UVM_LOW)
		//xtn.print();

	endtask
		
endclass
