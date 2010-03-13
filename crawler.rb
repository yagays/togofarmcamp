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


#date
(doc/'h2 span.date').each_with_index {|elem,i| 
 date =  elem.inner_text.gsub(/\s+/, "")
 db[i][0] = date
 db[i][2] = "http://togotv.dbcls.jp/" + date.delete("-") + ".html"
}


#title
(doc/'h3').each_with_index {|elem,i| 
 title = elem.inner_text.toutf8.strip#delete("\n").delete("\t")#.gsub(/\s+/, "")   #行頭のスペースが取れない
  if title[0,1] == "_"
   db[i-3][1] = title.gsub(/\[.*?\]/, "").delete("_")
  end
}
#puts db
#p db



CSV.generate("output.csv", ?,){|writer|
  db.each{|elem|
   writer << elem
  }
}
