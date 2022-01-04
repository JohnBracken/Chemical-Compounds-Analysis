#!/usr/bin/env ruby

#Script to pull chemical compound numeric JSON data (from PubChem NIH) and output to a csv file.
#Use OJ JSON parser
require 'oj'

#Run script from command line: $ ruby chemistry_data_json.rb input_file.json output_file.csv 
input_file = ARGV[0]
output_file = ARGV[1]

Oj.default_options = {mode: :strict}

File.open(output_file, 'w') { |csv|
    csv.puts "Compound_Name,Molecular_Weight,Polar_Surface_Area,Complexity,XlogP3AA,Heavy_Atom_Count,Hbond_Donor_Count,Hbond_Acceptor_Count,Rotatable_Bond_Count"

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

        #Write line of data to csv
        csv.puts %|"#{rec['cmpdname']}",#{rec['mw']},#{rec['polararea']},#{rec['complexity']},#{rec['xlogp']},#{rec['heavycnt']},#{rec['hbonddonor']},#{rec['hbondacc']},#{rec['rotbonds']}|
        }
    }
}

