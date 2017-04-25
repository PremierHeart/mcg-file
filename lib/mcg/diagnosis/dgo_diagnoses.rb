#!/usr/bin/env ruby
# DGO standard (built-in) diagnoses
# (c) Copyright 2017 Premier Heart, LLC

module Mpa
  
  module Diagnosis

    module Dgo

      class Diagnosis

        # Impression
        NORM_NAME = 'Normal'
        NORM_SYM = 'NORM'

        ABNO_NAME = 'Abnormal'
        ABNO_SYM = 'ABNORM'

        BORD_NAME = 'Borderline'
        BORD_SYM = 'BORD'

        BL_ARRY_NAME = 'Borderline (arrhythmia)'
        BL_ARRY_SYM = 'BLARRY'

        BL_AUTO_NAME = 'Borderline (autonomic)'
        BL_AUTO_SYM = 'BLAUTO'

        # Primary diagnoses
        LISCH_NAME = 'Local Ischemia'
        LISCH_SYM = 'CAD'

        BL_LISCH_NAME = 'Local Ischemia (borderline)'
        BL_LISCH_SYM = 'BLCAD'

        GISCH_NAME = 'Global Ischemia'
        GISCH_SYM = 'NCI'

        BL_GISCH_NAME = 'Global Ischemia (borderline)'
        BL_GISCH_SYM = 'BLNCI'

        SEV_RAW_NAME = 'Raw Disease Severity'
        SEV_RAW_SYM  = 'RSEV'

        SEVERITY_NAME = 'Disease Severity'
        SEVERITY_SYM  = 'SEV'

        SEV_SCORE_NAME  = 'Disease Severity Score'
        SEV_SCORE_SYM  =  'DS'

        SEV_SUM_NAME  = 'Disease Severity Sum'
        SEV_SUM_SYM  =  'DSSum'

        SEV_COUNT_NAME  = 'Disease Severity Count'
        SEV_COUNT_SYM  =  'DSCount'

        SEV_OLD_NAME  = 'Disease Severity Legacy Score'
        SEV_OLD_SYM  =  'DSOld'

        # Secondary diagnoses
      
        VH_NAME = 'Ventricular Hypertrophy'
        VH_SYM = 'A'
        VH_ALT_SYM = 'H'

        BIVH_NAME = 'Biventricular Hypertrophy'
        BIVH_SYM = 'BVH'

        LVH_NAME = 'Left Ventricular Hypertrophy'
        LVH_SYM = 'LVH'

        RVH_NAME = 'Right Ventricular Hypertrophy'
        RVH_SYM = 'RVH'

        ISCHEMIA_NAME = 'Ischemia'
        ISCHEMIA_SYM = 'C'

        RHD_NAME = 'Rheumatic HD'
        RHD_SYM = 'F'

        CHD_NAME = 'Congenital HD'
        CHD_SYM = 'G'

        MI_NAME = 'Myocardial Infarct'
        MI_SYM = 'I'
        MI_ALT_SYM = 'C(I)'

        MYOCARD_NAME = 'Myocarditis'
        MYOCARD_SYM = 'K'

        CARDMYO_NAME = 'Cardio Myopathy'
        CARDMYO_SYM = 'M'

        AFIB_NAME = 'Atrial Fibrillation'
        AFIB_SYM = 'N'

        VFIB_NAME = 'Ventricular Fibrillation'
        VFIB_SYM = 'VFIB'

        PFIB_NAME = 'Potential Fibrillation'
        PFIB_SYM = 'PFIB'

        PHD_NAME = 'Pulmonary HD'
        PHD_SYM = 'U'

        ARRY_NAME = 'Arrhythmia'
        ARRY_SYM = 'T'

        VARRY_NAME = 'Ventricular Arrhythmia'
        VARRY_SYM = 'V'

        IARRY_NAME = 'Incipient Arrhythmia'
        IARRY_SYM = 'IARRY'

        TARRY_NAME = 'Intermittent Arrhythmia'
        TARRY_SYM = 'TARRY'

        # Tertiary diagnoses
        EF_NAME = 'Ejection Fraction'
        EF_SYM = 'EF'

        REMOD_NAME = 'Myocardial Remodelling'
        REMOD_SYM = 'MR'

        DECOMP_NAME = 'Decreased Myocardial Compliance'
        DECOMP_SYM = 'DMC'

        INCOMP_NAME = 'Increased Myocardial Compliance'
        INCOMP_SYM = 'IMC'

        LASYNC_NAME = 'Local Asynchrony'
        LASYNC_SYM = 'LA'

        LASYNC_AB_NAME = 'Signal B lags behind signal A (local)'
        LASYNC_AB_SYM = 'LAV5II'

        LASYNC_BA_NAME = 'Signal A lags behind signal B (local)'
        LASYNC_BA_SYM = 'LAIIV5'

        # NOTE: 'Fibrillation' is an aggregate diagnoses used for DB/reports
        FIB_NAME = 'Fibrillation'
        FIB_SYM = 'FIB'

        GASYNC_NAME = 'Global Asynchrony'
        GASYNC_SYM = 'GA'

        GASYNC_AB_NAME = 'Signal B lags behind signal A (global)'
        GASYNC_AB_SYM = 'GAV5II'

        GASYNC_BA_NAME = 'Signal A lags behind signal B (global)'
        GASYNC_BA_SYM = 'GAIIV5'

        TACHY_NAME = 'Tachycardia'
        TACHY_SYM = 'TC'

        BRADY_NAME = 'Bradycardia'
        BRADY_SYM = 'BC'

        PF_NAME = 'Power Failure'
        PF_SYM = 'PF'


        # Meta-diagnoses : Filtering of diagnoses performed by legacy DIA code

        IMP_NAME = 'Impression'
        IMP_SYM = 'IMP'

        IMPSTR_NAME = 'Impression (text)'
        IMPSTR_SYM = 'IMPSTR'

        SUGG1_NAME = 'Suggestion (1)'
        SUGG1_SYM = 'SUGG1'

        SUGG2_NAME = 'Suggestion (2)'
        SUGG2_SYM = 'SUGG2'

        SUGG3_NAME = 'Suggestion (3)'
        SUGG3_SYM = 'SUGG3'

        SUGG4_NAME = 'Suggestion (4)'
        SUGG4_SYM = 'SUGG4'

        FINAL1_NAME = 'Final Suggestion'
        FINAL1_SYM = 'FIN1'

        FINAL2_NAME = 'Final Suggestion (secondary)'
        FINAL2_SYM = 'FIN2'

        FINAL3_NAME = 'Final Suggestion (tertiary)'
        FINAL3_SYM = 'FIN3'

        FINAL4_NAME = 'Final Suggestion (quaternary)'
        FINAL4_SYM = 'FIN4'

        REL_FACTOR1_NAME = 'Relative Factor'
        REL_FACTOR1_SYM = 'RF1'

        REL_FACTOR2_NAME = 'Relative Factor (secondary)'
        REL_FACTOR2_SYM = 'RF2'

        REL_FACTOR3_NAME = 'Relative Factor (tertiary)'
        REL_FACTOR3_SYM = 'RF3'

        REL_FACTOR4_NAME = 'Relative Factor (quaternary)'
        REL_FACTOR4_SYM = 'RF4'

        # V = Ventricular Arrythmia, T = Arrythmia, B = ??
        DVBT_NAME = 'DVBT'
        DVBT_SYM = 'DVBT'

        # I = Infarct, C = Ischemia, K = Myocarditis
        DKIC_NAME = 'DKIC'
        DKIC_SYM = 'DKIC'

        # Age group -- used by subsequent (post-preliminary)  diagnoses
        AGEGRP_NAME = 'Age Group'
        AGEGRP_SYM  = 'AGRP'

        # Heart Rate -- used by report-gen, and possibly by later diagnoses
        HR_NAME = 'Heart Rate'
        HR_SYM = 'HR'

        # CIM -- return value of has_cim in Primary diagnosis. For debugging.
        CIM_NAME = 'Has CIM'
        CIM_SYM = 'CIM'
      
        # standrad MCG output diagnoses
        MCG_DIAGS = [
          LISCH_NAME,
          BL_LISCH_NAME,
          GISCH_NAME,
          BL_GISCH_NAME,
          VH_NAME,
          BIVH_NAME,
          LVH_NAME,
          RVH_NAME,
          ISCHEMIA_NAME,
          RHD_NAME,
          CHD_NAME,
          MI_NAME,
          MYOCARD_NAME,
          CARDMYO_NAME,
          AFIB_NAME,
          VFIB_NAME,
          PFIB_NAME,
          PHD_NAME,
          ARRY_NAME,
          VARRY_NAME,
          IARRY_NAME,
          TARRY_NAME,
          EF_NAME,
          REMOD_NAME,
          DECOMP_NAME,
          INCOMP_NAME,
          LASYNC_NAME,
          LASYNC_AB_NAME,
          LASYNC_BA_NAME,
          FIB_NAME,
          GASYNC_NAME,
          GASYNC_AB_NAME,
          GASYNC_BA_NAME,
          TACHY_NAME,
          BRADY_NAME,
          PF_NAME
        ]

        # Conversion from symbol to name (for reading ABC files)
        DIA_DIAG_MAP = {
          VH_SYM => VH_NAME,
          ISCHEMIA_SYM => ISCHEMIA_NAME,
          RHD_SYM => RHD_NAME,
          CHD_SYM => CHD_NAME,
          MI_SYM => MI_NAME,
          MI_ALT_SYM => MI_NAME,
          MYOCARD_SYM => MYOCARD_NAME,
          CARDMYO_SYM => CARDMYO_NAME,
          AFIB_SYM => AFIB_NAME,
          PHD_SYM => PHD_NAME,
          VARRY_SYM => VARRY_NAME,
          ARRY_SYM => ARRY_NAME,
          AGEGRP_SYM => AGEGRP_NAME
        }

        # NOTE: LEGACY DB SCHEMA SUPPORT
        # ID in results_comment table
        CMT_ID_EF         = 139
        CMT_ID_INFARCT    = 140
        CMT_ID_BVH        = 141
        CMT_ID_LVH        = 142
        CMT_ID_RVH        = 143
        CMT_ID_VARR       = 144
        CMT_ID_ARR        = 145
        CMT_ID_MYOREMOD   = 146
        CMT_ID_DECMYO     = 147
        CMT_ID_INCMYO     = 148
        CMT_ID_LASYNCV5   = 149
        CMT_ID_LASYNCII   = 150
        CMT_ID_GASYNCV5   = 151
        CMT_ID_GASYNCII   = 152
        CMT_ID_TACHY      = 153
        CMT_ID_BRADY      = 154
        CMT_ID_POWFAIL    = 155
        CMT_ID_MYOINFARCT = 156
        CMT_ID_CONGENITAL = 157
        CMT_ID_MYOCARD    = 158
        CMT_ID_RHEUMATIC  = 159
        CMT_ID_CARDIOMYO  = 162
        CMT_ID_PULMONARY  = 163
        CMT_ID_VENTHYPER  = 164
        CMT_ID_PFIB       = 165
        CMT_ID_AFIB       = 166
        CMT_ID_VFIB       = 167
        CMT_ID_AVFIB      = 168
        CMT_ID_IARRY      = 169

        # NOTE: LEGACY DB SCHEMA SUPPORT
        # Mapping from results_comment table
        DIAG_COMMENT = {
          CMT_ID_EF => 'ejection_fraction',
          CMT_ID_BVH => 'biventricular_hypertrophy',
          CMT_ID_LVH => 'left_ventricular_hypertrophy',
          CMT_ID_RVH => 'right_ventricular_hypertrophy',
          CMT_ID_VARR => 'ventricular_arrhythmia',
          CMT_ID_ARR => 'atrial_fibrillation',
          CMT_ID_MYOREMOD => 'myocardial_remodelling',
          CMT_ID_DECMYO => 'decreased_myocardial_compliance',
          CMT_ID_INCMYO => 'increased_myocardial_compliance',
          CMT_ID_LASYNCV5 => 'local_asynchrony_lead_v5_behind_lead_ii',
          CMT_ID_LASYNCII => 'local_asynchrony_lead_ii_behind_lead_v5',
          CMT_ID_GASYNCV5 => 'global_asynchrony_lead_v5_behind_lead_ii',
          CMT_ID_GASYNCII => 'global_asynchrony_lead_ii_behind_lead_v5',
          CMT_ID_TACHY   => 'tachycardia',
          CMT_ID_BRADY   => 'bradycardia',
          CMT_ID_POWFAIL => 'power_failure',
          CMT_ID_MYOINFARCT => 'myocardial_infarct',
          CMT_ID_CONGENITAL => 'congenital_hd',
          CMT_ID_MYOCARD   => 'myocarditis',
          CMT_ID_RHEUMATIC => 'rheumatic_hd',
          CMT_ID_CARDIOMYO => 'cardio_myopathy',
          CMT_ID_PULMONARY => 'pulmonary_hd',
          CMT_ID_VENTHYPER => 'ventricular_hypertrophy',
          CMT_ID_PFIB  => 'potential_fibrillation',
          CMT_ID_AFIB  => 'atrial_fibrillation',
          CMT_ID_VFIB  => 'ventricular_fibrillation',
          CMT_ID_AVFIB => 'atrial_ventricular_fibrillation',
          CMT_ID_IARRY => 'incipient_arrhythmia',
          CMT_ID_INFARCT => '_INFARCT' # Was 'Localized Asynchrony. Likely conditions are myocardial hibernation, acute myocardial infarct, prolonged hypoxia, general anesthesia, myocardial contusion, surgical intervention.'
        }

        # convert a diagnosis name to its symbol
        def self.name_to_sym(str)
          name_sym = constants.select { |s| const_get(s) == str }.first
          name_sym ? const_get(name_sym.to_s.sub(/_NAME$/, '_SYM').to_sym) : nil
        end

        # convert a diagnosis symbol to its name
        def self.sym_to_name(str)
          sym_sym = constants.select { |s| const_get(s) == str }.first
          sym_sym ? const_get(sym_sym.to_s.sub(/_SYM$/, '_NAME').to_sym) : nil
        end
      end

      class Algorithm

        PRELIM_NAME = 'MCG Preliminary Analysis'
        PRELIM_SYM = 'mcg-pre'

        IMPRESSION_NAME = 'MCG Impression Analysis'
        IMPRESSION_SYM = 'mcg-imp'

        PRIMARY_NAME = 'MCG Primary Analysis'
        PRIMARY_SYM = 'mcg-1'

        ISCHEMIA_NAME = 'MCG Ischemia Analysis'
        ISCHEMIA_SYM = 'mcg-cad'

        SEVERITY_NAME = 'MCG Disease Severity Analysis'
        SEVERITY_SYM = 'mcg-sev'

        SECONDARY_NAME = 'MCG Secondary Analysis'
        SECONDARY_SYM = 'mcg-2'

        TERTIARY_NAME = 'MCG Tertiary Analysis'
        TERTIARY_SYM = 'mcg-3'

        FINAL_NAME = 'MCG Final Analysis'
        FINAL_SYM = 'mcg-fin'

        CLINICAL_NAME = 'Clinical Review'
        CLINICAL_SYM = 'clinic'
      end

    end
  end
end
