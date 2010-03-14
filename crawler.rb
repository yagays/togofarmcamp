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
  CSV.open(csv,"r"){|row|
   tmp << row.to_a
  }
  return tmp
end

def csvdiff(old,new)
  #oldのidのmaxを求める
  oldid = Array.new
  old.each_with_index{|elem,i|
   if i != 0
#    xx  ? yy : zz
    oldid << elem[0].to_i
   end
  }
# p oldid.max

#  pp new[0]
#  pp new[0][0]
#  pp old[1]
#  pp old[1][1]

  insert = Array.new
  #diff判定

  new.each{|newelem|
     status = 1
     old.each{|oldelem|
      if newelem[0].delete("-").to_i <= oldelem[1].delete("-").to_i
       status = 0
      end
     }
  if status == 1
   insert <<  newelem
  end
  pp status
  }
  return insert
end
