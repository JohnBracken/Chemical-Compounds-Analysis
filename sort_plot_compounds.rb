#!/usr/bin/env ruby

#Plot top 5 heaviest chemical compounds from NIH list.
#Use Jupyter notebooks to display plots:  $ iruby notebook

require 'csv'
require 'sciruby'

input_file = ARGV[0]

compounds_reduced = []
CSV.foreach(input_file, headers: true, header_converters: :symbol) { |row|
    row[:molecular_weight] = row[:molecular_weight].to_f
    row[:polar_surface_area] = row[:polar_surface_area].to_f
    row[:complexity] = row[:complexity].to_f
    row[:xlogp3aa] = row[:xlogp3aa].to_f
    row[:heavy_atom_count] = row[:heavy_atom_count].to_i
    row[:hbond_donor_count] = row[:hbond_donor_count].to_i
    row[:hbond_acceptor_count] = row[:hbond_acceptor_count].to_i
    row[:rotatable_bond_count] = row[:rotatable_bond_count].to_i    
    compounds_reduced << row.to_hash
}

#Sort compounds by weight descending, take top 5.
compounds_reduced.sort_by!{ |hsh| hsh[:molecular_weight] }.reverse!

compounds_plot = compounds_reduced[0..4]
compound_names = []
compound_weights = []

compounds_plot.each{|rec|
    compound_names << rec[:compound_name]
    compound_weights << rec[:molecular_weight]
}  

#Shorten names
compound_names[2] = "Neurotoxin I"
compound_names[3] = "Neurotoxin III"

#Bar plot of compounds molecular weight
plot = Nyaplot::Plot.new
bp = plot.add(:bar, compound_names, compound_weights)
plot.x_label("Chemical Compound")
plot.y_label("Molecular Weight(g/mol)")
plot.width(900)
plot.show

