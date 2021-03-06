# coding: utf-8
# Problem 29 「個別のべき乗」

# 簡単な方針
# 素因数分解的に考えて、基本的に素数の累乗が一致することはありえない。
# すなわち、問題となるのは素数以外の数値において、a^b = c^dがありえるかどうかである。
# このとき、計算の過程でa^bは既知の数として扱えるので、c^dという未知のパラメータをa^bから推定する
# 両辺の対数を底aで取って、b*log_a_a = d*log_a_cとすると、b=d*log_a_c <=> d = b/log_a_c
# よって、パラメータを1つ減らすことができ、b/log_a_cが整数となり、2から100の間に含まれる場合に答えが被る事が分かる。
# 
# また、対数の法則から、aとcが互いに素であれば絶対に問題を起こさない。(つまり1以外の公約数が存在しない)
# この場合はaが素数でない場合に、2から100の数値とのgcdを評価し、1以外になるものを列挙する。
# 
# たとえば、36^6と6^12は一致するがこれは36^6 = (6^2)^6 = 6^(2*6) = 6^12となるからである。
# つまり、この場合には素因数分解による別の値を取りうるかどうかのチェックが必要になる。
#
# ……けど、Rubyだとそんなことしなくても多分計算量増えないので、あとは適当


require 'prime'

def euler029(n=[100,100])
	ret1 = []
	ret2 = []

	2.upto(n[0]) do |a|
		if Prime.prime?(a)
			ret1 << (2..n[1]).to_a.map{|b| a**b}	#素数の塁乗に被りはないのでぶち込む
		else
			ret2 = ret2 | (2..n[1]).to_a.map{|b| a**b} #素数以外の塁乗に被りはありえるので差を取る
		end
	end
	ret = (ret1.flatten | ret2).flatten
	return ret.length
end