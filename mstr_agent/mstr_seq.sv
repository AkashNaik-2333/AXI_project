class mstr_seq extends uvm_sequence #(mstr_xtn) ;
	
	`uvm_object_utils(mstr_seq)

	function new (string name = "mstr_seq");
		super.new(name);
	endfunction
	
endclass

class axi_write_seq extends mstr_seq;

	`uvm_object_utils(axi_write_seq)
	
	env_config env_cfg;

	function new(string name = "axi_write_seq" );
		super.new(name);
	endfunction

	task body();
		req= mstr_xtn::type_id::create("req");
	/*	if(!uvm_config_db #(env_config)::get(null,get_full_name,"env_config",env_cfg))
			`uvm_fatal(get_type_name, "configuration failed in axi sequence")*/
		
		
		
		start_item(req);
		assert(req.randomize() with { awvalid==1;wvalid==1;});
		finish_item(req);
	endtask
endclass

class axi_read_seq extends mstr_seq;

	`uvm_object_utils(axi_read_seq)

	function new(string name = "axi_read_seq" );
		super.new(name);
	endfunction

	task body();
		req= mstr_xtn::type_id::create("req");
		
		start_item(req);
		assert(req.randomize() with { arvalid==1;});
		finish_item(req);
	endtask
endclass

/*

class axi_wrap_burst extends mstr_seq;

	`uvm_object_utils(axi_wrap_burst)

	function new(string name = "axi_wrap_burst" );
		super.new(name);
	endfunction

	task body();
		req= mstr_xtn::type_id::create("req");
		
		start_item(req);
		assert(req.randomize() with { awaddr ==32'd100; araddr==32'd200; awburst==32'd300; arburst==32'd400; awlen== 8'd14; arlen==8'd17; awsize==3'd8; arsize==3'd9;});
		finish_item(req);
	endtask
endclass*/
