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

#実行部分
hash = crawler(doc)

#making test data
hash["2010-03-20"] = ["  test title20", "test url20"]
hash["2010-03-22"] = ["  test title22", "test url22"]
hash["2010-03-21"] = ["  test title21", "test url21"]


#checkHash(hash)

#arrayで入れる
#pp csvdiff(csvinput(csv),hash.to_a) 
csvoutput(csvinput(csv), csvdiff(csvinput(csv),hash.to_a))



