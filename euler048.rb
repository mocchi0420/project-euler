# coding: utf-8
# Problem 48 「自身のべき乗(self powers)」
# 
# 簡単な方針
# 
# Rubyさんの機能を駆使して単純計算
# 

require 'prime'
def euler048
	return (1..1000).map{|d| d**d}.inject(:+).to_s[-10,10].to_i
end