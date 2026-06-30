 interface axi_rst_if(input bit aclock);
   logic aresetn;
   clocking axi_rst_drv_cb @(posedge aclock);
     default input #1 output #1;
     output aresetn;
   endclocking
   clocking axi_rst_mon_cb @(posedge aclock);
     default input #1 output #1;
     input aresetn;
   endclocking
   modport AXI_RST_DRV_MP(clocking axi_rst_drv_cb);
   modport AXI_RST_MON_MP(clocking axi_rst_mon_cb);
 endinterface
