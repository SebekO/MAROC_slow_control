`timescale 1ns / 1ps
module testb();

reg clk_in, //5MHz clock in
reg reset_in,
reg start_in,


wire D_SC_out, //series output bits
wire RSTn_SC_out,
wire CK_SC_out, //5MHZ clock out
wire reg [1:0] state_out //state of machine


reg on_off_otabg;
reg on_off_dac; 
reg small_dac;
reg [9:0] dac2;
reg [9:0] dac1;
reg enb_outadc;
reg inv_startcmptgray;
reg ramp_8bit;
reg ramp_10bit;
reg [127:0] mask_or_ch;
reg cmd_ck_mux;
reg d1_d2;
reg inv_discriadc;
reg polar_discri;
reg enb_tristate;
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
reg h1h2_choice;
reg en_adc;
reg sw_ss_1200f;
reg sw_ss_600f;
reg sw_ss_300f;
reg on_off_ss;
reg swb_buf_2p;
reg swb_buf_1p;
reg swb_buf_500f;
reg swb_buf_250f;
reg cmd_fsb;
reg cmd_ss;
reg cmd_fsu;
reg [575:0] gain;
reg [63:0] ctest_ch;

transmitter uut( //prototype unit under test function
.clk_in(clk_in),
.reset_in(reset_in),
.start_in(start_in),

.on_off_otabg(on_off_otabg),
.on_off_dac(on_off_dac), 
.small_dac(small_dac),
.dac2(dac2),
.dac1(dac1),
.enb_outadc(enb_outadc),
.inv_startcmptgray(inv_startcmptgray),
.ramp_8bit(ramp_8bit),
.ramp_10bit(ramp_10bit),
.mask_or_ch(mask_or_ch),
.cmd_ck_mux(cmd_ck_mux),
.d1_d2(d1_d2),
.inv_discriadc(inv_discriadc),
.polar_discri(polar_discri),
.enb_tristate(enb_tristate),
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
.h1h2_choice(h1h2_choice),
.en_adc(en_adc),
.sw_ss_1200f(sw_ss_1200f),
.sw_ss_600f(sw_ss_600f),
.sw_ss_300f(sw_ss_300f),
.on_off_ss(on_off_ss),
.swb_buf_2p(swb_buf_2p),
.swb_buf_1p(swb_buf_1p),
.swb_buf_500f(swb_buf_500f),
.swb_buf_250f(swb_buf_250f),
.cmd_fsb(cmd_fsb),
.cmd_ss(cmd_ss),
.cmd_fsu(cmd_fsu),
.gain(gain),
.ctest_ch(ctest_ch),

.D_SC_out(D_SC_out),
.RSTn_SC_out(RSTn_SC_out),
.CK_SC_out(CK_SC_out),
.state_out(state_out)

);

reg [828:0] tmp_d_sc; //tmp buffor which include generated frame for comparison 
reg [828:0] read_d_sc;
reg tx_succes; //transmisiosn succes flag

initial begin 
	clk = 1; //set clk to 1
	read_d_sc[828:0] = 0;
	
	$srandom(10); //generate seed for random function
    //random generating input bit state for test bench
    on_off_otabg = $urandom_range(1,0);
    on_off_dac =  $urandom_range(1,0);
    small_dac = $urandom_range(1,0);
    dac2 = $urandom_range(1,0);
    dac1 = $urandom_range(1,0);
    enb_outadc = $urandom_range(1,0);
    inv_startcmptgray = $urandom_range(1,0);
    ramp_8bit = $urandom_range(1,0);
    ramp_10bit = $urandom_range(1,0);
    mask_or_ch = {4{$urandom}};
    cmd_ck_mux = $urandom_range(1,0);
    d1_d2 = $urandom_range(1,0);
    inv_discriadc = $urandom_range(1,0);
    polar_discri = $urandom_range(1,0);
    enb_tristate = $urandom_range(1,0);
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
    h1h2_choice = $urandom_range(1,0);
    en_adc = $urandom_range(1,0);
    sw_ss_1200f = $urandom_range(1,0);
    sw_ss_600f = $urandom_range(1,0);
    sw_ss_300f = $urandom_range(1,0);
    on_off_ss = $urandom_range(1,0);
    swb_buf_2p = $urandom_range(1,0);
    swb_buf_1p = $urandom_range(1,0);
    swb_buf_500f = $urandom_range(1,0);
    swb_buf_250f = $urandom_range(1,0);
    cmd_fsb = $urandom_range(1,0);
    cmd_ss = $urandom_range(1,0);
    cmd_fsu = $urandom_range(1,0);
    gain = {18{$urandom}};
    ctest_ch = {2{$urandom}};
	
    //writing state to tmp buff for later comparison
    tmp_d_sc[0] = on_off_otabg;
    tmp_d_sc[1] = on_off_dac;
    tmp_d_sc[2] = small_dac;
    tmp_d_sc[12:3] = dac2[9:0];
    tmp_d_sc[22:13] = dac1[9:0];
    tmp_d_sc[23] = enb_outadc;
    tmp_d_sc[24] = inv_startcmptgray;
    tmp_d_sc[25] = ramp_8bit;
    tmp_d_sc[26] = ramp_10bit;
    tmp_d_sc[154:27] = mask_or_ch[127:0];
    tmp_d_sc[155] = cmd_ck_mux;
    tmp_d_sc[156] = d1_d2;
    tmp_d_sc[157] = inv_discriadc;
    tmp_d_sc[158] = polar_discri;
    tmp_d_sc[159] = enb_tristate;
    tmp_d_sc[160] = valid_dc_fsb2;
    tmp_d_sc[161] = sw_fsb2_50f;
    tmp_d_sc[162] = sw_fsb2_100f;
    tmp_d_sc[163] = sw_fsb2_100k;
    tmp_d_sc[164] = sw_fsb2_50k;
    tmp_d_sc[165] = valid_dc_fs;
    tmp_d_sc[166] = cmd_fsb_fsu;
    tmp_d_sc[167] = sw_fsb1_50f;
    tmp_d_sc[168] = sw_fsb1_100f;
    tmp_d_sc[169] = sw_fsb1_100k;
    tmp_d_sc[170] = sw_fsb1_50k;
    tmp_d_sc[171] = sw_fsu_100k;
    tmp_d_sc[172] = sw_fsu_50k;
    tmp_d_sc[173] = sw_fsu_25k;
    tmp_d_sc[174] = sw_fsu_40f;
    tmp_d_sc[175] = sw_fsu_20f;
    tmp_d_sc[176] = h1h2_choice;
    tmp_d_sc[177] = en_adc;
    tmp_d_sc[178] = sw_ss_1200f;
    tmp_d_sc[179] = sw_ss_600f;
    tmp_d_sc[180] = sw_ss_300f;
    tmp_d_sc[181] = on_off_ss;
    tmp_d_sc[182] = swb_buf_2p;
    tmp_d_sc[183] = swb_buf_1p;
    tmp_d_sc[184] = swb_buf_500f;
    tmp_d_sc[185] = swb_buf_250f;
    tmp_d_sc[186] = cmd_fsb;
    tmp_d_sc[187] = cmd_ss;
    tmp_d_sc[188] = cmd_fsu;
    tmp_d_sc[764:189] = gain[575:0];
    tmp_d_sc[828:765] = ctest_ch[63:0];
	reset_in <= 1;
	#100 reset_in <= 0;
end
always begin
    #100  clk = !clk; //generating 5ghz clock
end
always @(posedge clk) begin
	start_in <= 1;
	#100 start_in <= 0;
end