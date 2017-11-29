# coding: utf-8
# Problem 1 「3と5の倍数」
def euler001(count=1000)
	ret = 0
	1.upto(count-1){|num| ret += num if (num % 3 == 0 || num % 5 == 0)}
	return ret
end
