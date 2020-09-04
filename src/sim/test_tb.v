`timescale 1ns / 1ps
module testb();
reg clk_in; //5MHz clock in
reg reset_in;
reg start_in;

wire D_SC_out; //series output bits
wire RSTn_SC_out;
wire CK_SC_out; //5MHZ clock out
wire [1:0] state_out; //state of machine

reg ON_OFF_otabg_in;
reg ON_OFF_dac_in; 
reg small_dac_in;
reg [9:0] DAC2_in;
reg [9:0] DAC1_in;
reg enb_outADC_in;
reg inv_startCmptGray_in;
reg ramp_8bit_in;
reg ramp_10bit_in;
reg [127:0] mask_OR_ch_in;
reg cmd_CK_mux_in;
reg d1_d2_in;
reg inv_discriADC_in;
reg polar_discri_in;
reg Enb_tristate_in;
reg valid_dc_fsb2_in;
reg sw_fsb2_50f_in;
reg sw_fsb2_100f_in;
reg sw_fsb2_100k_in;
reg sw_fsb2_50k_in;
reg valid_dc_fs_in;
reg cmd_fsb_fsu_in;
reg sw_fsb1_50f_in;
reg sw_fsb1_100f_in;
reg sw_fsb1_100k_in;
reg sw_fsb1_50k_in;
reg sw_fsu_100k_in;
reg sw_fsu_50k_in;
reg sw_fsu_25k_in;
reg sw_fsu_40f_in;
reg sw_fsu_20f_in;
reg H1H2_choice_in;
reg EN_ADC_in;
reg sw_ss_1200f_in;
reg sw_ss_600f_in;
reg sw_ss_300f_in;
reg ON_OFF_ss_in;
reg swb_buf_2p_in;
reg swb_buf_1p_in;
reg swb_buf_500f_in;
reg swb_buf_250f_in;
reg cmd_fsb_in;
reg cmd_ss_in;
reg cmd_fsu_in;
reg [575:0] GAIN_in;
reg [63:0] Ctest_ch_in;

reg [828:0] tmp_d_sc; //tmp buffor which include generated frame for comparison 
reg [828:0] read_D_SC;
reg tx_succes; //transmisiosn succes flag

transmitter uut( //prototype unit under test function
.clk_in(clk_in),
.reset_in(reset_in),
.start_in(start_in),

.ON_OFF_otabg_in(ON_OFF_otabg_in),
.ON_OFF_dac_in(ON_OFF_dac_in), 
.small_dac_in(small_dac_in),
.DAC2_in(DAC2_in),
.DAC1_in(DAC1_in),
.enb_outADC_in(enb_outADC_in),
.inv_startCmptGray_in(inv_startCmptGray_in),
.ramp_8bit_in(ramp_8bit_in),
.ramp_10bit_in(ramp_10bit_in),
.mask_OR_ch_in(mask_OR_ch_in),
.cmd_CK_mux_in(cmd_CK_mux_in),
.d1_d2_in(d1_d2_in),
.inv_discriADC_in(inv_discriADC_in),
.polar_discri_in(polar_discri_in),
.Enb_tristate_in(Enb_tristate_in),
.valid_dc_fsb2_in(valid_dc_fsb2_in),
.sw_fsb2_50f_in(sw_fsb2_50f_in),
.sw_fsb2_100f_in(sw_fsb2_100f_in),
.sw_fsb2_100k_in(sw_fsb2_100k_in),
.sw_fsb2_50k_in(sw_fsb2_50k_in),
.valid_dc_fs_in(valid_dc_fs_in),
.cmd_fsb_fsu_in(cmd_fsb_fsu_in),
.sw_fsb1_50f_in(sw_fsb1_50f_in),
.sw_fsb1_100f_in(sw_fsb1_100f_in),
.sw_fsb1_100k_in(sw_fsb1_100k_in),
.sw_fsb1_50k_in(sw_fsb1_50k_in),
.sw_fsu_100k_in(sw_fsu_100k_in),
.sw_fsu_50k_in(sw_fsu_50k_in),
.sw_fsu_25k_in(sw_fsu_25k_in),
.sw_fsu_40f_in(sw_fsu_40f_in),
.sw_fsu_20f_in(sw_fsu_20f_in),
.H1H2_choice_in(H1H2_choice_in),
.EN_ADC_in(EN_ADC_in),
.sw_ss_1200f_in(sw_ss_1200f_in),
.sw_ss_600f_in(sw_ss_600f_in),
.sw_ss_300f_in(sw_ss_300f_in),
.ON_OFF_ss_in(ON_OFF_ss_in),
.swb_buf_2p_in(swb_buf_2p_in),
.swb_buf_1p_in(swb_buf_1p_in),
.swb_buf_500f_in(swb_buf_500f_in),
.swb_buf_250f_in(swb_buf_250f_in),
.cmd_fsb_in(cmd_fsb_in),
.cmd_ss_in(cmd_ss_in),
.cmd_fsu_in(cmd_fsu_in),
.GAIN_in(GAIN_in),
.Ctest_ch_in(Ctest_ch_in),

.D_SC_out(D_SC_out),
.RSTn_SC_out(RSTn_SC_out),
.CK_SC_out(CK_SC_out),
.state_out(state_out)

);



initial begin 
    clk_in = 1; //set clk to 1
    read_D_SC[828:0] = 0;
    
    $srandom(10); //generate seed for random function
    //random generating input bit state for test bench
    ON_OFF_otabg_in = $urandom_range(1,0);
    ON_OFF_dac_in =  $urandom_range(1,0);
    small_dac_in = $urandom_range(1,0);
    DAC2_in = $urandom_range(1,0);
    DAC1_in = $urandom_range(1,0);
    enb_outADC_in = $urandom_range(1,0);
    inv_startCmptGray_in = $urandom_range(1,0);
    ramp_8bit_in = $urandom_range(1,0);
    ramp_10bit_in = $urandom_range(1,0);
    mask_OR_ch_in = {4{$urandom}};
    cmd_CK_mux_in = $urandom_range(1,0);
    d1_d2_in = $urandom_range(1,0);
    inv_discriADC_in = $urandom_range(1,0);
    polar_discri_in = $urandom_range(1,0);
    Enb_tristate_in = $urandom_range(1,0);
    valid_dc_fsb2_in = $urandom_range(1,0);
    sw_fsb2_50f_in = $urandom_range(1,0);
    sw_fsb2_100f_in = $urandom_range(1,0);
    sw_fsb2_100k_in = $urandom_range(1,0);
    sw_fsb2_50k_in = $urandom_range(1,0);
    valid_dc_fs_in = $urandom_range(1,0);
    cmd_fsb_fsu_in = $urandom_range(1,0);
    sw_fsb1_50f_in = $urandom_range(1,0);
    sw_fsb1_100f_in = $urandom_range(1,0);
    sw_fsb1_100k_in = $urandom_range(1,0);
    sw_fsb1_50k_in = $urandom_range(1,0);
    sw_fsu_100k_in = $urandom_range(1,0);
    sw_fsu_50k_in = $urandom_range(1,0);
    sw_fsu_25k_in = $urandom_range(1,0);
    sw_fsu_40f_in = $urandom_range(1,0);
    sw_fsu_20f_in = $urandom_range(1,0);
    H1H2_choice_in = $urandom_range(1,0);
    EN_ADC_in = $urandom_range(1,0);
    sw_ss_1200f_in = $urandom_range(1,0);
    sw_ss_600f_in = $urandom_range(1,0);
    sw_ss_300f_in = $urandom_range(1,0);
    ON_OFF_ss_in = $urandom_range(1,0);
    swb_buf_2p_in = $urandom_range(1,0);
    swb_buf_1p_in = $urandom_range(1,0);
    swb_buf_500f_in = $urandom_range(1,0);
    swb_buf_250f_in = $urandom_range(1,0);
    cmd_fsb_in = $urandom_range(1,0);
    cmd_ss_in = $urandom_range(1,0);
    cmd_fsu_in = $urandom_range(1,0);
    GAIN_in = {18{$urandom}};
    Ctest_ch_in = {2{$urandom}};
    
    //writing state to tmp buff for later comparison
    tmp_d_sc[0] = ON_OFF_otabg_in;
    tmp_d_sc[1] = ON_OFF_dac_in;
    tmp_d_sc[2] = small_dac_in;
    tmp_d_sc[12:3] = DAC2_in[9:0];
    tmp_d_sc[22:13] = DAC1_in[9:0];
    tmp_d_sc[23] = enb_outADC_in;
    tmp_d_sc[24] = inv_startCmptGray_in;
    tmp_d_sc[25] = ramp_8bit_in;
    tmp_d_sc[26] = ramp_10bit_in;
    tmp_d_sc[154:27] = mask_OR_ch_in[127:0];
    tmp_d_sc[155] = cmd_CK_mux_in;
    tmp_d_sc[156] = d1_d2_in;
    tmp_d_sc[157] = inv_discriADC_in;
    tmp_d_sc[158] = polar_discri_in;
    tmp_d_sc[159] = Enb_tristate_in;
    tmp_d_sc[160] = valid_dc_fsb2_in;
    tmp_d_sc[161] = sw_fsb2_50f_in;
    tmp_d_sc[162] = sw_fsb2_100f_in;
    tmp_d_sc[163] = sw_fsb2_100k_in;
    tmp_d_sc[164] = sw_fsb2_50k_in;
    tmp_d_sc[165] = valid_dc_fs_in;
    tmp_d_sc[166] = cmd_fsb_fsu_in;
    tmp_d_sc[167] = sw_fsb1_50f_in;
    tmp_d_sc[168] = sw_fsb1_100f_in;
    tmp_d_sc[169] = sw_fsb1_100k_in;
    tmp_d_sc[170] = sw_fsb1_50k_in;
    tmp_d_sc[171] = sw_fsu_100k_in;
    tmp_d_sc[172] = sw_fsu_50k_in;
    tmp_d_sc[173] = sw_fsu_25k_in;
    tmp_d_sc[174] = sw_fsu_40f_in;
    tmp_d_sc[175] = sw_fsu_20f_in;
    tmp_d_sc[176] = H1H2_choice_in;
    tmp_d_sc[177] = EN_ADC_in;
    tmp_d_sc[178] = sw_ss_1200f_in;
    tmp_d_sc[179] = sw_ss_600f_in;
    tmp_d_sc[180] = sw_ss_300f_in;
    tmp_d_sc[181] = ON_OFF_ss_in;
    tmp_d_sc[182] = swb_buf_2p_in;
    tmp_d_sc[183] = swb_buf_1p_in;
    tmp_d_sc[184] = swb_buf_500f_in;
    tmp_d_sc[185] = swb_buf_250f_in;
    tmp_d_sc[186] = cmd_fsb_in;
    tmp_d_sc[187] = cmd_ss_in;
    tmp_d_sc[188] = cmd_fsu_in;
    tmp_d_sc[764:189] = GAIN_in[575:0];
    tmp_d_sc[828:765] = Ctest_ch_in[63:0];
    reset_in <= 1;
    #200 reset_in <= 0;
    #100 start_in <= 1;
    #100 start_in <= 0;
end
always begin
    #100  clk_in = !clk_in; //generating 5ghz clock
end

always @(posedge clk_in) begin
    if(state_out == 2) begin
        read_D_SC[828] <= D_SC_out;
        read_D_SC[827:0] <= read_D_SC[828:1];
    end
end
always @* begin
    if(state_out == 3) begin
        read_D_SC[828:0] = 0;
        ON_OFF_otabg_in = $urandom_range(1,0);
        ON_OFF_dac_in =  $urandom_range(1,0);
        small_dac_in = $urandom_range(1,0);
        DAC2_in = $urandom_range(1,0);
        DAC1_in = $urandom_range(1,0);
        enb_outADC_in = $urandom_range(1,0);
        inv_startCmptGray_in = $urandom_range(1,0);
        ramp_8bit_in = $urandom_range(1,0);
        ramp_10bit_in = $urandom_range(1,0);
        mask_OR_ch_in = {4{$urandom}};
        cmd_CK_mux_in = $urandom_range(1,0);
        d1_d2_in = $urandom_range(1,0);
        inv_discriADC_in = $urandom_range(1,0);
        polar_discri_in = $urandom_range(1,0);
        Enb_tristate_in = $urandom_range(1,0);
        valid_dc_fsb2_in = $urandom_range(1,0);
        sw_fsb2_50f_in = $urandom_range(1,0);
        sw_fsb2_100f_in = $urandom_range(1,0);
        sw_fsb2_100k_in = $urandom_range(1,0);
        sw_fsb2_50k_in = $urandom_range(1,0);
        valid_dc_fs_in = $urandom_range(1,0);
        cmd_fsb_fsu_in = $urandom_range(1,0);
        sw_fsb1_50f_in = $urandom_range(1,0);
        sw_fsb1_100f_in = $urandom_range(1,0);
        sw_fsb1_100k_in = $urandom_range(1,0);
        sw_fsb1_50k_in = $urandom_range(1,0);
        sw_fsu_100k_in = $urandom_range(1,0);
        sw_fsu_50k_in = $urandom_range(1,0);
        sw_fsu_25k_in = $urandom_range(1,0);
        sw_fsu_40f_in = $urandom_range(1,0);
        sw_fsu_20f_in = $urandom_range(1,0);
        H1H2_choice_in = $urandom_range(1,0);
        EN_ADC_in = $urandom_range(1,0);
        sw_ss_1200f_in = $urandom_range(1,0);
        sw_ss_600f_in = $urandom_range(1,0);
        sw_ss_300f_in = $urandom_range(1,0);
        ON_OFF_ss_in = $urandom_range(1,0);
        swb_buf_2p_in = $urandom_range(1,0);
        swb_buf_1p_in = $urandom_range(1,0);
        swb_buf_500f_in = $urandom_range(1,0);
        swb_buf_250f_in = $urandom_range(1,0);
        cmd_fsb_in = $urandom_range(1,0);
        cmd_ss_in = $urandom_range(1,0);
        cmd_fsu_in = $urandom_range(1,0);
        GAIN_in = {18{$urandom}};
        Ctest_ch_in = {2{$urandom}};
        
        tmp_d_sc[0] = ON_OFF_otabg_in;
        tmp_d_sc[1] = ON_OFF_dac_in;
        tmp_d_sc[2] = small_dac_in;
        tmp_d_sc[12:3] = DAC2_in[9:0];
        tmp_d_sc[22:13] = DAC1_in[9:0];
        tmp_d_sc[23] = enb_outADC_in;
        tmp_d_sc[24] = inv_startCmptGray_in;
        tmp_d_sc[25] = ramp_8bit_in;
        tmp_d_sc[26] = ramp_10bit_in;
        tmp_d_sc[154:27] = mask_OR_ch_in[127:0];
        tmp_d_sc[155] = cmd_CK_mux_in;
        tmp_d_sc[156] = d1_d2_in;
        tmp_d_sc[157] = inv_discriADC_in;
        tmp_d_sc[158] = polar_discri_in;
        tmp_d_sc[159] = Enb_tristate_in;
        tmp_d_sc[160] = valid_dc_fsb2_in;
        tmp_d_sc[161] = sw_fsb2_50f_in;
        tmp_d_sc[162] = sw_fsb2_100f_in;
        tmp_d_sc[163] = sw_fsb2_100k_in;
        tmp_d_sc[164] = sw_fsb2_50k_in;
        tmp_d_sc[165] = valid_dc_fs_in;
        tmp_d_sc[166] = cmd_fsb_fsu_in;
        tmp_d_sc[167] = sw_fsb1_50f_in;
        tmp_d_sc[168] = sw_fsb1_100f_in;
        tmp_d_sc[169] = sw_fsb1_100k_in;
        tmp_d_sc[170] = sw_fsb1_50k_in;
        tmp_d_sc[171] = sw_fsu_100k_in;
        tmp_d_sc[172] = sw_fsu_50k_in;
        tmp_d_sc[173] = sw_fsu_25k_in;
        tmp_d_sc[174] = sw_fsu_40f_in;
        tmp_d_sc[175] = sw_fsu_20f_in;
        tmp_d_sc[176] = H1H2_choice_in;
        tmp_d_sc[177] = EN_ADC_in;
        tmp_d_sc[178] = sw_ss_1200f_in;
        tmp_d_sc[179] = sw_ss_600f_in;
        tmp_d_sc[180] = sw_ss_300f_in;
        tmp_d_sc[181] = ON_OFF_ss_in;
        tmp_d_sc[182] = swb_buf_2p_in;
        tmp_d_sc[183] = swb_buf_1p_in;
        tmp_d_sc[184] = swb_buf_500f_in;
        tmp_d_sc[185] = swb_buf_250f_in;
        tmp_d_sc[186] = cmd_fsb_in;
        tmp_d_sc[187] = cmd_ss_in;
        tmp_d_sc[188] = cmd_fsu_in;
        tmp_d_sc[764:189] = GAIN_in[575:0];
        tmp_d_sc[828:765] = Ctest_ch_in[63:0];
        
        #100 start_in <= 1;  
        #100 start_in <= 0;     
    end
    end
endmodule