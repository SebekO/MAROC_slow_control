module transmiter(
input wire CK_in, //5GHz Clock in
input wire state, //state signal for set new data
input wire rst, //rts signal for reset the register to zero

//frame bits:
//3 bits data
input wire ON_OFF_otabg,
input wire ON_OFF_dac, 
input wire small_dac,
// 2x 10 bits data
input wire [9:0] DAC2,
input wire [9:0] DAC1,
//4 bits data
input wire enb_outADC,
input wire inv_startCmptGray,
input wire ramp_8bit,
input wire ramp_10bit,
// 128 bits mask
input wire [127:0] mask_OR_ch,
//input [63:0] mask_OR1_ch,
//34 bits global configuration data
input wire cmd_CK_mux,
input wire d1_d2,
input wire inv_discriADC,
input wire polar_discri,
input wire Enb_tristate,
input wire valid_dc_fsb2,
input wire sw_fsb2_50f,
input wire sw_fsb2_100f,
input wire sw_fsb2_100k,
input wire sw_fsb2_50k,
input wire valid_dc_fs,
input wire cmd_fsb_fsu,
input wire sw_fsb1_50f,
input wire sw_fsb1_100f,
input wire sw_fsb1_100k,
input wire sw_fsb1_50k,
input wire sw_fsu_100k,
input wire sw_fsu_50k,
input wire sw_fsu_25k,
input wire sw_fsu_40f,
input wire sw_fsu_20f,
input wire H1H2_choice,
input wire EN_ADC,
input wire sw_ss_1200f,
input wire sw_ss_600f,
input wire sw_ss_300f,
input wire ON_OFF_ss,
input wire swb_buf_2p,
input wire swb_buf_1p,
input wire swb_buf_500f,
input wire swb_buf_250f,
input wire cmd_fsb,
input wire cmd_ss,
input wire cmd_fsu,
//576 bits gain data
input wire [575:0] GAIN, //[7:0][63:0] + [63:0]cmd_SUM
//64 bits ctest data
input wire [63:0] Ctest_ch,

output reg D_SC, //series output bits
output wire RSTn_SC, // >20ns reset the register to zero
output wire CK_SC //5GHZ clock out
); 
reg [828:0] D_SC_buff = 0; //bufor for data frame

always @(posedge CK_in, posedge rst) begin //for every CK_in signal we sending one bit to MAROC
	if(rst)
		RSTn_SC = 1;
		#50
		RSTn_SC = 0;
	else begin
		if(state) begin
			D_SC_buff[0] <= ON_OFF_otabg;
			D_SC_buff[1] <= ON_OFF_dac;
			D_SC_buff[2] <= small_dac;
			D_SC_buff[12:3] <= DAC2[9:0];
			D_SC_buff[22:13] <= DAC1[9:0];
			D_SC_buff[23] <= enb_outADC;
			D_SC_buff[24] <= inv_startCmptGray;
			D_SC_buff[25] <= ramp_8bit;
			D_SC_buff[26] <= ramp_10bit;
			D_SC_buff[154:27] <= mask_OR_ch[127:0];
			D_SC_buff[155] <= cmd_CK_mux;
			D_SC_buff[156] <= d1_d2;
			D_SC_buff[157] <= inv_discriADC;
			D_SC_buff[158] <= polar_discri;
			D_SC_buff[159] <= Enb_tristate;
			D_SC_buff[160] <= valid_dc_fsb2;
			D_SC_buff[161] <= sw_fsb2_50f;
			D_SC_buff[162] <= sw_fsb2_100f;
			D_SC_buff[163] <= sw_fsb2_100k;
			D_SC_buff[164] <= sw_fsb2_50k;
			D_SC_buff[165] <= valid_dc_fs;
			D_SC_buff[166] <= cmd_fsb_fsu;
			D_SC_buff[167] <= sw_fsb1_50f;
			D_SC_buff[168] <= sw_fsb1_100f;
			D_SC_buff[169] <= sw_fsb1_100k;
			D_SC_buff[170] <= sw_fsb1_50k;
			D_SC_buff[171] <= sw_fsu_100k;
			D_SC_buff[172] <= sw_fsu_50k;
			D_SC_buff[173] <= sw_fsu_25k;
			D_SC_buff[174] <= sw_fsu_40f;
			D_SC_buff[175] <= sw_fsu_20f;
			D_SC_buff[176] <= H1H2_choice;
			D_SC_buff[177] <= EN_ADC;
			D_SC_buff[178] <= sw_ss_1200f;
			D_SC_buff[179] <= sw_ss_600f;
			D_SC_buff[180] <= sw_ss_300f;
			D_SC_buff[181] <= ON_OFF_ss;
			D_SC_buff[182] <= swb_buf_2p;
			D_SC_buff[183] <= swb_buf_1p;
			D_SC_buff[184] <= swb_buf_500f;
			D_SC_buff[185] <= swb_buf_250f;
			D_SC_buff[186] <= cmd_fsb;
			D_SC_buff[187] <= cmd_ss;
			D_SC_buff[188] <= cmd_fsu;
			D_SC_buff[764:189] <= GAIN[575:0];
			D_SC_buff[828:765] <= Ctest_ch[63:0];
		end			
		else begin
			CK_SC = CK_in;
			D_SC <= D_SC_buff[0]; //data is shifted out least-significant bit first
			D_SC_buff[827:0] <= D_SC_buff[828:1]; //shift next bit into place
		end
    end
endmodule
