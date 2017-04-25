#!/usr/bin/env ruby
# SAR standard (built-in) analyses andes
# (c) Copyright 2017 Premier Heart, LLC

require 'mpa/signal_analysis/sar'
require 'mpa/signal_analysis/dsp_ops'

module Mpa
  module SignalAnalysis
    module Sar

      class Analysis
        HR_NAME='heart rate'
        HR_SYM='hr'

        APS_NAME=Mpa::SignalAnalysis::Dsp::Op::APS_NAME
        APS_SYM=Mpa::SignalAnalysis::Dsp::Op::APS_SYM

        AMP_NAME=Mpa::SignalAnalysis::Dsp::Op::AMP_NAME
        AMP_SYM=Mpa::SignalAnalysis::Dsp::Op::AMP_SYM

        CPS_NAME=Mpa::SignalAnalysis::Dsp::Op::CPS_NAME
        CPS_SYM=Mpa::SignalAnalysis::Dsp::Op::CPS_SYM

        CCR_NAME=Mpa::SignalAnalysis::Dsp::Op::CCR_NAME
        CCR_SYM=Mpa::SignalAnalysis::Dsp::Op::CCR_SYM

        IMR_NAME=Mpa::SignalAnalysis::Dsp::Op::IMR_NAME
        IMR_SYM=Mpa::SignalAnalysis::Dsp::Op::IMR_SYM

        PSA_NAME=Mpa::SignalAnalysis::Dsp::Op::PSA_NAME
        PSA_SYM=Mpa::SignalAnalysis::Dsp::Op::PSA_SYM

        XAR_NAME=Mpa::SignalAnalysis::Dsp::Op::XAR_NAME
        XAR_SYM=Mpa::SignalAnalysis::Dsp::Op::XAR_SYM

        COH_NAME=Mpa::SignalAnalysis::Dsp::Op::COH_NAME
        COH_SYM=Mpa::SignalAnalysis::Dsp::Op::COH_SYM
      end

      class IntData
      end

      class Index

        # Heart Rate Analysis
        HR_RR_SYM='RR'
        HR_RR_NAME='RR'

        HR_HR_SYM='HR'
        HR_HR_NAME='HR'

        HR_S_SYM='S'
        HR_S_NAME='S'

        HR_SS_SYM='SS'
        HR_SS_NAME='SS'

        HR_F_SYM='F'
        HR_F_NAME='F'

        HR_FF_SYM='FF'
        HR_FF_NAME='FF'

        HR_ERRHR_SYM='ERRHR'
        HR_ERRHR_NAME='Invalid Heart Rate'

        HR_ERRARR_SYM='ERRARR'
        HR_ERRARR_NAME='No Lead A Raw Rate'

        HR_ERRBRR_SYM='ERRBRR'
        HR_ERRBRR_NAME='No Lead B Raw Rate'

        #	Amplitude Histogram Analysis
        AMP_HYPER_SYM='A+'
        AMP_HYPER_NAME='A+'

        AMP_HYPO_SYM='A-'
        AMP_HYPO_NAME='A-'

        AMP_NPLUS_SYM='n+'
        AMP_NPLUS_NAME='n+'

        AMP_NMINUS_SYM='n-'
        AMP_NMINUS_NAME='n-'

        #	Auto Power Spectrum Analysis 
        APS_MP_SYM='MP'
        APS_MP_NAME='main peak'

        APS_12_SYM='1/2'
        APS_12_NAME='1/2'

        APS_OMEGA_SYM='O'
        APS_OMEGA_NAME='O'

        APS_N1_SYM='N1'
        APS_N1_NAME='N1'

        APS_N2_SYM='N2'
        APS_N2_NAME='N2'

        APS_N3_SYM='N3'
        APS_N3_NAME='N3'

        APS_U1_SYM='U1'
        APS_U1_NAME='U1'

        APS_U2_SYM='U2'
        APS_U2_NAME='U2'

        APS_U3_SYM='U3'
        APS_U3_NAME='U3'

        APS_U3xy_SYM='U3xy'
        APS_U3xy_NAME='U3xy'

        APS_U4_SYM='U4'
        APS_U4_NAME='U4'

        APS_U5_SYM='U5'
        APS_U5_NAME='U5'

        APS_A1_SYM='A1'
        APS_A1_NAME='A1'

        APS_A2_SYM='A2'
        APS_A2_NAME='A2'

        APS_A3_SYM='A3'
        APS_A3_NAME='A3'

        APS_A4_SYM='A4'
        APS_A4_NAME='A4'

        APS_A5_SYM='A5'
        APS_A5_NAME='A5'

        APS_A55_SYM='A55'
        APS_A55_NAME='A55'

        APS_AA1_SYM='AA1'
        APS_AA1_NAME='AA1'

        APS_AA4_SYM='AA4'
        APS_AA4_NAME='AA4'

        APS_AA12_SYM='AA12'
        APS_AA12_NAME='AA12'

        APS_AA34_SYM='AA34'
        APS_AA34_NAME='AA34'

        APS_AA123_SYM='AA123'
        APS_AA123_NAME='AA123'

        #	APS_Severity 
        APS_C1_SYM='C1'
        APS_C1_NAME='Camel1'

        APS_C2_SYM='C2'
        APS_C2_NAME='Camel2'

        APS_C3_SYM='C3'
        APS_C3_NAME='Camel3'

        APS_ERRH5_SYM='ERRH5'
        APS_ERRH5_NAME='Missing harmonic peaks'

        #	Cross Correlation Analysis

        CCR_rrr_SYM='rrr'
        CCR_rrr_NAME='rrr'

        CCR_RRR_SYM='RRR'
        CCR_RRR_NAME='RRR'

        CCR_r_SYM='r'
        CCR_r_NAME='r'

        CCR_R_SYM='R'
        CCR_R_NAME='R'

        CCR_RR_SYM='RR'
        CCR_RR_NAME='RR'

        CCR_rr_SYM='rr'
        CCR_rr_NAME='rr'

        CCR_rR_SYM='rR'
        CCR_rR_NAME='rR'

        CCR_r2_SYM='r2'
        CCR_r2_NAME='r2'

        CCR_r22_SYM='r22'
        CCR_r22_NAME='r22'

        CCR_R2_SYM='R2'
        CCR_R2_NAME='R2'

        CCR_RyMINUS_SYM='Ry-'
        CCR_RyMINUS_NAME='Ry-'

        CCR_RyPLUS_SYM='Ry+'
        CCR_RyPLUS_NAME='Ry+'

        CCR_RwMINUS_SYM='Rw-'
        CCR_RwMINUS_NAME='Rw-'

        CCR_RwPLUS_SYM='Rw+'
        CCR_RwPLUS_NAME='Rw+'

        CCR_RVVMINUS_SYM='RVV-'
        CCR_RVVMINUS_NAME='RVV-'

        CCR_RVVPLUS_SYM='RVV+'
        CCR_RVVPLUS_NAME='RVV+'

        CCR_PT_SYM='PT'
        CCR_PT_NAME='PT'

        CCR_PT1_SYM='PT1'
        CCR_PT1_NAME='PT1'

        CCR_PT2_SYM='PT2'
        CCR_PT2_NAME='PT2'

        CCR_pt_SYM='pt'
        CCR_pt_NAME='pt'

        CCR_pt1_SYM='pt1'
        CCR_pt1_NAME='pt1'

        CCR_pt2_SYM='pt2'
        CCR_pt2_NAME='pt2'

        CCR_Rn_SYM='Rn'
        CCR_Rn_NAME='Rn'

        CCR_RM_SYM='RM'
        CCR_RM_NAME='RM'

        CCR_RPLUS_SYM='R+'
        CCR_RPLUS_NAME='R+'

        CCR_RMINUS_SYM='R-'
        CCR_RMINUS_NAME='R-'

        CCR_NOTR_SYM='!R'
        CCR_NOTR_NAME='!R'

        CCR_RNOT_SYM='R!'
        CCR_RNOT_NAME='R!'

        CCR_RCARET_SYM='R^'
        CCR_RCARET_NAME='R^'

        # CCR_Severity 
        CCR_S1_SYM='HHH'
        CCR_S1_NAME='Snail1'

        CCR_S2_SYM='L'
        CCR_S2_NAME='Snail2'

        CCR_S3_SYM='W'
        CCR_S3_NAME='Snail3'

        CCR_S4_SYM='Od'
        CCR_S4_NAME='Snail4'

        CCR_S5_SYM='Inv'
        CCR_S5_NAME='Snail5'

        CCR_ERRMP_SYM = 'ERRMP'
        CCR_ERRMP_NAME = 'No Main Peak'

        CCR_ERRMAX_SYM = 'ERRMAX'
        CCR_ERRMAX_NAME = 'No Center Max'

        CCR_ERRV45_SYM = 'ERRV45'
        CCR_ERRV45_NAME = 'No V45 Curve'

        #	Phase Shift Angle Analysis 

        PSA_PPLUS_SYM='P+'
        PSA_PPLUS_NAME='P+'

        PSA_PPLUS10_SYM='P+10'
        PSA_PPLUS10_NAME='P+10'

        PSA_PPLUS15_SYM='P+15'
        PSA_PPLUS15_NAME='P+15'

        PSA_PPLUSGT15_SYM='P+>15'
        PSA_PPLUSGT15_NAME='P+>15'

        PSA_PMINUS_SYM='P-'
        PSA_PMINUS_NAME='P-'

        PSA_PMINUS10_SYM='P-10'
        PSA_PMINUS10_NAME='P-10'

        PSA_PMINUS15_SYM='P-15'
        PSA_PMINUS15_NAME='P-15'

        PSA_PMINUSGT15_SYM='P->15'
        PSA_PMINUSGT15_NAME='P->15'

        PSA_WW_SYM='WW'
        PSA_WW_NAME='WW'

        PSA_PWWPLUS_SYM='PWW+'
        PSA_PWWPLUS_NAME='PWW+'

        PSA_PWWMINUS_SYM='PWW-'
        PSA_PWWMINUS_NAME='PWW-'

        PSA_TPLUS_SYM='T+'
        PSA_TPLUS_NAME='T+'

        PSA_TMINUS_SYM='T-'
        PSA_TMINUS_NAME='T-'

        PSA_UPLUS_SYM='U+'
        PSA_UPLUS_NAME='U+'

        PSA_UMINUS_SYM='U-'
        PSA_UMINUS_NAME='U-'

        PSA_WPLUS_SYM='W+'
        PSA_WPLUS_NAME='W+'

        PSA_WMINUS_SYM='W-'
        PSA_WMINUS_NAME='W-'

        PSA_W_SYM='W'
        PSA_W_NAME='W'

        PSA_VPLUS_SYM='V+'
        PSA_VPLUS_NAME='V+'

        PSA_XPLUSPLUS_SYM='X++'
        PSA_XPLUSPLUS_NAME='X++'

        PSA_XMINUSPLUS_SYM='X-+'
        PSA_XMINUSPLUS_NAME='X-+'

        PSA_YPLUSPLUS_SYM='Y++'
        PSA_YPLUSPLUS_NAME='Y++'

        PSA_YMINUSPLUS_SYM='Y-+'
        PSA_YMINUSPLUS_NAME='Y-+'

        PSA_VMINUS_SYM='V-'
        PSA_VMINUS_NAME='V-'

        PSA_XMINUSMINUS_SYM='X--'
        PSA_XMINUSMINUS_NAME='X--'

        PSA_XPLUSMINUS_SYM='X+-'
        PSA_XPLUSMINUS_NAME='X+-'

        PSA_YMINUSMINUS_SYM='Y--'
        PSA_YMINUSMINUS_NAME='Y--'

        PSA_YPLUSMINUS_SYM='Y+-'
        PSA_YPLUSMINUS_NAME='Y+-'

        PSA_ZPLUS1_SYM='Z+1'
        PSA_ZPLUS1_NAME='Z+1'

        PSA_ZPLUS2_SYM='Z+2'
        PSA_ZPLUS2_NAME='Z+2'

        PSA_ZPLUS3_SYM='Z+3'
        PSA_ZPLUS3_NAME='Z+3'

        PSA_ZMINUS1_SYM='Z-1'
        PSA_ZMINUS1_NAME='Z-1'

        PSA_ZMINUS2_SYM='Z-2'
        PSA_ZMINUS2_NAME='Z-2'

        PSA_ZMINUS3_SYM='Z-3'
        PSA_ZMINUS3_NAME='Z-3'

        # PSA_Severity
        PSA_D1_SYM='WWs'
        PSA_D1_NAME='Dragon1'

        PSA_D2_SYM='Ct'
        PSA_D2_NAME='Dragon2'

        PSA_D3_SYM='HfW'
        PSA_D3_NAME='Dragon3'

        #	Impulse Response Analysis

        IMR_ff_SYM='ff'
        IMR_ff_NAME='ff'

        IMR_f_SYM='f'
        IMR_f_NAME='f'

        IMR_M1_SYM='M1'
        IMR_M1_NAME='M1'

        IMR_M3_SYM='M3'
        IMR_M3_NAME='M3'

        IMR_M2_SYM='M2'
        IMR_M2_NAME='M2'

        IMR_M4_SYM='M4'
        IMR_M4_NAME='M4'

        IMR_M5_SYM='M5'
        IMR_M5_NAME='M5'

        IMR_M6_SYM='M6'
        IMR_M6_NAME='M6'

        IMR_L_SYM='L'
        IMR_L_NAME='L'

        IMR_D1_SYM='D1'
        IMR_D1_NAME='D1'

        IMR_D2_SYM='D2'
        IMR_D2_NAME='D2'

        # IMR_Severity
        
        IMR_B1_SYM='B1'
        IMR_B1_NAME='Bat1'

        IMR_B2_SYM='B2'
        IMR_B2_NAME='Bat2'
        
        IMR_ERRPK_SYM ="ERRPK"
        IMR_ERRPK_NAME = "Too few apexes"

        IMR_ERRMP_SYM = 'ERRMP'
        IMR_ERRMP_NAME = 'No Main Peak'

        IMR_ERRM12_SYM = 'ERRM12'
        IMR_ERRM12_NAME = 'No Main M1 M2 Peak'

        # Correlation

        COH_Q1_SYM='Q1'
        COH_Q1_NAME='Q1'

        COH_Q2_SYM='Q2'
        COH_Q2_NAME='Q2'

        LEGACY_INDEXES = [
            APS_12_NAME,
            APS_OMEGA_NAME,
            APS_U1_NAME,
            APS_U2_NAME,
            APS_U3_NAME,
            APS_U3xy_NAME,
            APS_U4_NAME,
            APS_N1_NAME,
            APS_N3_NAME,
            HR_S_NAME,
            HR_SS_NAME,
            HR_F_NAME,
            HR_FF_NAME,
            APS_A1_NAME,
            APS_A2_NAME,
            APS_A3_NAME,
            APS_A4_NAME,
            APS_A5_NAME,
            APS_A55_NAME,
            APS_N2_NAME,
            APS_AA12_NAME,
            APS_AA34_NAME,
            APS_AA123_NAME,
            APS_AA1_NAME,
            APS_AA4_NAME,
            APS_U5_NAME,
            APS_12_NAME,
            APS_OMEGA_NAME,
            APS_U1_NAME,
            APS_U2_NAME,
            APS_U3_NAME,
            APS_U3xy_NAME,
            APS_U4_NAME,
            APS_N1_NAME,
            APS_N3_NAME,
            HR_S_NAME,
            HR_SS_NAME,
            HR_F_NAME,
            HR_FF_NAME,
            APS_A1_NAME,
            APS_A2_NAME,
            APS_A3_NAME,
            APS_A4_NAME,
            APS_A5_NAME,
            APS_A55_NAME,
            APS_N2_NAME,
            APS_AA12_NAME,
            APS_AA34_NAME,
            APS_AA123_NAME,
            APS_AA1_NAME,
            APS_AA4_NAME,
            APS_U5_NAME,
            PSA_PPLUS_NAME,
            PSA_PMINUS_NAME,
            PSA_WW_NAME,
            PSA_PWWPLUS_NAME,
            PSA_PWWMINUS_NAME,
            IMR_L_NAME,
            COH_Q1_NAME,
            COH_Q2_NAME,
            IMR_D1_NAME,
            IMR_D2_NAME,
            IMR_f_NAME,
            IMR_M1_NAME,
            IMR_M3_NAME,
            IMR_M2_NAME,
            IMR_M4_NAME,
            IMR_M5_NAME,
            IMR_M6_NAME,
            IMR_ff_NAME,
            AMP_HYPER_NAME,
            AMP_HYPER_NAME,
            AMP_HYPO_NAME,
            AMP_HYPO_NAME,
            AMP_NPLUS_NAME,
            AMP_NPLUS_NAME,
            AMP_NMINUS_NAME,
            AMP_NMINUS_NAME,
            CCR_rrr_NAME,
            CCR_RRR_NAME,
            CCR_r_NAME,
            CCR_R_NAME,
            CCR_RR_NAME,
            CCR_rr_NAME,
            CCR_rR_NAME,
            CCR_RPLUS_NAME,
            CCR_RMINUS_NAME,
            CCR_RwPLUS_NAME,
            CCR_RwMINUS_NAME,
            CCR_PT1_NAME,
            CCR_PT2_NAME,
            CCR_pt1_NAME,
            CCR_pt2_NAME,
            CCR_Rn_NAME,
            CCR_RVVPLUS_NAME,
            CCR_RVVMINUS_NAME,
            CCR_RCARET_NAME,
            CCR_NOTR_NAME,
            CCR_RNOT_NAME,
            CCR_r2_NAME,
            CCR_R2_NAME,
            CCR_r22_NAME,
            CCR_RM_NAME,
            PSA_TPLUS_NAME,
            PSA_TMINUS_NAME,
            PSA_UPLUS_NAME,
            PSA_UMINUS_NAME,
            PSA_WPLUS_NAME,
            PSA_WMINUS_NAME,
            PSA_W_NAME,
            PSA_PPLUS10_NAME,
            PSA_PPLUS15_NAME,
            PSA_PPLUSGT15_NAME,
            PSA_PMINUS10_NAME,
            PSA_PMINUS15_NAME,
            PSA_PMINUSGT15_NAME,
            PSA_VPLUS_NAME,
            PSA_VMINUS_NAME,
            PSA_XPLUSPLUS_NAME,
            PSA_XPLUSMINUS_NAME,
            PSA_XMINUSMINUS_NAME,
            PSA_XMINUSPLUS_NAME,
            PSA_YPLUSPLUS_NAME,
            PSA_YMINUSMINUS_NAME,
            PSA_YPLUSMINUS_NAME,
            PSA_YMINUSPLUS_NAME,
            PSA_ZPLUS1_NAME,
            PSA_ZPLUS2_NAME,
            PSA_ZPLUS3_NAME,
            PSA_ZMINUS1_NAME,
            PSA_ZMINUS2_NAME,
            PSA_ZMINUS3_NAME
        ]

        LEGACY_OPS = [
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::HR_NAME,
            Analysis::HR_NAME,
            Analysis::HR_NAME,
            Analysis::HR_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::HR_NAME,
            Analysis::HR_NAME,
            Analysis::HR_NAME,
            Analysis::HR_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::APS_NAME,
            Analysis::PSA_NAME,
            Analysis::PSA_NAME,
            Analysis::PSA_NAME,
            Analysis::PSA_NAME,
            Analysis::PSA_NAME,
            Analysis::IMR_NAME,
            Analysis::COH_NAME,
            Analysis::COH_NAME,
            Analysis::IMR_NAME,
            Analysis::IMR_NAME,
            Analysis::IMR_NAME,
            Analysis::IMR_NAME,
            Analysis::IMR_NAME,
            Analysis::IMR_NAME,
            Analysis::IMR_NAME,
            Analysis::IMR_NAME,
            Analysis::IMR_NAME,
            Analysis::IMR_NAME,
            Analysis::AMP_NAME,
            Analysis::AMP_NAME,
            Analysis::AMP_NAME,
            Analysis::AMP_NAME,
            Analysis::AMP_NAME,
            Analysis::AMP_NAME,
            Analysis::AMP_NAME,
            Analysis::AMP_NAME,
            Analysis::CCR_NAME,
            Analysis::CCR_NAME,
            Analysis::CCR_NAME,
            Analysis::CCR_NAME,
            Analysis::CCR_NAME,
            Analysis::CCR_NAME,
            Analysis::CCR_NAME,
            Analysis::CCR_NAME,
            Analysis::CCR_NAME,
            Analysis::CCR_NAME,
            Analysis::CCR_NAME,
            Analysis::CCR_NAME,
            Analysis::CCR_NAME,
            Analysis::CCR_NAME,
            Analysis::CCR_NAME,
            Analysis::CCR_NAME,
            Analysis::CCR_NAME,
            Analysis::CCR_NAME,
            Analysis::CCR_NAME,
            Analysis::CCR_NAME,
            Analysis::CCR_NAME,
            Analysis::CCR_NAME,
            Analysis::CCR_NAME,
            Analysis::CCR_NAME,
            Analysis::CCR_NAME,
            Analysis::PSA_NAME,
            Analysis::PSA_NAME,
            Analysis::PSA_NAME,
            Analysis::PSA_NAME,
            Analysis::PSA_NAME,
            Analysis::PSA_NAME,
            Analysis::PSA_NAME,
            Analysis::PSA_NAME,
            Analysis::PSA_NAME,
            Analysis::PSA_NAME,
            Analysis::PSA_NAME,
            Analysis::PSA_NAME,
            Analysis::PSA_NAME,
            Analysis::PSA_NAME,
            Analysis::PSA_NAME,
            Analysis::PSA_NAME,
            Analysis::PSA_NAME,
            Analysis::PSA_NAME,
            Analysis::PSA_NAME,
            Analysis::PSA_NAME,
            Analysis::PSA_NAME,
            Analysis::PSA_NAME,
            Analysis::PSA_NAME,
            Analysis::PSA_NAME,
            Analysis::PSA_NAME,
            Analysis::PSA_NAME,
            Analysis::PSA_NAME,
            Analysis::PSA_NAME,
            Analysis::PSA_NAME
        ]

        LEGACY_SOURCES = [
            'V5', 'V5', 'V5', 'V5', 'V5', 'V5', 'V5', 'V5', 'V5', 'V5', 'V5',
            'V5', 'V5', 'V5', 'V5', 'V5', 'V5', 'V5', 'V5', 'V5', 'V5', 'V5',
            'V5', 'V5', 'V5', 'V5', 'II', 'II', 'II', 'II', 'II', 'II', 'II',
            'II', 'II', 'II', 'II', 'II', 'II', 'II', 'II', 'II', 'II', 'II',
            'II', 'II', 'II', 'II', 'II', 'II', 'II', 'II',
            '(V5,II)', '(V5,II)', '(V5,II)', '(V5,II)', '(V5,II)',
            '(V5,II)', '(V5,II)', '(V5,II)', '(V5,II)', '(V5,II)',
            '(V5,II)', '(V5,II)', '(V5,II)', '(V5,II)', '(V5,II)',
            '(V5,II)', '(V5,II)', '(V5,II)', 'V5',
            'II', 'V5', 'II', 'V5', 'II', 'V5', 'II',
            '(V5,II)', '(V5,II)', '(V5,II)', '(V5,II)', '(V5,II)',
            '(V5,II)', '(V5,II)', '(V5,II)', '(V5,II)', '(V5,II)',
            '(V5,II)', '(V5,II)', '(V5,II)', '(V5,II)', '(V5,II)',
            '(V5,II)', '(V5,II)', '(V5,II)', '(V5,II)', '(V5,II)',
            '(V5,II)', '(V5,II)', '(V5,II)', '(V5,II)', '(V5,II)',
            '(V5,II)', '(V5,II)', '(V5,II)', '(V5,II)', '(V5,II)',
            '(V5,II)', '(V5,II)', '(V5,II)', '(V5,II)', '(V5,II)',
            '(V5,II)', '(V5,II)', '(V5,II)', '(V5,II)', '(V5,II)',
            '(V5,II)', '(V5,II)', '(V5,II)', '(V5,II)', '(V5,II)',
            '(V5,II)', '(V5,II)', '(V5,II)', '(V5,II)', '(V5,II)',
            '(V5,II)', '(V5,II)', '(V5,II)', '(V5,II)'
        ]

        def Index.legacy_name( idx )
          return LEGACY_INDEXES[idx]
        end
      end

      class Sar
        STD_ANALYSES = [
          Analysis::HR_SYM,
          Analysis::APS_SYM,
          Analysis::CCR_SYM,
          Analysis::CPS_SYM,
          Analysis::AMP_SYM,
          Analysis::XAR_SYM,
          Analysis::IMR_SYM,
          Analysis::PSA_SYM,
          Analysis::COH_SYM
        ]

        STD_ANALYSIS_NAMES = [
          Analysis::HR_NAME,
          Analysis::APS_NAME,
          Analysis::CCR_NAME,
          Analysis::CPS_NAME,
          Analysis::AMP_NAME,
          Analysis::XAR_NAME,
          Analysis::IMR_NAME,
          Analysis::PSA_NAME,
          Analysis::COH_NAME
        ]

        def create_std_analyses( sig_a, sig_b )
          pair = "(#{sig_a},#{sig_b})"

          @analyses << Analysis.new( pair, 
                                        Analysis::HR_NAME, Analysis::HR_SYM )

          @analyses << Analysis.new( sig_a, 
                                        Analysis::APS_NAME, Analysis::APS_SYM )
          @analyses << Analysis.new( sig_b, 
                                        Analysis::APS_NAME, Analysis::APS_SYM )

          @analyses << Analysis.new( sig_a, 
                                        Analysis::AMP_NAME, Analysis::AMP_SYM )
          @analyses << Analysis.new( sig_b, 
                                        Analysis::AMP_NAME, Analysis::AMP_SYM )

          @analyses << Analysis.new( pair, 
                                        Analysis::CCR_NAME, Analysis::CCR_SYM )
          @analyses << Analysis.new( pair, 
                                        Analysis::PSA_NAME, Analysis::PSA_SYM )
          @analyses << Analysis.new( pair, 
                                        Analysis::IMR_NAME, Analysis::IMR_SYM )
          @analyses << Analysis.new( pair, 
                                        Analysis::XAR_NAME, Analysis::XAR_SYM )
          @analyses << Analysis.new( pair, 
                                        Analysis::COH_NAME, Analysis::COH_SYM )
        end

