# coding: utf-8
# Problem 37 「切り詰め可能素数」

# 簡単な方針
#
# 正直言って切り詰め可能素数の数が11個にしかならないということの証明の仕方がわからないので、
# [2,3,5,7]の4つの素数を種に、左から切り詰めた場合の素数と右から切り詰めた場合の素数を考えることにする。
# 
# ここで、あるn桁の素数S(n)=n(1),n(2),...,n(n-1),n(n)とすると、
# S(n)は素数かつ0,1,9は素数ではないことと、末尾の数字n(n)は左から切り詰めた場合に素数にならざるをえないことから、n(n){3,7} (※末尾が偶数だとS(n)は偶数に、5だとS(n)は5の倍数となってしまうため)
# S(n)は素数であり、1<k<nとなるn(k)は左から切り詰めた場合に素数にならざるをえないことから、n(n){1,3,7,9} (※末尾が偶数だとS(n)は偶数に、5だとS(n)は5の倍数となってしまうため)
# S(n)は素数かつ0,1,9は素数ではないことと、先頭の数字n(1)は右から切り詰めた場合に素数にならざるをえないことから、n(1){2,3,5,7} (※先頭が2か5でも別に問題ない)
# 
# S(1)=[2,3,5,7]が与えられていることから、 
# n>2に対して、11個の切り詰め可能素数が見つかるまで以下を試す。
#
# (1)n1配列をS[2,3,5,7]、nk配列を[1,3,7,9]、nn配列を[3,7]とする。吟味する数値の桁数は最初2桁からなのでindex=2とでも置いておく
# (2)index==2のとき、n1配列とnn配列を左側・右側の2方向から組み合わせて2桁の数値を作成する。その中から素数となるもの抜き出して、最終結果を格納する変数に加算する。
# (3)indexに1を加算して更新し、n1配列,nk配列*(index-2),nn配列を組み合わせて3桁の数値を作成するその中から素数となるもの抜き出して、最終結果を格納する変数に加算する。
# (4)上記(3)を最終結果が11個になるまで繰り返す。
#

require 'prime'
def euler037
	set_n1 = [2,3,5,7]
	set_nk = [1,3,7,9]
	set_nn = [3,7]
	ret = []
	index = 2
	
	while ret.length < 11 do
		# 最初のみ初期値を代入
		if index == 2
			memo_1 =  set_n1 #右側を増やす系
			memo_2 =  set_nn #左側を増やす系
		elsif index > 2
			memo_1 = memo_1.product(set_nk).map{|d| d[0]*10+d[1]}.select{|e| Prime.prime?(e)}
			memo_2 = memo_2.product(set_nk).map{|d| d[1]*10**(Math.log10(d[0]).floor+1)+d[0]}.select{|e| Prime.prime?(e)}	
		end
		tmp_1 = memo_1.product(set_nn).map{|d| d[0]*10+d[1]}.select{|e| Prime.prime?(e)}	#右側を増やす系
		tmp_2 = memo_2.product(set_n1).map{|d| d[1]*10**(Math.log10(d[0]).floor+1)+d[0]}.select{|e| Prime.prime?(e)}	#左側を増やす系
		
		ret = ret | (tmp_1 & tmp_2)
		index += 1
	end
	return ret.inject(:+)
end

=begin
def euler037
	set_n1 = [2,3,5,7]
	set_nk = [1,3,7,9]
	set_nn = [3,7]
	ret = []
	index = 2
	
	while ret.length < 11 do
		#右側を増やす系
		tmp_1 =  set_n1
		(index-2).times do
			tmp_1 = tmp_1.product(set_nk).map{|d| d[0]*10+d[1]}.select{|e| Prime.prime?(e)}
		end if index > 2
		tmp_1 = tmp_1.product(set_nn).map{|d| d[0]*10+d[1]}.select{|e| Prime.prime?(e)}
		
		#左側を増やす系
		tmp_2 =  set_nn
		(index-2).times do
			tmp_2 = tmp_2.product(set_nk).map{|d| d[1]*10**(Math.log10(d[0]).floor+1)+d[0]}.select{|e| Prime.prime?(e)}	
		end if index > 2
		tmp_2 = tmp_2.product(set_n1).map{|d| d[1]*10**(Math.log10(d[0]).floor+1)+d[0]}.select{|e| Prime.prime?(e)}
				
		ret = ret | (tmp_1 & tmp_2)
		index += 1
	end
	return ret.inject(:+)
ends
=end