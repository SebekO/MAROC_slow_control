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

reg rst;
wire ss;
reg rs;

reg [828:0] tmp_D_SC_buff;

reg [828:0] r_Rx_Byte;

reg TX_succes;
reg [9:0] rr_Bit_Index;

transmiter uut1(
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
.rst(rst),
.ss(ss)
);

initial begin 
    $srandom(10);
    CK_SC = 0;
    rst = 0;
    r_Rx_Byte = 0;
    tmp_D_SC_buff = 0;
    TX_succes = 0;
    
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
    rst = 1;
end
always begin
    TX_succes <=0;
    rst = 0;
    #200  CK_SC = !CK_SC;
end
always @(negedge CK_SC) begin 
    r_Rx_Byte[828] <= D_SC;
    r_Rx_Byte[827:0] <= r_Rx_Byte[828:1];
    if (rr_Bit_Index < 830) begin
        rr_Bit_Index <= rr_Bit_Index+1;
        rs <=0;
        end
    else begin
        rr_Bit_Index <=0;
        rs <= 1;
    end
end

always @(posedge rs) begin
    if(tmp_D_SC_buff == r_Rx_Byte) TX_succes <= 1;
    else TX_succes <= 0;
end
always @(negedge rs) begin
    rst = 1;
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
