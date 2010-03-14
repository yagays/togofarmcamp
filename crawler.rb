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

def csvinput(csv)
  tmp = Array.new
  CSV.open(csv,"r"){|row|
   tmp << row.to_a
  }
  return tmp
end

def csvdiff(old,new)
  #oldのidのarrayを作る
  oldid = Array.new
  old.each_with_index{|elem,i|
   if i != 0
    oldid << elem[0].to_i
   end
  }

  #diff判定
  insert = Array.new
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
  }
  #
  add = Array.new
  sortinsert = insert.sort{|a,b| a[0].delete("-").to_i <=> b[0].delete("-").to_i}
  sortinsert.each_with_index{|elem,i|
    add << [(oldid.max+i+1).to_s, elem[0],elem[1][0],elem[1][1]]
  }
  return add
end



def csvoutput(base, new)
  new.each{|elem|
   base << elem
  }

  CSV.open("output.csv", "w") {|writer|
    writer << ["ID","作成日","動画タイトル","URL"]
    base.each{|elem|
      writer << elem
    }
  }
end
