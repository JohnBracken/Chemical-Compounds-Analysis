#!/usr/bin/env ruby

#Script to pull chemical compound numeric data from original csv file.
#Write reduced dataset to another csv.

#Chemical compounds dataset from
#https://pubchem.ncbi.nlm.nih.gov

#Run script from command line:  $ ruby chemistry_data.rb compounds.csv compounds_reduced.csv
require 'csv'

input_file = ARGV[0]
output_file = ARGV[1]

CSV.open(output_file, "w") { |csv|
    csv << ["Compound_Name", "Molecular_Weight", "Polar_Surface_Area", "Complexity", "XLogP3-AA", 
            "Heavy_Atom_Count", "HBond_Donor_Count", "HBond_Acceptor_Count", "Rotatable_Bond_Count"]
    CSV.foreach(input_file, headers: true, header_converters: :symbol ) { |row| 
        row = row.to_hash
        row[:mw] = row[:mw].to_f
        row[:polararea] = row[:polararea].to_f
        row[:complexity] = row[:complexity].to_f
        row[:xlogp] = row[:xlogp].to_f
        row[:heavycnt] = row[:heavycnt].to_i
        row[:hbonddonor] = row[:hbonddonor].to_i
        row[:hbondacc] = row[:hbondacc].to_i
        row[:rotbonds] = row[:rotbonds].to_i
        row = row.slice(:cmpdname, :mw, :polararea,:complexity,:xlogp, :heavycnt, :hbonddonor, :hbondacc, :rotbonds)
        csv << row.values
    }
}

