# -*- coding: utf-8 -*-
require 'rubygems'
require 'hpricot'
require 'open-uri'
require 'kconv'
require 'csv'

def crawler(doc)
  #Hash initialization
  dateArray = Array.new
  dbHash = Hash.new

  #date
  (doc/'h2 span.date').each_with_index {|elem,i| 
    date =  elem.inner_text.gsub(/\s+/, "")
    dateArray[i] = date
  }

  #title
  (doc/'h3').each_with_index {|elem,i| 
    title = elem.inner_text.toutf8.strip#delete("\n").delete("\t")#.gsub(/\s+/, "")   #行頭のスペースが取れない
    if title[0,1] == "_"
      dbHash[dateArray[i-3]] = title.gsub(/\[.*?\]/, "").delete("_")
    end
  }

  return dbHash
end

def checkHash(hash)
  hash.each{|key, value|
    puts "#{key}:#{value}"
  }
end

def csvoutput(list)
  output = list.to_a
  puts output
  CSV.generate("output.csv", ?,){|writer|
    output.each{|elem|
      writer << elem
    }
  }
end
