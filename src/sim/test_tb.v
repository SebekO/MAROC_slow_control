`timescale 1ns / 1ps
module testb();
reg CK_SC;
wire D_SC;

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




reg set_new_data; //flag signal for set new data
///buff data
reg [828:0] tmp_D_SC_buff; //tmp buffor which include generated frame for comparison 
reg [828:0] r_Rx_Byte;
reg TX_succes; //transmisiosn succes flag

reg [9:0] rr_Bit_Index; //shift register index
//3 bits data
reg ON_OFF_otabg_buff;
reg ON_OFF_dac_buff; 
reg small_dac_buff;
// 2x 10 bits data
reg [9:0] DAC2_buff;
reg [9:0] DAC1_buff;
//4 bits data
reg enb_outADC_buff;
reg inv_startCmptGray_buff;
reg ramp_8bit_buff;
reg ramp_10bit_buff;
// 128 bits mask
reg [127:0] mask_OR_ch_buff;
//reg [63:0] mask_OR1_ch_buff;
// 34 bits global configuration data
reg cmd_CK_mux_buff;
reg d1_d2_buff;
reg inv_discriADC_buff;
reg polar_discri_buff;
reg Enb_tristate_buff;
reg valid_dc_fsb2_buff;
reg sw_fsb2_50f_buff;
reg sw_fsb2_100f_buff;
reg sw_fsb2_100k_buff;
reg sw_fsb2_50k_buff;
reg valid_dc_fs_buff;
reg cmd_fsb_fsu_buff;
reg sw_fsb1_50f_buff;
reg sw_fsb1_100f_buff;
reg sw_fsb1_100k_buff;
reg sw_fsb1_50k_buff;
reg sw_fsu_100k_buff;
reg sw_fsu_50k_buff;
reg sw_fsu_25k_buff;
reg sw_fsu_40f_buff;
reg sw_fsu_20f_buff;
reg H1H2_choice_buff;
reg EN_ADC_buff;
reg sw_ss_1200f_buff;
reg sw_ss_600f_buff;
reg sw_ss_300f_buff;
reg ON_OFF_ss_buff;
reg swb_buf_2p_buff;
reg swb_buf_1p_buff;
reg swb_buf_500f_buff;
reg swb_buf_250f_buff;
reg cmd_fsb_buff;
reg cmd_ss_buff;
reg cmd_fsu_buff;
// 576 bits gain data
//reg [63:0] cmd_SUM_buff;
reg [575:0] GAIN_buff; //[7:0][63:0] + [63:0]cmd_SUM
// 64 bits ctest data
reg [63:0] Ctest_ch_buff;


transmiter uut( //prototype unit under test function
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
.CK_SC(CK_SC),
.set_new_data(set_new_data)
);

initial begin 
    $srandom(10); //generate seed for random function
    r_Rx_Byte = 0;
    tmp_D_SC_buff = 0;
    TX_succes = 0;
    CK_SC = 1; //set Clk to 0
    set_new_data = 1; //set rts to 0
    //random generating input bit state for test bench
    ON_OFF_otabg = $urandom_range(1,0);
    assign ON_OFF_dac =  $urandom_range(1,0);
    assign small_dac = $urandom_range(1,0);
    assign DAC2 = $urandom_range(1,0);
    assign DAC1 = $urandom_range(1,0);
    assign enb_outADC = $urandom_range(1,0);
    assign inv_startCmptGray = $urandom_range(1,0);
    assign ramp_8bit = $urandom_range(1,0);
    assign ramp_10bit = $urandom_range(1,0);
    assign mask_OR_ch = {$urandom(),$urandom(),$urandom(),$urandom()};
    assign cmd_CK_mux = $urandom_range(1,0);
    assign d1_d2 = $urandom_range(1,0);
    assign inv_discriADC = $urandom_range(1,0);
    assign polar_discri = $urandom_range(1,0);
    assign Enb_tristate = $urandom_range(1,0);
    assign valid_dc_fsb2 = $urandom_range(1,0);
    assign sw_fsb2_50f = $urandom_range(1,0);
    assign sw_fsb2_100f = $urandom_range(1,0);
    assign sw_fsb2_100k = $urandom_range(1,0);
    assign sw_fsb2_50k = $urandom_range(1,0);
    assign valid_dc_fs = $urandom_range(1,0);
    assign cmd_fsb_fsu = $urandom_range(1,0);
    assign sw_fsb1_50f = $urandom_range(1,0);
    assign sw_fsb1_100f = $urandom_range(1,0);
    assign sw_fsb1_100k = $urandom_range(1,0);
    assign sw_fsb1_50k = $urandom_range(1,0);
    assign sw_fsu_100k = $urandom_range(1,0);
    assign sw_fsu_50k = $urandom_range(1,0);
    assign sw_fsu_25k = $urandom_range(1,0);
    assign sw_fsu_40f = $urandom_range(1,0);
    assign sw_fsu_20f = $urandom_range(1,0);
    assign H1H2_choice = $urandom_range(1,0);
    assign EN_ADC = $urandom_range(1,0);
    assign sw_ss_1200f = $urandom_range(1,0);
    assign sw_ss_600f = $urandom_range(1,0);
    assign sw_ss_300f = $urandom_range(1,0);
    assign ON_OFF_ss = $urandom_range(1,0);
    assign swb_buf_2p = $urandom_range(1,0);
    assign swb_buf_1p = $urandom_range(1,0);
    assign swb_buf_500f = $urandom_range(1,0);
    assign swb_buf_250f = $urandom_range(1,0);
    assign cmd_fsb = $urandom_range(1,0);
    assign cmd_ss = $urandom_range(1,0);
    assign cmd_fsu = $urandom_range(1,0);
    assign GAIN = {$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom()};
    
    Ctest_ch = 1;
    //writing state to tmp buff for later comparison
    tmp_D_SC_buff[0] <= ON_OFF_otabg;
    tmp_D_SC_buff[1] <= ON_OFF_dac;
    tmp_D_SC_buff[2] <= small_dac;
    tmp_D_SC_buff[12:3] <= DAC2[9:0];
    tmp_D_SC_buff[22:13] <= DAC1[9:0];
    tmp_D_SC_buff[23] <= enb_outADC;
    tmp_D_SC_buff[24] <= inv_startCmptGray;
    tmp_D_SC_buff[25] <= ramp_8bit;
    tmp_D_SC_buff[26] <= ramp_10bit;
    tmp_D_SC_buff[154:27] <= mask_OR_ch[127:0];
    tmp_D_SC_buff[155] <= cmd_CK_mux;
    tmp_D_SC_buff[156] <= d1_d2;
    tmp_D_SC_buff[157] <= inv_discriADC;
    tmp_D_SC_buff[158] <= polar_discri;
    tmp_D_SC_buff[159] <= Enb_tristate;
    tmp_D_SC_buff[160] <= valid_dc_fsb2;
    tmp_D_SC_buff[161] <= sw_fsb2_50f;
    tmp_D_SC_buff[162] <= sw_fsb2_100f;
    tmp_D_SC_buff[163] <= sw_fsb2_100k;
    tmp_D_SC_buff[164] <= sw_fsb2_50k;
    tmp_D_SC_buff[165] <= valid_dc_fs;
    tmp_D_SC_buff[166] <= cmd_fsb_fsu;
    tmp_D_SC_buff[167] <= sw_fsb1_50f;
    tmp_D_SC_buff[168] <= sw_fsb1_100f;
    tmp_D_SC_buff[169] <= sw_fsb1_100k;
    tmp_D_SC_buff[170] <= sw_fsb1_50k;
    tmp_D_SC_buff[171] <= sw_fsu_100k;
    tmp_D_SC_buff[172] <= sw_fsu_50k;
    tmp_D_SC_buff[173] <= sw_fsu_25k;
    tmp_D_SC_buff[174] <= sw_fsu_40f;
    tmp_D_SC_buff[175] <= sw_fsu_20f;
    tmp_D_SC_buff[176] <= H1H2_choice;
    tmp_D_SC_buff[177] <= EN_ADC;
    tmp_D_SC_buff[178] <= sw_ss_1200f;
    tmp_D_SC_buff[179] <= sw_ss_600f;
    tmp_D_SC_buff[180] <= sw_ss_300f;
    tmp_D_SC_buff[181] <= ON_OFF_ss;
    tmp_D_SC_buff[182] <= swb_buf_2p;
    tmp_D_SC_buff[183] <= swb_buf_1p;
    tmp_D_SC_buff[184] <= swb_buf_500f;
    tmp_D_SC_buff[185] <= swb_buf_250f;
    tmp_D_SC_buff[186] <= cmd_fsb;
    tmp_D_SC_buff[187] <= cmd_ss;
    tmp_D_SC_buff[188] <= cmd_fsu;
    tmp_D_SC_buff[764:189] <= GAIN[575:0];
    tmp_D_SC_buff[828:765] <= Ctest_ch[63:0]; 
     //setting rst to 1 for uploading new values to MAROC
end
always begin
    TX_succes <=0; //setting success transmision flag to 0
    set_new_data = 0; //setting rst to 0 for stopped generating new values
    #100  CK_SC = !CK_SC; //generating 5Ghz clock
end
always @(negedge CK_SC) begin //for every Clk signal we received one bit to from uut module
    if(tmp_D_SC_buff == r_Rx_Byte) TX_succes <= 1; //if data is correct we set transmision flag to 1
    else TX_succes <= 0;
    r_Rx_Byte[828] <= D_SC; //data is shifted out least-significant bit first
    r_Rx_Byte[827:0] <= r_Rx_Byte[828:1]; //shift next bit into place
end
always @(negedge TX_succes) begin //if we received data successful we can generate new one data for frame
    set_new_data = 1;
    ON_OFF_otabg = $urandom_range(1,0);
    ON_OFF_dac =  $urandom_range(1,0);
    small_dac = $urandom_range(1,0);
    DAC2 = $urandom_range(1,0);
    DAC1 = $urandom_range(1,0);
    enb_outADC = $urandom_range(1,0);
    inv_startCmptGray = $urandom_range(1,0);
    ramp_8bit = $urandom_range(1,0);
    ramp_10bit = $urandom_range(1,0);
    mask_OR_ch = {$urandom(),$urandom(),$urandom(),$urandom()};
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
    GAIN = {$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom()};
    Ctest_ch = {$urandom(),$urandom()};
    tmp_D_SC_buff[0] <= ON_OFF_otabg;
    tmp_D_SC_buff[1] <= ON_OFF_dac;
    tmp_D_SC_buff[2] <= small_dac;
    tmp_D_SC_buff[12:3] <= DAC2[9:0];
    tmp_D_SC_buff[22:13] <= DAC1[9:0];
    tmp_D_SC_buff[23] <= enb_outADC;
    tmp_D_SC_buff[24] <= inv_startCmptGray;
    tmp_D_SC_buff[25] <= ramp_8bit;
    tmp_D_SC_buff[26] <= ramp_10bit;
    tmp_D_SC_buff[154:27] <= mask_OR_ch[127:0];
    tmp_D_SC_buff[155] <= cmd_CK_mux;
    tmp_D_SC_buff[156] <= d1_d2;
    tmp_D_SC_buff[157] <= inv_discriADC;
    tmp_D_SC_buff[158] <= polar_discri;
    tmp_D_SC_buff[159] <= Enb_tristate;
    tmp_D_SC_buff[160] <= valid_dc_fsb2;
    tmp_D_SC_buff[161] <= sw_fsb2_50f;
    tmp_D_SC_buff[162] <= sw_fsb2_100f;
    tmp_D_SC_buff[163] <= sw_fsb2_100k;
    tmp_D_SC_buff[164] <= sw_fsb2_50k;
    tmp_D_SC_buff[165] <= valid_dc_fs;
    tmp_D_SC_buff[166] <= cmd_fsb_fsu;
    tmp_D_SC_buff[167] <= sw_fsb1_50f;
    tmp_D_SC_buff[168] <= sw_fsb1_100f;
    tmp_D_SC_buff[169] <= sw_fsb1_100k;
    tmp_D_SC_buff[170] <= sw_fsb1_50k;
    tmp_D_SC_buff[171] <= sw_fsu_100k;
    tmp_D_SC_buff[172] <= sw_fsu_50k;
    tmp_D_SC_buff[173] <= sw_fsu_25k;
    tmp_D_SC_buff[174] <= sw_fsu_40f;
    tmp_D_SC_buff[175] <= sw_fsu_20f;
    tmp_D_SC_buff[176] <= H1H2_choice;
    tmp_D_SC_buff[177] <= EN_ADC;
    tmp_D_SC_buff[178] <= sw_ss_1200f;
    tmp_D_SC_buff[179] <= sw_ss_600f;
    tmp_D_SC_buff[180] <= sw_ss_300f;
    tmp_D_SC_buff[181] <= ON_OFF_ss;
    tmp_D_SC_buff[182] <= swb_buf_2p;
    tmp_D_SC_buff[183] <= swb_buf_1p;
    tmp_D_SC_buff[184] <= swb_buf_500f;
    tmp_D_SC_buff[185] <= swb_buf_250f;
    tmp_D_SC_buff[186] <= cmd_fsb;
    tmp_D_SC_buff[187] <= cmd_ss;
    tmp_D_SC_buff[188] <= cmd_fsu;
    tmp_D_SC_buff[764:189] <= GAIN[575:0];
    tmp_D_SC_buff[828:765] <= Ctest_ch[63:0];
end
endmodule
