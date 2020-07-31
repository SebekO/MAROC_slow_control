module transmitter(
    input clk, //5MHz clock in
    input state, //rst signal for set new data
    input rst,
    
    //frame bits:
    //3 bits data
    input on_off_otabg,
    input on_off_dac, 
    input small_dac,
    // 2x 10 bits data
    input [9:0] dac2,
    input [9:0] dac1,
    //4 bits data
    input enb_outadc,
    input inv_startcmptgray,
    input ramp_8bit,
    input ramp_10bit,
    // 128 bits mask
    input [127:0] mask_or_ch,
    //input [63:0] mask_or1_ch,
    //34 bits global configuration data
    input cmd_ck_mux,
    input d1_d2,
    input inv_discriadc,
    input polar_discri,
    input enb_tristate,
    input valid_dc_fsb2,
    input sw_fsb2_50f,
    input sw_fsb2_100f,
    input sw_fsb2_100k,
    input sw_fsb2_50k,
    input valid_dc_fs,
    input cmd_fsb_fsu,
    input sw_fsb1_50f,
    input sw_fsb1_100f,
    input sw_fsb1_100k,
    input sw_fsb1_50k,
    input sw_fsu_100k,
    input sw_fsu_50k,
    input sw_fsu_25k,
    input sw_fsu_40f,
    input sw_fsu_20f,
    input h1h2_choice,
    input en_adc,
    input sw_ss_1200f,
    input sw_ss_600f,
    input sw_ss_300f,
    input on_off_ss,
    input swb_buf_2p,
    input swb_buf_1p,
    input swb_buf_500f,
    input swb_buf_250f,
    input cmd_fsb,
    input cmd_ss,
    input cmd_fsu,
    //576 bits gain data
    input [575:0] gain, //[7:0][63:0] + [63:0]cmd_sum
    //64 bits ctest data
    input [63:0] ctest_ch,
    
    output reg d_sc, //series output bits
    output reg rstn_sc,
    output reg ck_out //5MHz clock out
); 

reg [828:0] d_sc_buff = 0; //bufor for data frame

always @(posedge clk, posedge rst) begin //for every clk signal we sending one bit to maroc
	if(rst) begin
		rstn_sc = 1;
		d_sc_buff = 0;
		#50
		rstn_sc = 0;
    end
	else begin
		if(state) begin
			d_sc_buff[0] <= on_off_otabg;
			d_sc_buff[1] <= on_off_dac;
			d_sc_buff[2] <= small_dac;
			d_sc_buff[12:3] <= dac2[9:0];
			d_sc_buff[22:13] <= dac1[9:0];
			d_sc_buff[23] <= enb_outadc;
			d_sc_buff[24] <= inv_startcmptgray;
			d_sc_buff[25] <= ramp_8bit;
			d_sc_buff[26] <= ramp_10bit;
			d_sc_buff[154:27] <= mask_or_ch[127:0];
			d_sc_buff[155] <= cmd_ck_mux;
			d_sc_buff[156] <= d1_d2;
			d_sc_buff[157] <= inv_discriadc;
			d_sc_buff[158] <= polar_discri;
			d_sc_buff[159] <= enb_tristate;
			d_sc_buff[160] <= valid_dc_fsb2;
			d_sc_buff[161] <= sw_fsb2_50f;
			d_sc_buff[162] <= sw_fsb2_100f;
			d_sc_buff[163] <= sw_fsb2_100k;
			d_sc_buff[164] <= sw_fsb2_50k;
			d_sc_buff[165] <= valid_dc_fs;
			d_sc_buff[166] <= cmd_fsb_fsu;
			d_sc_buff[167] <= sw_fsb1_50f;
			d_sc_buff[168] <= sw_fsb1_100f;
			d_sc_buff[169] <= sw_fsb1_100k;
			d_sc_buff[170] <= sw_fsb1_50k;
			d_sc_buff[171] <= sw_fsu_100k;
			d_sc_buff[172] <= sw_fsu_50k;
			d_sc_buff[173] <= sw_fsu_25k;
			d_sc_buff[174] <= sw_fsu_40f;
			d_sc_buff[175] <= sw_fsu_20f;
			d_sc_buff[176] <= h1h2_choice;
			d_sc_buff[177] <= en_adc;
			d_sc_buff[178] <= sw_ss_1200f;
			d_sc_buff[179] <= sw_ss_600f;
			d_sc_buff[180] <= sw_ss_300f;
			d_sc_buff[181] <= on_off_ss;
			d_sc_buff[182] <= swb_buf_2p;
			d_sc_buff[183] <= swb_buf_1p;
			d_sc_buff[184] <= swb_buf_500f;
			d_sc_buff[185] <= swb_buf_250f;
			d_sc_buff[186] <= cmd_fsb;
			d_sc_buff[187] <= cmd_ss;
			d_sc_buff[188] <= cmd_fsu;
			d_sc_buff[764:189] <= gain[575:0];
			d_sc_buff[828:765] <= ctest_ch[63:0];
		end			
		else begin
			d_sc <= d_sc_buff[0]; //data is shifted out least-significant bit first
			d_sc_buff[827:0] <= d_sc_buff[828:1]; //shift next bit into place
		end
    end
end
endmodule
