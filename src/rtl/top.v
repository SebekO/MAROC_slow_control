module transmitter(
  input clk_in, //5MHz clock in
  input reset_in,
  input start_in,

  //frame bits:
  //3 bits data
  input ON_OFF_otabg_in,
  input ON_OFF_dac_in, 
  input small_dac_in,
  // 2x 10 bits data
  input [9:0] DAC2_in,
  input [9:0] DAC1_in,
  //4 bits data
  input enb_outADC_in,
  input inv_startCmptGray_in,
  input ramp_8bit_in,
  input ramp_10bit_in,
  // 128 bits mask
  input [127:0] mask_OR_ch_in,
  //input [63:0] mask_OR1_ch_in,
  //34 bits global configuration data
  input cmd_CK_mux_in,
  input d1_d2_in,
  input inv_discriADC_in,
  input polar_discri_in,
  input Enb_tristate_in,
  input valid_dc_fsb2_in,
  input sw_fsb2_50f_in,
  input sw_fsb2_100f_in,
  input sw_fsb2_100k_in,
  input sw_fsb2_50k_in,
  input valid_dc_fs_in,
  input cmd_fsb_fsu_in,
  input sw_fsb1_50f_in,
  input sw_fsb1_100f_in,
  input sw_fsb1_100k_in,
  input sw_fsb1_50k_in,
  input sw_fsu_100k_in,
  input sw_fsu_50k_in,
  input sw_fsu_25k_in,
  input sw_fsu_40f_in,
  input sw_fsu_20f_in,
  input H1H2_choice_in,
  input EN_ADC_in,
  input sw_ss_1200f_in,
  input sw_ss_600f_in,
  input sw_ss_300f_in,
  input ON_OFF_ss_in,
  input swb_buf_2p_in,
  input swb_buf_1p_in,
  input swb_buf_500f_in,
  input swb_buf_250f_in,
  input cmd_fsb_in,
  input cmd_ss_in,
  input cmd_fsu_in,
  //576 bits gain data
  input [575:0] GAIN_in, //[63:0][7:0] + [63:0]cmd_SUM
  //64 bits ctest data
  input [63:0] Ctest_ch_in,

  output reg D_SC_out, //series output bits
  output reg RSTn_SC_out,
  output CK_SC_out, //5MHZ clock out
  output [1:0] state_out //state of machine
); 

  localparam IDLE = 0;
  localparam PREPARE_TO_SEND = 1;
  localparam SENDING = 2;
  localparam FINAL = 3;

  reg [9:0] ctr;
  reg [1:0] state;
  reg [1:0] nstate;

  reg start_send;
  reg clear_ctr;
  reg set_data;
  reg send_succes;

  reg [828:0] d_sc_buff = 0; //buffer for data frame
  reg [828:0] d_sc_buff2 = 0; //buffer for data frame

  always @* begin
    set_data = 0;
    start_send = 0;
    clear_ctr = 0;
    RSTn_SC_out = 1;

    case(state)
    IDLE: begin
      if(start_in) begin
        nstate = PREPARE_TO_SEND;
      end
      else begin
        nstate = IDLE;
      end
    end
    PREPARE_TO_SEND: begin
      RSTn_SC_out = 0;
      set_data = 1;
      nstate = SENDING;
    end
    SENDING: begin
      set_data = 0;
      start_send = 1;

      if(send_succes) begin
        nstate = FINAL;
      end
      else begin
        nstate = SENDING;
      end
    end
    FINAL: begin
      clear_ctr = 1;

      if(start_in) begin
        clear_ctr = 0;
        nstate = PREPARE_TO_SEND;
      end
      else begin
        nstate = FINAL;
      end
    end
    default: begin
      nstate = IDLE;
    end
    endcase
  end

  always @(posedge clk_in, posedge reset_in) begin
    if(reset_in) begin
      state <= IDLE;
    end
    else begin 
      state <= nstate;
    end
  end

  assign state_out = state;
  assign CK_SC_out = clk_in;

  always @(posedge clk_in, posedge reset_in) begin //for every clk signal we sending one bit to maroc
    if(reset_in) begin
      d_sc_buff <= 0;
    end
    else begin
      if(start_in) begin
        d_sc_buff[0] <= ON_OFF_otabg_in;
        d_sc_buff[1] <= ON_OFF_dac_in;
        d_sc_buff[2] <= small_dac_in;
        d_sc_buff[12:3] <= DAC2_in[9:0];
        d_sc_buff[22:13] <= DAC1_in[9:0];
        d_sc_buff[23] <= enb_outADC_in;
        d_sc_buff[24] <= inv_startCmptGray_in;
        d_sc_buff[25] <= ramp_8bit_in;
        d_sc_buff[26] <= ramp_10bit_in;
        d_sc_buff[154:27] <= mask_OR_ch_in[127:0];
        d_sc_buff[155] <= cmd_CK_mux_in;
        d_sc_buff[156] <= d1_d2_in;
        d_sc_buff[157] <= inv_discriADC_in;
        d_sc_buff[158] <= polar_discri_in;
        d_sc_buff[159] <= Enb_tristate_in;
        d_sc_buff[160] <= valid_dc_fsb2_in;
        d_sc_buff[161] <= sw_fsb2_50f_in;
        d_sc_buff[162] <= sw_fsb2_100f_in;
        d_sc_buff[163] <= sw_fsb2_100k_in;
        d_sc_buff[164] <= sw_fsb2_50k_in;
        d_sc_buff[165] <= valid_dc_fs_in;
        d_sc_buff[166] <= cmd_fsb_fsu_in;
        d_sc_buff[167] <= sw_fsb1_50f_in;
        d_sc_buff[168] <= sw_fsb1_100f_in;
        d_sc_buff[169] <= sw_fsb1_100k_in;
        d_sc_buff[170] <= sw_fsb1_50k_in;
        d_sc_buff[171] <= sw_fsu_100k_in;
        d_sc_buff[172] <= sw_fsu_50k_in;
        d_sc_buff[173] <= sw_fsu_25k_in;
        d_sc_buff[174] <= sw_fsu_40f_in;
        d_sc_buff[175] <= sw_fsu_20f_in;
        d_sc_buff[176] <= H1H2_choice_in;
        d_sc_buff[177] <= EN_ADC_in;
        d_sc_buff[178] <= sw_ss_1200f_in;
        d_sc_buff[179] <= sw_ss_600f_in;
        d_sc_buff[180] <= sw_ss_300f_in;
        d_sc_buff[181] <= ON_OFF_ss_in;
        d_sc_buff[182] <= swb_buf_2p_in;
        d_sc_buff[183] <= swb_buf_1p_in;
        d_sc_buff[184] <= swb_buf_500f_in;
        d_sc_buff[185]  <=  swb_buf_250f_in;
        d_sc_buff[186]  <=  cmd_fsb_in;
        d_sc_buff[187]  <=  cmd_ss_in;
        d_sc_buff[188]  <=  cmd_fsu_in;
        d_sc_buff[764:189]  <=  GAIN_in[575:0];
        d_sc_buff[828:765] <= Ctest_ch_in[63:0];
      end
      else begin
        d_sc_buff <= d_sc_buff;
      end
    end
  end
  
  always @(posedge clk_in, posedge reset_in) begin //shift register
    if(reset_in) begin
      d_sc_buff2 <= 0;
    end
    else begin
      if(set_data) begin
        d_sc_buff2 <= d_sc_buff;
      end
      else if (start_send && !set_data) begin
        D_SC_out <= d_sc_buff2[0]; //data is shifted out least-significant bit first
        d_sc_buff2[827:0] <= d_sc_buff2[828:1];
        //d_sc_buff2 <= {0, d_sc_buff2[828:1]}; //shift next bit into place
      end
      else begin
        d_sc_buff2 <= d_sc_buff2;
      end
    end
  end  

  always @(posedge clk_in, posedge reset_in) begin //counter
    if(reset_in) begin
      ctr <= 0;
    end
    else begin
      send_succes <= 0;
      
      if((ctr < 828) && start_send) begin
        ctr <= ctr + 1; 
      end
      else if((ctr >= 828) && start_send) begin
        send_succes <= 1;
      end
      else if(clear_ctr) begin
        ctr <= 0;
      end
      else begin
        ctr <= ctr;
      end
    end
  end
  
endmodule
