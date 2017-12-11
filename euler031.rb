# coding: utf-8
# Problem 31 「硬貨の和」

# 簡単な方針
#
# あとでまとめる

def euler031
	pence = [1,2,5,10,20,50,100,200]
	memo = Array.new(201, 0)
	memo[0] = 1
	
	pence.each do |data|
		0.upto(200) do |idx|
			next if memo[idx] == 0
			tmp_idx = idx + data
			break if 200 <tmp_idx
			memo[tmp_idx] += memo[idx] 
		end
	end
	
	return memo[200]
end