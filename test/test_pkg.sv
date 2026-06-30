package test_pkg;

	import uvm_pkg::*;
	
	`include "uvm_macros.svh"

		
	`include "ahb_config.sv"
	`include "axi_config.sv"
	`include "mstr_config.sv"
	`include "slv_config.sv"
	`include "env_config.sv"

	`include "mstr_xtn.sv"
	`include "mstr_seq.sv"
	`include "mstr_seqr.sv"
	`include "mstr_drv.sv"
	`include "mstr_mon.sv"
	`include "mstr_agent.sv"
	`include "mstr_agent_top.sv"

	
	//`include "slv_xtn.sv"
	`include "slv_seq.sv"
	`include "slv_seqr.sv"
	`include "slv_drv.sv"
	`include "slv_mon.sv"
	`include "slv_agent.sv"
	`include "slv_agent_top.sv"	

	`include "ahb_xtn.sv"
	`include "ahb_seq.sv"
	`include "ahb_seqr.sv"
	`include "ahb_drv.sv"
	`include "ahb_mon.sv"
	`include "ahb_agent.sv"
	`include "ahb_agent_top.sv"	

	`include "axi_xtn.sv"
	`include "axi_seq.sv"
	`include "axi_seqr.sv"
	`include "axi_drv.sv"
	`include "axi_mon.sv"
	`include "axi_agent.sv"
	`include "axi_agent_top.sv"	


	`include "scoreboard.sv"
	`include "env.sv"
	`include "test.sv"


endpackage
