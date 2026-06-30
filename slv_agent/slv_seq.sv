class slv_seq extends uvm_sequence ; //#(mstr_xtn) ;
	
	`uvm_object_utils(slv_seq)

	function new (string name = "slv_seq");
		super.new(name);
	endfunction
	
endclass
