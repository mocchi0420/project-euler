# coding: utf-8
# Problem 6 「二乗和の差」

def euler006(target=100)
	arr = [*(1..100)]
	return arr.inject(:+)**2 - arr.map{|i| i**2}.inject(:+)
end