=begin rdoc
Return an Array of the 132 legacy indexes.
=end
        def legacy_indexes()
          arr = []

          # REFACTOR: make to_llo call this one
          hr_op = analysis(Analysis::HR_NAME, lead_pair_name())

          # GXX : 0 - 25
          op = analysis(Analysis::APS_NAME, primary_lead_name())
          arr << op.index(Index::APS_12_NAME)            # 0
          arr << op.index(Index::APS_OMEGA_NAME)
          arr << op.index(Index::APS_U1_NAME)
          arr << op.index(Index::APS_U2_NAME)
          arr << op.index(Index::APS_U3_NAME)
          arr << op.index(Index::APS_U3xy_NAME)          # 5
          arr << op.index(Index::APS_U4_NAME)
          arr << op.index(Index::APS_N1_NAME)
          arr << op.index(Index::APS_N3_NAME)
          arr << hr_op.index(Index::HR_S_NAME)
          arr << hr_op.index(Index::HR_SS_NAME)          # 10
          arr << hr_op.index(Index::HR_F_NAME)
          arr << hr_op.index(Index::HR_FF_NAME)
          arr << op.index(Index::APS_A1_NAME)
          arr << op.index(Index::APS_A2_NAME)
          arr << op.index(Index::APS_A3_NAME)            # 15
          arr << op.index(Index::APS_A4_NAME)
          arr << op.index(Index::APS_A5_NAME)
          arr << op.index(Index::APS_A55_NAME)
          arr << op.index(Index::APS_N2_NAME)
          arr << op.index(Index::APS_AA12_NAME)          # 20
          arr << op.index(Index::APS_AA34_NAME)
          arr << op.index(Index::APS_AA123_NAME)
          arr << op.index(Index::APS_AA1_NAME)
          arr << op.index(Index::APS_AA4_NAME)
          arr << op.index(Index::APS_U5_NAME)            # 25

          # GYY : 26 - 51
          op = analysis(Analysis::APS_NAME, secondary_lead_name())
          arr << op.index(Index::APS_12_NAME)
          arr << op.index(Index::APS_OMEGA_NAME)
          arr << op.index(Index::APS_U1_NAME)
          arr << op.index(Index::APS_U2_NAME)
          arr << op.index(Index::APS_U3_NAME)            # 30
          arr << op.index(Index::APS_U3xy_NAME)
          arr << op.index(Index::APS_U4_NAME)
          arr << op.index(Index::APS_N1_NAME)
          arr << op.index(Index::APS_N3_NAME)
          arr << hr_op.index(Index::HR_S_NAME)           # 35
          arr << hr_op.index(Index::HR_SS_NAME)
          arr << hr_op.index(Index::HR_F_NAME)
          arr << hr_op.index(Index::HR_FF_NAME)
          arr << op.index(Index::APS_A1_NAME)
          arr << op.index(Index::APS_A2_NAME)             # 40
          arr << op.index(Index::APS_A3_NAME)
          arr << op.index(Index::APS_A4_NAME)
          arr << op.index(Index::APS_A5_NAME)
          arr << op.index(Index::APS_A55_NAME)
          arr << op.index(Index::APS_N2_NAME)              # 45
          arr << op.index(Index::APS_AA12_NAME)
          arr << op.index(Index::APS_AA34_NAME)
          arr << op.index(Index::APS_AA123_NAME)
          arr << op.index(Index::APS_AA1_NAME)
          arr << op.index(Index::APS_AA4_NAME)             # 50
          arr << op.index(Index::APS_U5_NAME)

          # QXY : 52 - 57
          psa_op = analysis(Analysis::PSA_NAME, lead_pair_name())
          arr << psa_op.index(Index::PSA_PPLUS_NAME)
          arr << psa_op.index(Index::PSA_PMINUS_NAME)
          arr << psa_op.index(Index::PSA_WW_NAME)
          arr << psa_op.index(Index::PSA_PWWPLUS_NAME)     # 55
          arr << psa_op.index(Index::PSA_PWWMINUS_NAME)

          imr_op = analysis(Analysis::IMR_NAME, lead_pair_name())
          arr << imr_op.index(Index::IMR_L_NAME)

          # RH : 58 - 59
          op = analysis(Analysis::COH_NAME, lead_pair_name())
          arr << op.index(Index::COH_Q1_NAME)
          arr << op.index(Index::COH_Q2_NAME)

          # PIH : 60 -69
          arr << imr_op.index(Index::IMR_D1_NAME)          # 60
          arr << imr_op.index(Index::IMR_D2_NAME)
          arr << imr_op.index(Index::IMR_f_NAME)
          arr << imr_op.index(Index::IMR_M1_NAME)
          arr << imr_op.index(Index::IMR_M3_NAME)
          arr << imr_op.index(Index::IMR_M2_NAME)          # 65
          arr << imr_op.index(Index::IMR_M4_NAME)
          arr << imr_op.index(Index::IMR_M5_NAME)
          arr << imr_op.index(Index::IMR_M6_NAME)
          arr << imr_op.index(Index::IMR_ff_NAME)

          # HA : 70 - 77
          v5_op = analysis(Analysis::AMP_NAME, primary_lead_name())
          ii_op = analysis(Analysis::AMP_NAME, secondary_lead_name())
          arr << v5_op.index(Index::AMP_HYPER_NAME)        # 70
          arr << ii_op.index(Index::AMP_HYPER_NAME)
          arr << v5_op.index(Index::AMP_HYPO_NAME)
          arr << ii_op.index(Index::AMP_HYPO_NAME)
          arr << v5_op.index(Index::AMP_NPLUS_NAME)
          arr << ii_op.index(Index::AMP_NPLUS_NAME)        # 75
          arr << v5_op.index(Index::AMP_NMINUS_NAME)
          arr << ii_op.index(Index::AMP_NMINUS_NAME)

          # VXY : 78 - 102
          op = analysis(Analysis::CCR_NAME, lead_pair_name())
          arr << op.index(Index::CCR_rrr_NAME)
          arr << op.index(Index::CCR_RRR_NAME)
          arr << op.index(Index::CCR_r_NAME)               # 80
          arr << op.index(Index::CCR_R_NAME)
          arr << op.index(Index::CCR_RR_NAME)
          arr << op.index(Index::CCR_rr_NAME)
          arr << op.index(Index::CCR_rR_NAME)
          arr << op.index(Index::CCR_RPLUS_NAME)           # 85
          arr << op.index(Index::CCR_RMINUS_NAME)
          arr << op.index(Index::CCR_RwPLUS_NAME)
          arr << op.index(Index::CCR_RwMINUS_NAME)
          arr << op.index(Index::CCR_PT1_NAME)
          arr << op.index(Index::CCR_PT2_NAME)             # 90
          arr << op.index(Index::CCR_pt1_NAME)
          arr << op.index(Index::CCR_pt2_NAME)
          arr << op.index(Index::CCR_Rn_NAME)
          arr << op.index(Index::CCR_RVVPLUS_NAME)
          arr << op.index(Index::CCR_RVVMINUS_NAME)        # 95
          arr << op.index(Index::CCR_RCARET_NAME)
          arr << op.index(Index::CCR_NOTR_NAME)
          arr << op.index(Index::CCR_RNOT_NAME)
          arr << op.index(Index::CCR_r2_NAME)
          arr << op.index(Index::CCR_R2_NAME)              # 100
          arr << op.index(Index::CCR_r22_NAME)
          arr << op.index(Index::CCR_RM_NAME)

          # Q : 103 - 131
          arr << psa_op.index(Index::PSA_TPLUS_NAME)
          arr << psa_op.index(Index::PSA_TMINUS_NAME)
          arr << psa_op.index(Index::PSA_UPLUS_NAME)       # 105
          arr << psa_op.index(Index::PSA_UMINUS_NAME)
          arr << psa_op.index(Index::PSA_WPLUS_NAME)
          arr << psa_op.index(Index::PSA_WMINUS_NAME)
          arr << psa_op.index(Index::PSA_W_NAME)
          arr << psa_op.index(Index::PSA_PPLUS10_NAME)     # 110
          arr << psa_op.index(Index::PSA_PPLUS15_NAME)
          arr << psa_op.index(Index::PSA_PPLUSGT15_NAME)
          arr << psa_op.index(Index::PSA_PMINUS10_NAME)
          arr << psa_op.index(Index::PSA_PMINUS15_NAME)
          arr << psa_op.index(Index::PSA_PMINUSGT15_NAME)  # 115
          arr << psa_op.index(Index::PSA_VPLUS_NAME)
          arr << psa_op.index(Index::PSA_VMINUS_NAME)
          arr << psa_op.index(Index::PSA_XPLUSPLUS_NAME)
          arr << psa_op.index(Index::PSA_XPLUSMINUS_NAME)
          arr << psa_op.index(Index::PSA_XMINUSMINUS_NAME) # 120
          arr << psa_op.index(Index::PSA_XMINUSPLUS_NAME)
          arr << psa_op.index(Index::PSA_YPLUSPLUS_NAME)
          arr << psa_op.index(Index::PSA_YMINUSMINUS_NAME)
          arr << psa_op.index(Index::PSA_YPLUSMINUS_NAME)
          arr << psa_op.index(Index::PSA_YMINUSPLUS_NAME)  # 125
          arr << psa_op.index(Index::PSA_ZPLUS1_NAME)
          arr << psa_op.index(Index::PSA_ZPLUS2_NAME)
          arr << psa_op.index(Index::PSA_ZPLUS3_NAME)
          arr << psa_op.index(Index::PSA_ZMINUS1_NAME)
          arr << psa_op.index(Index::PSA_ZMINUS2_NAME)     # 130
          arr << psa_op.index(Index::PSA_ZMINUS3_NAME)

          arr
        end

        def to_llo()
          llo = []
          hr_op = analysis(Analysis::HR_NAME, lead_pair_name())

          # GXX : 0 - 25
          op = analysis(Analysis::APS_NAME, primary_lead_name())
          llo << op.index(Index::APS_12_NAME).value.to_i            # 0
          llo << op.index(Index::APS_OMEGA_NAME).value.to_i
          llo << op.index(Index::APS_U1_NAME).value.to_i
          llo << op.index(Index::APS_U2_NAME).value.to_i
          llo << op.index(Index::APS_U3_NAME).value.to_i
          llo << op.index(Index::APS_U3xy_NAME).value.to_i          # 5
          llo << op.index(Index::APS_U4_NAME).value.to_i
          llo << op.index(Index::APS_N1_NAME).value.to_i
          llo << op.index(Index::APS_N3_NAME).value.to_i
          llo << hr_op.index(Index::HR_S_NAME).value.to_i
          llo << hr_op.index(Index::HR_SS_NAME).value.to_i          # 10
          llo << hr_op.index(Index::HR_F_NAME).value.to_i
          llo << hr_op.index(Index::HR_FF_NAME).value.to_i
          llo << op.index(Index::APS_A1_NAME).value.to_i
          llo << op.index(Index::APS_A2_NAME).value.to_i
          llo << op.index(Index::APS_A3_NAME).value.to_i            # 15
          llo << op.index(Index::APS_A4_NAME).value.to_i
          llo << op.index(Index::APS_A5_NAME).value.to_i
          llo << op.index(Index::APS_A55_NAME).value.to_i
          llo << op.index(Index::APS_N2_NAME).value.to_i
          llo << op.index(Index::APS_AA12_NAME).value.to_i          # 20
          llo << op.index(Index::APS_AA34_NAME).value.to_i
          llo << op.index(Index::APS_AA123_NAME).value.to_i
          llo << op.index(Index::APS_AA1_NAME).value.to_i
          llo << op.index(Index::APS_AA4_NAME).value.to_i
          llo << op.index(Index::APS_U5_NAME).value.to_i            # 25

          # GYY : 26 - 51
          op = analysis(Analysis::APS_NAME, secondary_lead_name())
          llo << op.index(Index::APS_12_NAME).value.to_i
          llo << op.index(Index::APS_OMEGA_NAME).value.to_i
          llo << op.index(Index::APS_U1_NAME).value.to_i
          llo << op.index(Index::APS_U2_NAME).value.to_i
          llo << op.index(Index::APS_U3_NAME).value.to_i            # 30
          llo << op.index(Index::APS_U3xy_NAME).value.to_i
          llo << op.index(Index::APS_U4_NAME).value.to_i
          llo << op.index(Index::APS_N1_NAME).value.to_i
          llo << op.index(Index::APS_N3_NAME).value.to_i
          llo << hr_op.index(Index::HR_S_NAME).value.to_i           # 35
          llo << hr_op.index(Index::HR_SS_NAME).value.to_i
          llo << hr_op.index(Index::HR_F_NAME).value.to_i
          llo << hr_op.index(Index::HR_FF_NAME).value.to_i
          llo << op.index(Index::APS_A1_NAME).value.to_i
          llo << op.index(Index::APS_A2_NAME).value.to_i             # 40
          llo << op.index(Index::APS_A3_NAME).value.to_i
          llo << op.index(Index::APS_A4_NAME).value.to_i
          llo << op.index(Index::APS_A5_NAME).value.to_i
          llo << op.index(Index::APS_A55_NAME).value.to_i
          llo << op.index(Index::APS_N2_NAME).value.to_i              # 45
          llo << op.index(Index::APS_AA12_NAME).value.to_i
          llo << op.index(Index::APS_AA34_NAME).value.to_i
          llo << op.index(Index::APS_AA123_NAME).value.to_i
          llo << op.index(Index::APS_AA1_NAME).value.to_i
          llo << op.index(Index::APS_AA4_NAME).value.to_i             # 50
          llo << op.index(Index::APS_U5_NAME).value.to_i

          # QXY : 52 - 57
          psa_op = analysis(Analysis::PSA_NAME, lead_pair_name())
          llo << psa_op.index(Index::PSA_PPLUS_NAME).value.to_i
          llo << psa_op.index(Index::PSA_PMINUS_NAME).value.to_i
          llo << psa_op.index(Index::PSA_WW_NAME).value.to_i
          llo << psa_op.index(Index::PSA_PWWPLUS_NAME).value.to_i     # 55
          llo << psa_op.index(Index::PSA_PWWMINUS_NAME).value.to_i

          imr_op = analysis(Analysis::IMR_NAME, lead_pair_name())
          llo << imr_op.index(Index::IMR_L_NAME).value.to_i

          # RH : 58 - 59
          op = analysis(Analysis::COH_NAME, lead_pair_name())
          llo << op.index(Index::COH_Q1_NAME).value.to_i
          llo << op.index(Index::COH_Q2_NAME).value.to_i

          # PIH : 60 -69
          llo << imr_op.index(Index::IMR_D1_NAME).value.to_i          # 60
          llo << imr_op.index(Index::IMR_D2_NAME).value.to_i
          llo << imr_op.index(Index::IMR_f_NAME).value.to_i
          llo << imr_op.index(Index::IMR_M1_NAME).value.to_i
          llo << imr_op.index(Index::IMR_M3_NAME).value.to_i
          llo << imr_op.index(Index::IMR_M2_NAME).value.to_i          # 65
          llo << imr_op.index(Index::IMR_M4_NAME).value.to_i
          llo << imr_op.index(Index::IMR_M5_NAME).value.to_i
          llo << imr_op.index(Index::IMR_M6_NAME).value.to_i
          llo << imr_op.index(Index::IMR_ff_NAME).value.to_i

          # HA : 70 - 77
          v5_op = analysis(Analysis::AMP_NAME, primary_lead_name())
          ii_op = analysis(Analysis::AMP_NAME, secondary_lead_name())
          llo << v5_op.index(Index::AMP_HYPER_NAME).value.to_i        # 70
          llo << ii_op.index(Index::AMP_HYPER_NAME).value.to_i
          llo << v5_op.index(Index::AMP_HYPO_NAME).value.to_i
          llo << ii_op.index(Index::AMP_HYPO_NAME).value.to_i
          llo << v5_op.index(Index::AMP_NPLUS_NAME).value.to_i
          llo << ii_op.index(Index::AMP_NPLUS_NAME).value.to_i        # 75
          llo << v5_op.index(Index::AMP_NMINUS_NAME).value.to_i
          llo << ii_op.index(Index::AMP_NMINUS_NAME).value.to_i

          # VXY : 78 - 102
          op = analysis(Analysis::CCR_NAME, lead_pair_name())
          llo << op.index(Index::CCR_rrr_NAME).value.to_i
          llo << op.index(Index::CCR_RRR_NAME).value.to_i
          llo << op.index(Index::CCR_r_NAME).value.to_i               # 80
          llo << op.index(Index::CCR_R_NAME).value.to_i
          llo << op.index(Index::CCR_RR_NAME).value.to_i
          llo << op.index(Index::CCR_rr_NAME).value.to_i
          llo << op.index(Index::CCR_rR_NAME).value.to_i
          llo << op.index(Index::CCR_RPLUS_NAME).value.to_i           # 85
          llo << op.index(Index::CCR_RMINUS_NAME).value.to_i
          llo << op.index(Index::CCR_RwPLUS_NAME).value.to_i
          llo << op.index(Index::CCR_RwMINUS_NAME).value.to_i
          llo << op.index(Index::CCR_PT1_NAME).value.to_i
          llo << op.index(Index::CCR_PT2_NAME).value.to_i             # 90
          llo << op.index(Index::CCR_pt1_NAME).value.to_i
          llo << op.index(Index::CCR_pt2_NAME).value.to_i
          llo << op.index(Index::CCR_Rn_NAME).value.to_i
          llo << op.index(Index::CCR_RVVPLUS_NAME).value.to_i
          llo << op.index(Index::CCR_RVVMINUS_NAME).value.to_i        # 95
          llo << op.index(Index::CCR_RCARET_NAME).value.to_i
          llo << op.index(Index::CCR_NOTR_NAME).value.to_i
          llo << op.index(Index::CCR_RNOT_NAME).value.to_i
          llo << op.index(Index::CCR_r2_NAME).value.to_i
          llo << op.index(Index::CCR_R2_NAME).value.to_i              # 100
          llo << op.index(Index::CCR_r22_NAME).value.to_i
          llo << op.index(Index::CCR_RM_NAME).value.to_i

          # Q : 103 - 131
          llo << psa_op.index(Index::PSA_TPLUS_NAME).value.to_i
          llo << psa_op.index(Index::PSA_TMINUS_NAME).value.to_i
          llo << psa_op.index(Index::PSA_UPLUS_NAME).value.to_i       # 105
          llo << psa_op.index(Index::PSA_UMINUS_NAME).value.to_i
          llo << psa_op.index(Index::PSA_WPLUS_NAME).value.to_i
          llo << psa_op.index(Index::PSA_WMINUS_NAME).value.to_i
          llo << psa_op.index(Index::PSA_W_NAME).value.to_i
          llo << psa_op.index(Index::PSA_PPLUS10_NAME).value.to_i     # 110
          llo << psa_op.index(Index::PSA_PPLUS15_NAME).value.to_i
          llo << psa_op.index(Index::PSA_PPLUSGT15_NAME).value.to_i
          llo << psa_op.index(Index::PSA_PMINUS10_NAME).value.to_i
          llo << psa_op.index(Index::PSA_PMINUS15_NAME).value.to_i
          llo << psa_op.index(Index::PSA_PMINUSGT15_NAME).value.to_i  # 115
          llo << psa_op.index(Index::PSA_VPLUS_NAME).value.to_i
          llo << psa_op.index(Index::PSA_VMINUS_NAME).value.to_i
          llo << psa_op.index(Index::PSA_XPLUSPLUS_NAME).value.to_i
          llo << psa_op.index(Index::PSA_XPLUSMINUS_NAME).value.to_i
          llo << psa_op.index(Index::PSA_XMINUSMINUS_NAME).value.to_i # 120
          llo << psa_op.index(Index::PSA_XMINUSPLUS_NAME).value.to_i
          llo << psa_op.index(Index::PSA_YPLUSPLUS_NAME).value.to_i
          llo << psa_op.index(Index::PSA_YMINUSMINUS_NAME).value.to_i
          llo << psa_op.index(Index::PSA_YPLUSMINUS_NAME).value.to_i
          llo << psa_op.index(Index::PSA_YMINUSPLUS_NAME).value.to_i  # 125
          llo << psa_op.index(Index::PSA_ZPLUS1_NAME).value.to_i
          llo << psa_op.index(Index::PSA_ZPLUS2_NAME).value.to_i
          llo << psa_op.index(Index::PSA_ZPLUS3_NAME).value.to_i
          llo << psa_op.index(Index::PSA_ZMINUS1_NAME).value.to_i
          llo << psa_op.index(Index::PSA_ZMINUS2_NAME).value.to_i     # 130
          llo << psa_op.index(Index::PSA_ZMINUS3_NAME).value.to_i

          return llo
        end

