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


pp csvinput(csv)
