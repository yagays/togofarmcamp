# -*- coding: utf-8 -*-
require 'rubygems'
require 'hpricot'
require 'open-uri'
require 'kconv'
require 'csv'
require 'crawler'
require 'pp'

doc = Hpricot(open("/Users/yag_ays/togofarmcamp/togotv.html"))
csv = "/Users/yag_ays/togofarmcamp/togotv_shows.csv"


hash = crawler(doc)

#making test data
hash["2010-03-20"] = ["  test title", "test url"]
hash["2010-03-22"] = ["  test title", "test url"]
hash["2010-03-21"] = ["  test title", "test url"]
hash["2010-03-28"] = ["  test title", "test url"]
hash["2010-03-27"] = ["  test title", "test url"]
hash["2010-03-23"] = ["  test title", "test url"]
hash["2010-04-12"] = ["  test title", "test url"]
hash["2010-05-15"] = ["  test title", "test url"]
#end


add = csvdiff(csvinput(csv),hash.to_a)

if add != []
 csvoutput(csvinput(csv), add)
 puts "output.csv is updated."
 checkHash(hash)
 pp add
else
 puts "no change in togotv."
 checkHash(hash)
 pp add
end


