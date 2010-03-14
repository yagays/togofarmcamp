# -*- coding: utf-8 -*-
require 'rubygems'
require 'hpricot'
require 'open-uri'
require 'kconv'
require 'csv'

def crawler(doc)
  #Hash initialization
  dateArray = Array.new
  dbHash = Hash.new{|dbHash,key|dbHash[key] = []}

  #date
  (doc/'h2 span.date').each_with_index {|elem,i| 
    dateArray << elem.inner_text.gsub(/\s+/, "")
  }

  #title
  (doc/'h3').each_with_index {|elem,i| 
    title = elem.inner_text.toutf8.strip
    if title[0,1] == "_"
      dbHash[dateArray[i-3]] << title.gsub(/\[.*?\]/, "").delete("_")
      dbHash[dateArray[i-3]] << "http://togotv.dbcls.jp/" + dateArray[i-3].delete("-") + ".html#p1"
    end
  }

  return dbHash
end

def checkHash(hash)
  hash.each{|key, value|
    puts "#{key}:#{value}"
  }
end

#上を書き換えたのでcsvに吐き出す方法を変更する必要がある
def csvoutput(list)
  output = list.to_a

CSV.generate("output.csv", ?,){|writer|
  writer << ["作成日","動画タイトル","URL"]
  output.each{|elem|
#     pp elem
#     pp elem[0]
#     pp elem[1][0]
#     pp elem[1][1]
    writer << [elem[0], elem[1][0], elem[1][1]]
  }
}
end

def csvinput(csv)
  tmp = Array.new
  CSV.parse(csv){|row|
   tmp << row.to_a
  }
  return tmp
end