=begin rdoc
Generate an extended-llo array. 
=end
        def to_llo_x()
          llo = to_llo

          op = analysis(Analysis::APS_NAME, primary_lead_name())
          llo << op.index(Index::APS_C1_NAME).value.to_f
          llo << op.index(Index::APS_C2_NAME).value.to_f
          llo << op.index(Index::APS_C3_NAME).value.to_f

          op = analysis(Analysis::APS_NAME, secondary_lead_name())
          llo << op.index(Index::APS_C1_NAME).value.to_f
          llo << op.index(Index::APS_C2_NAME).value.to_f
          llo << op.index(Index::APS_C3_NAME).value.to_f

          op = analysis(Analysis::PSA_NAME, lead_pair_name())
          llo << op.index(Index::PSA_D1_NAME).value.to_i
          llo << op.index(Index::PSA_D2_NAME).value.to_i
          llo << op.index(Index::PSA_D3_NAME).value.to_i

          op = analysis(Analysis::IMR_NAME, lead_pair_name())
          llo << op.index(Index::IMR_B1_NAME).value.to_i
          llo << op.index(Index::IMR_B2_NAME).value.to_i

          op = analysis(Analysis::CCR_NAME, lead_pair_name())
          llo << op.index(Index::CCR_S1_NAME).value.to_i
          llo << op.index(Index::CCR_S2_NAME).value.to_i
          llo << op.index(Index::CCR_S3_NAME).value.to_i
          llo << op.index(Index::CCR_S4_NAME).value.to_i
          llo << op.index(Index::CCR_S5_NAME).value.to_i

          llo
        end
      end

    end
  end
end
