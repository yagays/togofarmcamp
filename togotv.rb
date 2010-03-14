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


list = crawler(doc)
#checkHash(list)
#csvoutput(list)

#pp list.to_a
#pp csvinput(csv)

#test data
list["2010-03-20"] = ["test title", "test url"]
list["2010-03-22"] = ["test title2", "test url2"]
#pp list.to_a

#arrayで入れる
p csvdiff(csvinput(csv),list.to_a)
