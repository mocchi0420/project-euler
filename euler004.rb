# coding: utf-8
# Problem 4 「最大の回文積」

require 'prime'

def euler004
	threshold = 997799 #999*999=998001以下の最大の回文数
	threshold.downto(900000) do |num|
		next if num.to_s != num.to_s.reverse
		next if num.prime? == true || Prime.prime_division(num).flatten.count {|item| item > 999} > 0
		999.downto(100){|item| return num if (num % item == 0) && (num / item <= 999) }
	end
	return threshold
end