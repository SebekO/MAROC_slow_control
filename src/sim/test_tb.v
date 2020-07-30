`timescale 1ns / 1ps
module testb();

reg CK_in; //5GHz Clock in
reg state; //rst signal for set new data
reg rst;

//3 bits data
reg ON_OFF_otabg;
reg ON_OFF_dac; 
reg small_dac;
// 2x 10 bits data
reg [9:0] DAC2;
reg [9:0] DAC1;
//4 bits data
reg enb_outADC;
reg inv_startCmptGray;
reg ramp_8bit;
reg ramp_10bit;
// 128 bits mask
reg [127:0] mask_OR_ch;
//reg [63:0] mask_OR1_ch;
// 34 bits global configuration data
reg cmd_CK_mux;
reg d1_d2;
reg inv_discriADC;
reg polar_discri;
reg Enb_tristate;
reg valid_dc_fsb2;
reg sw_fsb2_50f;
reg sw_fsb2_100f;
reg sw_fsb2_100k;
reg sw_fsb2_50k;
reg valid_dc_fs;
reg cmd_fsb_fsu;
reg sw_fsb1_50f;
reg sw_fsb1_100f;
reg sw_fsb1_100k;
reg sw_fsb1_50k;
reg sw_fsu_100k;
reg sw_fsu_50k;
reg sw_fsu_25k;
reg sw_fsu_40f;
reg sw_fsu_20f;
reg H1H2_choice;
reg EN_ADC;
reg sw_ss_1200f;
reg sw_ss_600f;
reg sw_ss_300f;
reg ON_OFF_ss;
reg swb_buf_2p;
reg swb_buf_1p;
reg swb_buf_500f;
reg swb_buf_250f;
reg cmd_fsb;
reg cmd_ss;
reg cmd_fsu;
// 576 bits gain data
//reg [63:0] cmd_SUM;
reg [575:0] GAIN; //[7:0][63:0] + [63:0]cmd_SUM
// 64 bits ctest data
reg [63:0] Ctest_ch;

wire D_SC; //series output bits
wire RSTn_SC;
wire CK_SC; //5GHZ clock out

///local data
reg [828:0] tmp_D_SC; //tmp buffor which include generated frame for comparison 
reg [828:0] read_D_SC;
reg TX_succes; //transmisiosn succes flag


transmiter uut( //prototype unit under test function
.CK_in(CK_in),
.state(state),
.rst(rst),

.ON_OFF_otabg(ON_OFF_otabg),
.ON_OFF_dac(ON_OFF_dac), 
.small_dac(small_dac),
.DAC2(DAC2),
.DAC1(DAC1),
.enb_outADC(enb_outADC),
.inv_startCmptGray(inv_startCmptGray),
.ramp_8bit(ramp_8bit),
.ramp_10bit(ramp_10bit),
.mask_OR_ch(mask_OR_ch),
.cmd_CK_mux(cmd_CK_mux),
.d1_d2(d1_d2),
.inv_discriADC(inv_discriADC),
.polar_discri(polar_discri),
.Enb_tristate(Enb_tristate),
.valid_dc_fsb2(valid_dc_fsb2),
.sw_fsb2_50f(sw_fsb2_50f),
.sw_fsb2_100f(sw_fsb2_100f),
.sw_fsb2_100k(sw_fsb2_100k),
.sw_fsb2_50k(sw_fsb2_50k),
.valid_dc_fs(valid_dc_fs),
.cmd_fsb_fsu(cmd_fsb_fsu),
.sw_fsb1_50f(sw_fsb1_50f),
.sw_fsb1_100f(sw_fsb1_100f),
.sw_fsb1_100k(sw_fsb1_100k),
.sw_fsb1_50k(sw_fsb1_50k),
.sw_fsu_100k(sw_fsu_100k),
.sw_fsu_50k(sw_fsu_50k),
.sw_fsu_25k(sw_fsu_25k),
.sw_fsu_40f(sw_fsu_40f),
.sw_fsu_20f(sw_fsu_20f),
.H1H2_choice(H1H2_choice),
.EN_ADC(EN_ADC),
.sw_ss_1200f(sw_ss_1200f),
.sw_ss_600f(sw_ss_600f),
.sw_ss_300f(sw_ss_300f),
.ON_OFF_ss(ON_OFF_ss),
.swb_buf_2p(swb_buf_2p),
.swb_buf_1p(swb_buf_1p),
.swb_buf_500f(swb_buf_500f),
.swb_buf_250f(swb_buf_250f),
.cmd_fsb(cmd_fsb),
.cmd_ss(cmd_ss),
.cmd_fsu(cmd_fsu),
.GAIN(GAIN),
.Ctest_ch(Ctest_ch),

.D_SC(D_SC),
.RSTn_SC(RSTn_SC),
.CK_SC(CK_SC)

);

initial begin 
	CK_in = 1; //set Clk to 1
	
    read_D_SC[828:0] = 0;
    tmp_D_SC[828:0] = -1;
    TX_succes = 0;
 
	rst = 1;
	#150 
	rst = 0;
	
	state = 1;
	
	$srandom(10); //generate seed for random function
    //random generating input bit state for test bench
    ON_OFF_otabg = $urandom_range(1,0);
    ON_OFF_dac =  $urandom_range(1,0);
    small_dac = $urandom_range(1,0);
    DAC2 = $urandom_range(1,0);
    DAC1 = $urandom_range(1,0);
    enb_outADC = $urandom_range(1,0);
    inv_startCmptGray = $urandom_range(1,0);
    ramp_8bit = $urandom_range(1,0);
    ramp_10bit = $urandom_range(1,0);
    mask_OR_ch = {4{$urandom}};
    cmd_CK_mux = $urandom_range(1,0);
    d1_d2 = $urandom_range(1,0);
    inv_discriADC = $urandom_range(1,0);
    polar_discri = $urandom_range(1,0);
    Enb_tristate = $urandom_range(1,0);
    valid_dc_fsb2 = $urandom_range(1,0);
    sw_fsb2_50f = $urandom_range(1,0);
    sw_fsb2_100f = $urandom_range(1,0);
    sw_fsb2_100k = $urandom_range(1,0);
    sw_fsb2_50k = $urandom_range(1,0);
    valid_dc_fs = $urandom_range(1,0);
    cmd_fsb_fsu = $urandom_range(1,0);
    sw_fsb1_50f = $urandom_range(1,0);
    sw_fsb1_100f = $urandom_range(1,0);
    sw_fsb1_100k = $urandom_range(1,0);
    sw_fsb1_50k = $urandom_range(1,0);
    sw_fsu_100k = $urandom_range(1,0);
    sw_fsu_50k = $urandom_range(1,0);
    sw_fsu_25k = $urandom_range(1,0);
    sw_fsu_40f = $urandom_range(1,0);
    sw_fsu_20f = $urandom_range(1,0);
    H1H2_choice = $urandom_range(1,0);
    EN_ADC = $urandom_range(1,0);
    sw_ss_1200f = $urandom_range(1,0);
    sw_ss_600f = $urandom_range(1,0);
    sw_ss_300f = $urandom_range(1,0);
    ON_OFF_ss = $urandom_range(1,0);
    swb_buf_2p = $urandom_range(1,0);
    swb_buf_1p = $urandom_range(1,0);
    swb_buf_500f = $urandom_range(1,0);
    swb_buf_250f = $urandom_range(1,0);
    cmd_fsb = $urandom_range(1,0);
    cmd_ss = $urandom_range(1,0);
    cmd_fsu = $urandom_range(1,0);
    GAIN = {18{$urandom}};
    Ctest_ch = {2{$urandom}};
	
    //writing state to tmp buff for later comparison
    tmp_D_SC[0] = ON_OFF_otabg;
    tmp_D_SC[1] = ON_OFF_dac;
    tmp_D_SC[2] = small_dac;
    tmp_D_SC[12:3] = DAC2[9:0];
    tmp_D_SC[22:13] = DAC1[9:0];
    tmp_D_SC[23] = enb_outADC;
    tmp_D_SC[24] = inv_startCmptGray;
    tmp_D_SC[25] = ramp_8bit;
    tmp_D_SC[26] = ramp_10bit;
    tmp_D_SC[154:27] = mask_OR_ch[127:0];
    tmp_D_SC[155] = cmd_CK_mux;
    tmp_D_SC[156] = d1_d2;
    tmp_D_SC[157] = inv_discriADC;
    tmp_D_SC[158] = polar_discri;
    tmp_D_SC[159] = Enb_tristate;
    tmp_D_SC[160] = valid_dc_fsb2;
    tmp_D_SC[161] = sw_fsb2_50f;
    tmp_D_SC[162] = sw_fsb2_100f;
    tmp_D_SC[163] = sw_fsb2_100k;
    tmp_D_SC[164] = sw_fsb2_50k;
    tmp_D_SC[165] = valid_dc_fs;
    tmp_D_SC[166] = cmd_fsb_fsu;
    tmp_D_SC[167] = sw_fsb1_50f;
    tmp_D_SC[168] = sw_fsb1_100f;
    tmp_D_SC[169] = sw_fsb1_100k;
    tmp_D_SC[170] = sw_fsb1_50k;
    tmp_D_SC[171] = sw_fsu_100k;
    tmp_D_SC[172] = sw_fsu_50k;
    tmp_D_SC[173] = sw_fsu_25k;
    tmp_D_SC[174] = sw_fsu_40f;
    tmp_D_SC[175] = sw_fsu_20f;
    tmp_D_SC[176] = H1H2_choice;
    tmp_D_SC[177] = EN_ADC;
    tmp_D_SC[178] = sw_ss_1200f;
    tmp_D_SC[179] = sw_ss_600f;
    tmp_D_SC[180] = sw_ss_300f;
    tmp_D_SC[181] = ON_OFF_ss;
    tmp_D_SC[182] = swb_buf_2p;
    tmp_D_SC[183] = swb_buf_1p;
    tmp_D_SC[184] = swb_buf_500f;
    tmp_D_SC[185] = swb_buf_250f;
    tmp_D_SC[186] = cmd_fsb;
    tmp_D_SC[187] = cmd_ss;
    tmp_D_SC[188] = cmd_fsu;
    tmp_D_SC[764:189] = GAIN[575:0];
    tmp_D_SC[828:765] = Ctest_ch[63:0]; 
    
	#150
	state = 0;
end

always begin
    #100  CK_in = !CK_in; //generating 5Ghz clock
end
always @(posedge CK_in) begin
    if(tmp_D_SC == read_D_SC) begin
		TX_succes = 1; //if data is correct we set transmision flag to 1
		state = 1;
		
		ON_OFF_otabg = $urandom_range(1,0);
		ON_OFF_dac =  $urandom_range(1,0);
		small_dac = $urandom_range(1,0);
		DAC2 = $urandom_range(1,0);
		DAC1 = $urandom_range(1,0);
		enb_outADC = $urandom_range(1,0);
		inv_startCmptGray = $urandom_range(1,0);
		ramp_8bit = $urandom_range(1,0);
		ramp_10bit = $urandom_range(1,0);
		mask_OR_ch = {4{$urandom}};
		cmd_CK_mux = $urandom_range(1,0);
		d1_d2 = $urandom_range(1,0);
		inv_discriADC = $urandom_range(1,0);
		polar_discri = $urandom_range(1,0);
		Enb_tristate = $urandom_range(1,0);
		valid_dc_fsb2 = $urandom_range(1,0);
		sw_fsb2_50f = $urandom_range(1,0);
		sw_fsb2_100f = $urandom_range(1,0);
		sw_fsb2_100k = $urandom_range(1,0);
		sw_fsb2_50k = $urandom_range(1,0);
		valid_dc_fs = $urandom_range(1,0);
		cmd_fsb_fsu = $urandom_range(1,0);
		sw_fsb1_50f = $urandom_range(1,0);
		sw_fsb1_100f = $urandom_range(1,0);
		sw_fsb1_100k = $urandom_range(1,0);
		sw_fsb1_50k = $urandom_range(1,0);
		sw_fsu_100k = $urandom_range(1,0);
		sw_fsu_50k = $urandom_range(1,0);
		sw_fsu_25k = $urandom_range(1,0);
		sw_fsu_40f = $urandom_range(1,0);
		sw_fsu_20f = $urandom_range(1,0);
		H1H2_choice = $urandom_range(1,0);
		EN_ADC = $urandom_range(1,0);
		sw_ss_1200f = $urandom_range(1,0);
		sw_ss_600f = $urandom_range(1,0);
		sw_ss_300f = $urandom_range(1,0);
		ON_OFF_ss = $urandom_range(1,0);
		swb_buf_2p = $urandom_range(1,0);
		swb_buf_1p = $urandom_range(1,0);
		swb_buf_500f = $urandom_range(1,0);
		swb_buf_250f = $urandom_range(1,0);
		cmd_fsb = $urandom_range(1,0);
		cmd_ss = $urandom_range(1,0);
		cmd_fsu = $urandom_range(1,0);
		GAIN = {18{$urandom}};
		Ctest_ch = {2{$urandom}};
		
		//writing state to tmp buff for later comparison
		tmp_D_SC[0] = ON_OFF_otabg;
		tmp_D_SC[1] = ON_OFF_dac;
		tmp_D_SC[2] = small_dac;
		tmp_D_SC[12:3] = DAC2[9:0];
		tmp_D_SC[22:13] = DAC1[9:0];
		tmp_D_SC[23] = enb_outADC;
		tmp_D_SC[24] = inv_startCmptGray;
		tmp_D_SC[25] = ramp_8bit;
		tmp_D_SC[26] = ramp_10bit;
		tmp_D_SC[154:27] = mask_OR_ch[127:0];
		tmp_D_SC[155] = cmd_CK_mux;
		tmp_D_SC[156] = d1_d2;
		tmp_D_SC[157] = inv_discriADC;
		tmp_D_SC[158] = polar_discri;
		tmp_D_SC[159] = Enb_tristate;
		tmp_D_SC[160] = valid_dc_fsb2;
		tmp_D_SC[161] = sw_fsb2_50f;
		tmp_D_SC[162] = sw_fsb2_100f;
		tmp_D_SC[163] = sw_fsb2_100k;
		tmp_D_SC[164] = sw_fsb2_50k;
		tmp_D_SC[165] = valid_dc_fs;
		tmp_D_SC[166] = cmd_fsb_fsu;
		tmp_D_SC[167] = sw_fsb1_50f;
		tmp_D_SC[168] = sw_fsb1_100f;
		tmp_D_SC[169] = sw_fsb1_100k;
		tmp_D_SC[170] = sw_fsb1_50k;
		tmp_D_SC[171] = sw_fsu_100k;
		tmp_D_SC[172] = sw_fsu_50k;
		tmp_D_SC[173] = sw_fsu_25k;
		tmp_D_SC[174] = sw_fsu_40f;
		tmp_D_SC[175] = sw_fsu_20f;
		tmp_D_SC[176] = H1H2_choice;
		tmp_D_SC[177] = EN_ADC;
		tmp_D_SC[178] = sw_ss_1200f;
		tmp_D_SC[179] = sw_ss_600f;
		tmp_D_SC[180] = sw_ss_300f;
		tmp_D_SC[181] = ON_OFF_ss;
		tmp_D_SC[182] = swb_buf_2p;
		tmp_D_SC[183] = swb_buf_1p;
		tmp_D_SC[184] = swb_buf_500f;
		tmp_D_SC[185] = swb_buf_250f;
		tmp_D_SC[186] = cmd_fsb;
		tmp_D_SC[187] = cmd_ss;
		tmp_D_SC[188] = cmd_fsu;
		tmp_D_SC[764:189] = GAIN[575:0];
		tmp_D_SC[828:765] = Ctest_ch[63:0]; 
		#150
		state = 0;
    end
    else begin
        TX_succes = 0;
        read_D_SC[828] <= D_SC; //data is shifted out least-significant bit first
        read_D_SC[827:0] <= read_D_SC[828:1]; //shift next bit into place
    end
end

endmodule
