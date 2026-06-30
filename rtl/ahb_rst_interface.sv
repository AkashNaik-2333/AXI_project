 interface ahb_rst_if(input bit clock);
   logic hresetn;
   clocking ahb_rst_drv_cb@(posedge clock);
     default input #1 output #1;
     output    hresetn;
   endclocking    
   clocking ahb_rst_mon_cb@(posedge clock);
     default input #1 output #1;
     input     hresetn;
   endclocking
   modport AHB_RST_DRV_MP (clocking ahb_rst_drv_cb);
   modport AHB_RST_MON_MP (clocking ahb_rst_mon_cb);
 endinterface
