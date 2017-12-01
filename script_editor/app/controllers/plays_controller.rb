require 'nokogiri'
require_relative 'create_scripts'

class PlaysController < ApplicationController
  
  # POST /plays
  def save
    # Save edited script to HTML file
    @data = params[:savedocument]
    @doctitle = params[:savetitle]
    @string = "edited_" + @doctitle + ".html"
    File.open(@string, "w") {|f| f.write(@data)}

  end

  def show

    # A dictionary that pairs all play names with their Folger's acronyms
    plays = {"a_midsummer_nights_dream"=>"MND", 'alls_well_that_ends_well'=>"AWW", 'antony_and_cleopatra'=>"Ant", 'as_you_like_it'=>"AYL", 'coriolanus'=>"Cor", 'cymbeline'=>"Cym", 
        'hamlet'=>"Ham", 'henry_iv_part_1'=>"1H4", 'henry_iv_part_2'=>"2H4", 'henry_v'=>"H5", 'henry_vi_part_1'=>"1H6", 'henry_vi_part_2'=>"2H6",
        'henry_vi_part_3'=>"3H6", 'henry_viii'=>"H8", 'julius_caesar'=>"JC",  'king_john'=>"Jn", 'king_lear'=>"Lr", 'loves_labors_lost'=>"LLL",
        'macbeth'=>"Mac", 'measure_for_measure'=>"MM", 'much_ado_about_nothing'=>"Ado", 'othello'=>"Oth", 'pericles'=>"Per", 'richard_ii'=>"R2", 'richard_iii'=>"R3", 
        'romeo_and_juliet'=>"Rom", 'taming_of_the_shrew'=>"Shr", 'the_comedy_of_errors'=>"Err", 'the_merchant_of_venice'=>"MV", 'the_merry_wives_of_windsor'=>"Wiv",
        'the_tempest'=>"Tmp", 'the_two_gentlemen_of_verona'=>"TGV", 'the_two_noble_kinsmen'=>"TNK", 'the_winters_tale'=>"WT",
        'timon_of_athens'=>"Tim", 'titus_andronicus'=>"Tit", 'troilus_and_cressida'=>"Tro", 'twelfth_night'=>"TN", 'venus_and_adonis'=>"Ven" }
    
    @doctitle = params[:play]   
    @string = "edited_" + @doctitle + ".html"
    @acronym = plays[@doctitle]

    # If a file exists, load it
    if File.exists?(@string)
      @provideddocument = File.open(@string, "r")
      @provideddocument = File.read(@string)
      
    # If none exists, create a new one by parsing the XML
    else 
      @provideddocument = createScript(@acronym, false) 
      File.open(@string, "w") {|f| f.write(@provideddocument)}
    end
  end
end
