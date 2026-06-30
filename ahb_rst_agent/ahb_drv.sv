class ahb_rst_drv extends uvm_driver #(ahb_rst_xtn);

	`uvm_component_utils(ahb_rst_drv)

	virtual ahb_rst_if.AHB_RST_DRV_MP avif;
	virtual	 ahb_if.AHB_DRV_MP svif;

	ahb_rst_config	a_cfg;
	slv_config 	s_cfg;
	ahb_rst_xtn	axtn;



	function new (string name = "ahb_rst_drv" ,uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db #(ahb_rst_config)::get(this,"","ahb_rst_config",a_cfg))
			`uvm_fatal("AHB_RST_DRIVER_AGETNT CONFIG","cannot getting")

		if(!uvm_config_db #(slv_config)::get(this,"","slv_config",s_cfg))
			`uvm_fatal("SLAVE_DRIVER_AGETNT CONFIG","cannot getting")

	`uvm_info(get_type_name(),"ahb_rst_driver build_phase",UVM_HIGH)

	endfunction

	function void connect_phase(uvm_phase phase);
		avif=a_cfg.avif;
		svif=s_cfg.svif;

	endfunction

	task run_phase(uvm_phase phase);
		forever
			begin
				seq_item_port.get_next_item(req);
				send_to_dut(req);
				seq_item_port.item_done();
			end
	endtask

	task send_to_dut(ahb_rst_xtn axtn);

		@(avif.ahb_rst_drv_cb);
		avif.ahb_rst_drv_cb.hresetn<=axtn.hresetn;
		svif.ahb_drv_cb.hready<=1'b1;
		@(avif.ahb_rst_drv_cb);
		@(avif.ahb_rst_drv_cb);
		svif.ahb_drv_cb.hready<=1'b0;
	
		avif.ahb_rst_drv_cb.hresetn<=1'b1;
		@(avif.ahb_rst_drv_cb);

	endtask
		
	
endclass
