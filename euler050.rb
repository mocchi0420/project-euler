# coding: utf-8
# Problem 50 「連続する素数の和」
# 
# 簡単な方針
# 
# まず素数を足し続けて100万をギリギリ超えない数値Xを作る。
# 次にXが素数じゃない場合には、2からスタートして素数を下から順番に引いていく。
# その内素数となるような数値Xになるのでそれを出力して終わり。

require 'prime'
def euler050
	num = 1000000
	ret = 2
	count = 3
	while ret < 1000000 do
		ret += count if Prime.prime?(count) == true
		count += 2
	end
	ret = ret - count + 2
	count = 2
	while Prime.prime?(ret) == false || ret > num do
		ret -= count if Prime.prime?(count) == true
		count = (count==2) ? count+1 : count+2
	end
	return ret
end