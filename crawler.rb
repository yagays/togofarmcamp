# -*- coding: utf-8 -*-
require 'rubygems'
require 'hpricot'
require 'open-uri'
require 'kconv'
require 'csv'


doc = Hpricot(open("/Users/yag_ays/togofarmcamp/togotv.html"))


#matrix
#e.g. [[date, title],[date, title]...]
def nmarray(n,m)
  (0...n).map{Array.new(m)}
end
db = nmarray(15,3)

dateArray = Array.new
dbHash = Hash.new


#date
(doc/'h2 span.date').each_with_index {|elem,i| 
 date =  elem.inner_text.gsub(/\s+/, "")

 #Hash用
 dateArray[i] = date
 #end

 db[i][0] = date
 db[i][2] = "http://togotv.dbcls.jp/" + date.delete("-") + ".html#p1"
}


#title
(doc/'h3').each_with_index {|elem,i| 
 title = elem.inner_text.toutf8.strip#delete("\n").delete("\t")#.gsub(/\s+/, "")   #行頭のスペースが取れない
  if title[0,1] == "_"
   db[i-3][1] = title.gsub(/\[.*?\]/, "").delete("_")

   #Hash用
   dbHash[dateArray[i-3]] = title.gsub(/\[.*?\]/, "").delete("_")
   #end
  end
}

puts dbHash
puts dbHash.length

#Hash確認用
dbHash.each{|key, value|
  puts "#{key}:#{value}"
}


#puts db
#p db


#CSV output
# CSV.generate("output.csv", ?,){|writer|
#   db.each{|elem|
#    writer << elem
#   }
# }
