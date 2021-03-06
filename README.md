# mcg-file
File formats used in MCG systems

## Signal Analysis

### signal_sample
One or more related, usually simultaneous, signals.
 * signal_sample - Core clases representing Signal (time domain) data
 * signal_json - Serialization to/from JSON
 * ecg_file - Serialization to/from a .ecg file

```ruby
	require 'mcg/signal_analysis/ecg_file'
	File.open('test.ecg') do |f|
		s = Mpa::SignalAnalysis::Sample::Sample.from_file(f)
		puts s.inspect
	end
```

### dsp
DSP operation output: the result of performing specific signal analysis 
functions (e.g. FFT) on a signal or combination of signals.
 * dsp - Core classes representing the DSP data domain
 * dsp_file - Serialization to/from a .dsp file
 * dsp_json - Serialization to/from JSON
 * dsp_ops - Standard MCG DSP operation names

```ruby
	require 'mcg/signal_analysis/dsp_file'
	File.open('test.dsp') do |f|
		d = Mpa::SignalAnalysis::Dsp::Dsp.from_file(f)
		puts d.inspect
	end

```

### sar
Signal Analysis Results: the features or "indexes" generated by performing
feature-detection analysis on the Signal and DSP data. 
 * sar - Core clases representing the SAR data domain
 * sar_file - Serialization to/from a .sar file
 * sar_json - Serialization to/from JSON
 * sar_indexes - Standard MCG index names

```ruby
	require 'mcg/signal_analysis/sar_file'
	File.open('test.sar') do |f|
		s = Mpa::SignalAnalysis::Sar::Sar.from_file(f)
		puts s.inspect
	end
```

## Diagnosis

### dcf
Disease Control Factors: patient metadata such as age, gender, BMI, history of 
smoking, etc. Note that this is kept separate from the signal analysis data so 
that it can be applied at point-of-care using local diagnosis software, 
eliminating the need to send patient identifying information to servers for 
analysis.
 * dcf - Core clases representing the DCF data domain
 * dcf_file - Serialization to/from a .dcf file
 * dcf_json - Serialization to/from JSON

```ruby
	require 'mcg/diagnosis/dcf_file'
	File.open('test.dcf') do |f|
		d = Mpa::Diagnosis::Dcf::List.from_file(f)
		puts d.inspect
	end
```

### dgo
Diagnosis Output: A collection of diseases or conditions, along with a 
positive or negative score indicating whether the analysis algorithm
detected signs of the disease or condition.
 * dgo - Core clases representing the Diagnosis data domain
 * dgo_file - Serialization to/from a .dgo file
 * dgo_json - Serialization to/from JSON
 * dgo_diagnoses - Standard MCG diagnosis names
```ruby
	require 'mcg/diagnosis/dgo_file'
	File.open('test.dgo') do |f|
		d = Mpa::Diagnosis::Dgo::Dgo.from_file(f)
		puts d.inspect
	end
```

## License
(c) Copyright 2017 Premier Heart, LLC
Released for public use under the Apache 2.0 License.
