# coding: utf-8
# Problem 46 「もうひとつのゴールドバッハの予想」
# 
# 簡単な方針
# 
# 最小の奇数の合成数であるn=9からスタートして、以下のアルゴリズムを試す
# (1)nが素数であるか偶数である場合、
# ある数n以下の奇数の合成数の集合をAとする。
# ある数n以下の素数の集合とn以下の数値によって作った、n以下のj+2*k**2の集合Bを作成する。
# このとき、A|Bの長さがn-1にならないとき、この予想とは異なる数値が出た事を意味するはずである。それを抜き出す。

require 'prime'
def euler046
	num = 8
	ret = 0
	
	while ret == 0 do
		num += 1
		next if Prime.prime?(num) == true || num % 2 == 0
		tmp = false
		1.upto(Math.sqrt(num).floor) do |idx|
			if Prime.prime?(num - 2*idx**2) == true
				tmp = true
				break
			end
		end
		ret = num if tmp != true
	end
	return ret
end