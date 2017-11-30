# coding: utf-8
# Problem 5 「最小の倍数」

require 'prime'

def euler005(target=20)
	ret = Prime.each(target).to_a.inject(:*)
	target.downto(4) { |item| ret *= item/ret.gcd(item) if ret % item != 0}
	return ret
end
