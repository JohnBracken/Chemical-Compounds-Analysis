#!/usr/bin/env ruby

#Script to pull chemical compound numeric JSON data (from PubChem NIH) and output some of it to a simplified JSON file.
#Use Oj JSON parser
require 'oj'

#Run script from command line: $ ruby chemistry_data_json.rb input_file.json output_file.json 
input_file = ARGV[0]
output_file = ARGV[1]

Oj.default_options = {mode: :strict}

records = []
Oj.load_file(input_file) { |recs|

    recs.each {|rec|

    #Convert data types for numeric keys
    rec['mw'] = rec['mw'].to_f
    rec['polararea'] = rec['polararea'].to_f
    rec['complexity'] = rec['complexity'].to_f
    rec['xlogp'] = rec['xlogp'].to_f
    rec['heavycnt'] = rec['heavycnt'].to_i
    rec['hbonddonor'] = rec['hbonddonor'].to_i
    rec['hbondacc'] = rec['hbondacc'].to_i
    rec['rotbonds'] = rec['rotbonds'].to_i
    
    rec = rec.slice('cmpdname', 'mw', 'polararea','complexity','xlogp', 'heavycnt', 'hbonddonor', 'hbondacc', 'rotbonds')
    records << rec
        }
    }

Oj.to_file(output_file, records, options = {:indent => 4})
