class mstr_drv extends uvm_driver #(mstr_xtn);

	`uvm_component_utils(mstr_drv)

	mstr_xtn mxtn;
	mstr_xtn q1[$],q2[$],q3[$],q4[$],q5[$];

	semaphore sem1=new();
	semaphore sem2=new();
	semaphore sem3=new(1);
	semaphore sem4=new(1);
	semaphore sem5=new(1);

	semaphore sem6=new();
	semaphore sem7=new(1);
	semaphore sem8=new(1);

	mstr_config	m_cfg;
	axi_rst_config	x_cfg;

	virtual axi_if.AXI_DRV_MP mvif;
	virtual axi_rst_if.AXI_RST_DRV_MP xvif;
	

	function new (string name = "msrt_drv" ,uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db #(mstr_config)::get(this,"","mstr_config",m_cfg))
			`uvm_fatal(get_type_name(),"configuration cannot getting mstr driver");
	/*	if(!uvm_config_db #(axi_rst_config)::get(this,"","axi_rst_config",x_cfg))
			`uvm_fatal(get_type_name(),"configuration cannot gettingin axi rst driver");*/

	endfunction
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		mvif=m_cfg.mvif;
		//xvif=x_cfg.xvif;
	endfunction

	task run_phase(uvm_phase phase);
		forever
		begin
			seq_item_port.get_next_item(req);
			send_to_dut(req);
			`uvm_info(get_type_name(),$sformatf("axi_trans :\n %p",req.sprint()),UVM_LOW)
			seq_item_port.item_done();
		end
		`uvm_info(get_type_name(),"mstr driver run_phase",UVM_HIGH)
	endtask

	task send_to_dut(mstr_xtn mxtn);
		q1.push_back(mxtn);
		q2.push_back(mxtn);
		q3.push_back(mxtn);
		q4.push_back(mxtn);
		q5.push_back(mxtn);
		fork
			begin
				sem3.get(1);
				write_adress_channel(q1.pop_front());
				sem1.put(1);
				sem3.put(1);
			end
			begin
				sem4.get(1);
				sem1.get(1);
				write_data_channel(q2.pop_front());
				sem2.put(1);
				sem4.put(1);
			end
			begin
				sem5.get(1);
				sem2.get(1);
				write_response_channel(q3.pop_front());
				sem5.put(1);
			end
			begin
				sem7.get(1);
				read_address_channel(q4.pop_front());
				sem6.put(1);
				sem7.put(1);
			end
			begin
				sem8.get(1);
				sem6.get(1);
				read_data_channel(q5.pop_front());
				sem8.put(1);
			end
		join_any
	endtask

	task write_address_channel(mstr_xtn mxtn);
		@(mvif.axi_drv_cb);
		begin
			mvif.axi_drv_cb.awvalid<=mxtn.awvalid;
			mvif.axi_drv_cb.awid<=mxtn.awid;
			mvif.axi_drv_cb.awaddr<=mxtn.awaddr;
			mvif.axi_drv_cb.awlen<=mxtn.awlen;
			mvif.axi_drv_cb.awsize<=mxtn.awsize;
			mvif.axi_drv_cb.awburst<=mxtn.awburst;
			@(mvif.axi_drv_cb);

			wait(mvif.axi_drv_cb);
			mvif.axi_drv_cb.awvalid<=1'b0;
			repeat(xtn.delay_cycles)
			@(mvif.axi_drv_cb);
		end
	endtask

	task write_data_chennel(mstr_xtn mxtn);
		begin
			foreach(mxtn.wdata[i])
			begin
				mvif.axi_drv_cb.wavalid<=mxtn.wvalid;
				mvif.axi_drv_cb.wid<=mxtn.wid;
				mvif.axi_drv_cb.wdata<=xtn.wdata[i];
				mvif.axi_drv_cb.wstrb<=xtn.mxtn.wstrb[i];
				if(i==(mxtn.awlen))
					mvif.axi_drv_cb.wlast<=1'b1;
				else
					mvif.axi_drv_cb.wlast<=1'b0;
				wait(mvif.axi_drv_cb.wready)
				@(mvif.axi_drv_cb);
				mvif.axi_drv_cb.wvalid<=1'b0;
				mvif.axi_drv_cb.wlast<=1'b0;
				@(mvif.axi_drv_cb);
				repeat(mxtn.delay_cycles)
				@(mvif.axi_drv_cb);

			end
		end
	endtask
	task write_response_channel(mstr_xtn mxtn);
		mvif.axi_drv_cb.bready<=1'b1;
		wait(vif.axi_drv_cb.bvalid)
		mvif.axi_drv_cb.bready<=1'b0;
		repeat(mxtn.delay_cycles)
		@(mvif.axi_drv_cb);
	endtask

	task read_address_channel(mstr_xtn mxtn);
		begin
		@(mvif.axi_drv_cb);
		mvif.axi_drv_cb.arvalid<=mxtn.arvalid;
		mvif.axi_drv_cb.aresetn<=mxtn.aresetn;
		mvif.axi_drv_cb.arid<=mxtn.arid;
		mvif.axi_drv_cb.araddr<=mxtn.araddr;
		mvif.axi_drv_cb.arlen<=mxtn.arlen;
		mvif.axi_drv_cb.arsize<=mxtn.arsize;
		mvif.axi_drv_cb.arburst<=mxtn.arburst;
		wait(mvi.axi_drv_cb.arready)
		@(mvif.axi_drv_cb);
		mvif.axi_drv_cb.arvalid<=1'b0;
		repeat(mxtn.delay_cycles)
		@(vif.axi_drv_cb);
		end
	endtask

	task read_data_channel(mstr_xtn mxtn);
		repeat(mvif.axi_drv_cb.arlen+1'b1)
		begin
			@(mstr.axi_drv_cb);
			mvif.axi_drv_cb.rready<=1'b1;
			wait(mvif.axi_drv_cb.rvalid)
			@(mvif.axi_drv_cb);
			mvif_axi_drv_cb.rready<=1'b0;
			repeat(mxtn.axi_drv_cb);
		end
	endtask


			

			

endclass
