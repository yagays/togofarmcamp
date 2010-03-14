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
checkHash(hash)
#csvoutput(hash)

#pp hash.to_a
#pp csvinput(csv)

#test data
hash["2010-03-20"] = ["test title", "test url"]
hash["2010-03-22"] = ["test title2", "test url2"]
#pp hash.to_a

#arrayで入れる
p csvdiff(csvinput(csv),hash.to_a)
