class ahb_rst_mon extends uvm_monitor ; //#(mstr_xtn);

	`uvm_component_utils(ahb_rst_mon)
	
	virtual ahb_rst_if.AHB_RST_MON_MP avif;
	virtual	 ahb_if.AHB_MON_MP svif;
	
	uvm_analysis_port #(ahb_rst_xtn) amon_port;
	
	ahb_rst_config	a_cfg;
	slv_config	s_cfg;
	ahb_rst_xtn 	axtn;
	

	function new (string name = "ahb_rst_mon" ,uvm_component parent);
		super.new(name,parent);
		amon_port=new("amon_port",this);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db #(ahb_rst_config)::get(this,"","ahb_rst_config",a_cfg))
			`uvm_fatal("AHB_RST_MON_AGETNT CONFIG","cannot getting")

		if(!uvm_config_db #(slv_config)::get(this,"","slv_config",s_cfg))
			`uvm_fatal("SLAVE_MON_AGETNT CONFIG","cannot getting")
	endfunction

	function void connect_phase(uvm_phase phase );
		super.connect_phase(phase);
		avif=a_cfg.avif;
		svif=s_cfg.svif;
	endfunction

	task run_phase(uvm_phase phase);
		forever
			//begin
				collect_data();
		//	end
	endtask

	task collect_data();
		//axtn=ahb_rst_xtn::type_id::create("axtn");

		ahb_rst_xtn axtn;
		axtn=ahb_rst_xtn::type_id::create("axtn");


		wait(avif.ahb_rst_mon_cb.hresetn==0);
		
		@(avif.ahb_rst_mon_cb);
		axtn.hresetn=avif.ahb_rst_mon_cb.hresetn;
		
		axtn.htrans=svif.ahb_mon_cb.htrans;
		axtn.hready=svif.ahb_mon_cb.hready;
	
		@(avif.ahb_rst_mon_cb);
		amon_port.write(axtn);
		`uvm_info("AHB_MON",$sformatf("printing from mon \n %s",axtn.sprint),UVM_LOW)

	//	axtn.print();
	endtask
	
	
endclass
