class scoreboard extends uvm_scoreboard;

	`uvm_component_utils(scoreboard)

	function new(string name="scoreboard",uvm_component parent);
		super.new(name,parent);
	endfunction

endclass
