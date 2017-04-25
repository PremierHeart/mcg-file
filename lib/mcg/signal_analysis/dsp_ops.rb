#!/usr/bin/env ruby
# (c) Copyright 2017 Premier Heart, LLC

require 'mpa/signal_analysis/dsp'

module Mpa
  
  module SignalAnalysis

    module Dsp

      class Op
        # Names for built-in operations

        QRS_NAME='qrs complex'
        QRS_SYM='qrs'
        QRS_DOMAIN='time'
        QRS_LABEL='representative qrs complex'
        QRS_X_AXIS='time in milliseconds (ms)'
        QRS_Y_AXIS='amplitude in millivolts (mV)'

        AMP_NAME='amplitude'
        AMP_SYM='amp'
        AMP_DOMAIN='amplitude'
        AMP_LABEL='ratio of frequency to amplitude'
        AMP_X_AXIS='amplitude in millivolts (mV)'
        AMP_Y_AXIS='count'

        APS_NAME='auto power spectrum'
        APS_SYM='aps'
        APS_DOMAIN='frequency'
        APS_LABEL='power peaks in signal'
        APS_X_AXIS='frequency in Hz'
        APS_Y_AXIS='power in watts'

        CPS_NAME='cross power spectrum'
        CPS_SYM='cps'
        CPS_DOMAIN='frequency'
        CPS_LABEL='power peaks in signal pair'
        CPS_X_AXIS='frequency in Hz'
        CPS_Y_AXIS='power in watts'

        CCR_NAME='cross correlation'
        CCR_SYM='ccr'
        CCR_DOMAIN='frequency'
        CCR_LABEL='r-wave correlation of signals'
        CCR_X_AXIS='time in milliseconds (ms)'
        CCR_Y_AXIS='amplitude in millivolts (mV)'

        IMR_NAME='impulse response'
        IMR_SYM='imr'
        IMR_DOMAIN='transfer'
        IMR_LABEL='ratio of latency to amplitude'
        IMR_X_AXIS='latency'
        IMR_Y_AXIS='amplitude in millivolts (mV)'

        PSA_NAME='phase shift angle'
        PSA_SYM='psa'
        PSA_DOMAIN='transfer'
        PSA_LABEL='degree of synchronization between signals'
        PSA_X_AXIS='frequency in Hz'
        PSA_Y_AXIS='phase shift in degrees'

        XAR_NAME='transfer amplitude ratio'
        XAR_SYM='xar'
        XAR_DOMAIN='transfer'
        XAR_LABEL='ratio of cross to auto power spectrum'
        XAR_X_AXIS='frequency in Hz'
        XAR_Y_AXIS='amplitude ratio of cps and aps'

        COH_NAME='coherence'
        COH_SYM='coh'
        COH_DOMAIN='correlation'
        COH_LABEL='ratio of square of cross to auto power spectrum'
        COH_X_AXIS='frequency in Hz'
        COH_Y_AXIS='amplitude ratio squared'

      end

      class Dsp
        STD_OPERATIONS = [
          Op::QRS_SYM,
          Op::APS_SYM,
          Op::CCR_SYM,
          Op::CPS_SYM,
          Op::AMP_SYM,
          Op::XAR_SYM,
          Op::IMR_SYM,
          Op::PSA_SYM,
          Op::COH_SYM
        ]

        STD_OPERATION_NAMES = [
          Op::QRS_NAME,
          Op::APS_NAME,
          Op::CCR_NAME,
          Op::CPS_NAME,
          Op::AMP_NAME,
          Op::XAR_NAME,
          Op::IMR_NAME,
          Op::PSA_NAME,
          Op::COH_NAME
        ]
        
        def create_std_ops( sig_a, sig_b )
          pair = "(#{sig_a},#{sig_b})"

          @operations << Op.new( sig_a, Op::SOURCE_SIG, Op::QRS_NAME,
                                 Op::QRS_SYM, Op::QRS_LABEL, Op::QRS_DOMAIN,
                                 Op::QRS_X_AXIS, Op::QRS_Y_AXIS )
          @operations << Op.new( sig_b, Op::SOURCE_SIG, Op::QRS_NAME,
                                 Op::QRS_SYM, Op::QRS_LABEL, Op::QRS_DOMAIN,
                                 Op::QRS_X_AXIS, Op::QRS_Y_AXIS )
          @operations << Op.new( sig_a, Op::SOURCE_SIG, Op::APS_NAME,
                                 Op::APS_SYM, Op::APS_LABEL, Op::APS_DOMAIN,
                                 Op::APS_X_AXIS, Op::APS_Y_AXIS )
          @operations << Op.new( sig_b, Op::SOURCE_SIG, Op::APS_NAME,
                                 Op::APS_SYM, Op::APS_LABEL, Op::APS_DOMAIN,
                                 Op::APS_X_AXIS, Op::APS_Y_AXIS )
          @operations << Op.new( sig_a, Op::SOURCE_SIG, Op::AMP_NAME,
                                 Op::AMP_SYM, Op::AMP_LABEL, Op::AMP_DOMAIN,
                                 Op::AMP_X_AXIS, Op::AMP_Y_AXIS )
          @operations << Op.new( sig_b, Op::SOURCE_SIG, Op::AMP_NAME,
                                 Op::AMP_SYM, Op::AMP_LABEL, Op::AMP_DOMAIN,
                                 Op::AMP_X_AXIS, Op::AMP_Y_AXIS )
          @operations << Op.new( pair, Op::SOURCE_PAIR, Op::CPS_NAME,
                                 Op::CPS_SYM, Op::CPS_LABEL, Op::CPS_DOMAIN,
                                 Op::CPS_X_AXIS, Op::CPS_Y_AXIS )
          @operations << Op.new( pair, Op::SOURCE_PAIR, Op::CCR_NAME,
                                 Op::CCR_SYM, Op::CCR_LABEL, Op::CCR_DOMAIN,
                                 Op::CCR_X_AXIS, Op::CCR_Y_AXIS )
          @operations << Op.new( pair, Op::SOURCE_PAIR, Op::IMR_NAME,
                                 Op::IMR_SYM, Op::IMR_LABEL, Op::IMR_DOMAIN,
                                 Op::IMR_X_AXIS, Op::IMR_Y_AXIS )
          @operations << Op.new( pair, Op::SOURCE_PAIR, Op::PSA_NAME,
                                 Op::PSA_SYM, Op::PSA_LABEL, Op::PSA_DOMAIN,
                                 Op::PSA_X_AXIS, Op::PSA_Y_AXIS )
          @operations << Op.new( pair, Op::SOURCE_PAIR, Op::XAR_NAME,
                                 Op::XAR_SYM, Op::XAR_LABEL, Op::XAR_DOMAIN,
                                 Op::XAR_X_AXIS, Op::XAR_Y_AXIS )
          @operations << Op.new( pair, Op::SOURCE_PAIR, Op::COH_NAME,
                                 Op::COH_SYM, Op::COH_LABEL, Op::COH_DOMAIN,
                                 Op::COH_X_AXIS, Op::COH_Y_AXIS )
        end
      end

    end
  end
end

