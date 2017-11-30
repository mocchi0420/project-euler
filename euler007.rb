# coding: utf-8
# Problem 7 「10001番目の素数」

require 'prime'

def euler007
	return Prime.each.take(10001).last
end
