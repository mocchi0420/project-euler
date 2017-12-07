# coding: utf-8
# Problem 30 「各桁の5乗」

# 簡単な方針
# 9^5=59049なので、
# 10 < 2*9^5
# 100 < 3*9^5
# 1000 < 4*9^5
# 10000 < 5*9^5
# 100000 < 6*9^5
# 1000000 > 7*9^5 (=413343)
# よって、合計の数値はどんなに大きくても1000000を越える事は無い。
#
# また、1^5=5を計算に含まない事から、一桁の数値で各桁の5乗の和が一致するような数を作ることは不可能。
#
# よって、1<=n<=6の間で以下の事を繰り返す。
# (1)10^nを閾値として設定する。
# (2)10~10^nまでの数について、以下のように考える
# 　まず、index=10(最小値)をとり、この数値の各桁の5乗和を計算する。
#	 もしこの数が題意を満たさない場合にはindexに1を追加して再度各桁の5乗和を計算する。
#	 この流れを繰り返していくと、index=12で、1^5+2^5=33>10を越えてしまう。
#	 こうなってしまったら、indexの値に10を追加し、1桁目の数値を0に戻す。
#	 index = 20のとき、各桁の5乗和は2^5+0^5=32>10なので、これも満たさない。
#	 こうなったらもうn=1での検索は無理なのでn+=1を実施する。
# こんな感じでn=7が終了するまで繰り返して、該当した数値の和を算出して示せばOK

require 'prime'

def euler030
	loop_num = 6	# 最大ループ回数

	ret = []

	2.upto(loop_num) do |data|
		index = 10**(data)
		tmp_list = (0..9).to_a.select{|d| index > d**5}
		tmp_list.combination(data).each do |d|
			ans = d.map{|e| e**5}.inject(:+)

			ret << ans if ans.to_s.split("").sort.map{|e| e.to_i} == d.sort 
			#ret << ans if ans.to_s.split("").sort.map{|e| e.to_i} == d.map{|e| e.to_s}.sort
		end
	end
	p ret
	return ret.inject(:+)
end