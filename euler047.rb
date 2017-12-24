# coding: utf-8
# Problem 47 「異なる素因数」
# 
# 簡単な方針
# 
# ある数Nを最小の素因数Aとその片割れのBとに分け、メモライズした配列からBの配列を取得し、新たな配列を作る作業をやり続ける。
# 

require 'prime'
def euler047
	memo = [nil,[1]]
	ret = 0
	index = 2
	count = 0
	while ret == 0 do
		tmp = get_prime_num(index)

		if tmp.length == 1 then
			memo.push([index])
			count = 0 if count != 0
		else
			memo.push(tmp.map{|d| memo[d]}.flatten)
			count = (memo.last.uniq.length == 4) ? count+1 : 0
		end
		ret = memo[-4].inject(:*) if count == 4
		index += 1
	end
	return ret
end

def get_prime_num(num)
	return [2] if num == 2
	return [2,num/2] if num%2 == 0
	ret = [num]
	3.upto((num**0.5).to_i) do |idx|
		return [idx, num/idx] if num%idx == 0 
	end
	return ret
end
