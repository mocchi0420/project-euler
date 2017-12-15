# coding: utf-8
# Problem 46 「もうひとつのゴールドバッハの予想」
# 
# 簡単な方針
# 
# 最小の奇数の合成数であるn=9からスタートして、以下のアルゴリズムを試す
# (1)nが素数であるか偶数である場合、処理をすっ飛ばして次に行く
# (2)nが奇数の合成数である場合、1<=k<=√((n-3)/2)までを対象としてn - 2*k**2が素数かどうかをジャッジする。
# (3)kの値域にn - 2*k**2を素数にする数値が1つでも存在していたらbreakして次の数をさがす。
# (4)もしもkの値域にn - 2*k**2を素数にする数値が1つもなかったら、それが今回探すべきnなのでそれを出力する。

require 'prime'
def euler046
	num = 8
	ret = 0
	
	while ret == 0 do
		num += 1
		next if Prime.prime?(num) == true || num % 2 == 0
		tmp = false
		1.upto(Math.sqrt((num-3)/2).floor) do |idx|
			if Prime.prime?(num - 2*idx**2) == true
				tmp = true
				break
			end
		end
		ret = num if tmp != true
	end
	return ret
end