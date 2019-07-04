# coding: utf-8
# Problem 4 「最大の回文積」

require 'prime'

def euler004
	threshold_upper=999
	threshold_upper.downto(100) do |num|
		hoge = (num.to_s + num.to_s.reverse).to_i
		next if hoge.prime? == true || Prime.prime_division(hoge).flatten.count {|item| item > 999} > 0
		999.downto(100){|item| return hoge if (hoge % item == 0) && (hoge / item <= 999) }
	end
end