# coding: utf-8
# Problem 33 「桁消去分数」

# 簡単な方針
#
# たかだか10~99までの90個*90個の値を走査すればいいだけの課題なので、該当しないパターンを排除しつつ計算を行うだけでそこそこの計算時間で済む。
# 今回は、
#　　・分母と分子が同じ場合打ち切り
#　　・分母と分子が共に10の倍数の時に打ち切り
#	  ・分母と分子に共通の数値がない場合打ち切り
#	  ・分母と分子の最大公約数が1の場合打ち切り
# あたりでどんどん計算を打ち切っていく。



def euler033
	denominator_set = (10..99).to_a.select{|d| d%10 != 0}.map{|d| d.to_s.split("")} #分母
	numerator_set = (10..99).to_a.select{|d| d%10 != 0}.map{|d| d.to_s.split("")} #分子

	deno_ret = []
	nume_ret = []

	0.upto(denominator_set.length-1) do |d_i|
		0.upto(d_i) do |n_i|
		
			next if d_i == n_i || denominator_set[d_i] & numerator_set[n_i] == ["0"] #分母と分子が同じか共に10の倍数の時には計算打ち切り
			
			common = denominator_set[d_i] & numerator_set[n_i]
			next if common == [] #共通項がない場合には打ち切り
			
			tmp_deno_1 = denominator_set[d_i].inject(:+).to_i
			tmp_nume_1 = numerator_set[n_i].inject(:+).to_i
			next if tmp_deno_1.gcd(tmp_nume_1) == 1	#最大公約数が1の場合にも打ち切り

			rat_1 = Rational(tmp_nume_1, tmp_deno_1) #　

			tmp_deno_2 = (denominator_set[d_i]-common != []) ? (denominator_set[d_i]-common) : common
			tmp_nume_2 = (numerator_set[n_i]-common != []) ? (numerator_set[n_i]-common) : common
			
			rat_2 = Rational(tmp_nume_2.inject(:+).to_i, tmp_deno_2.inject(:+).to_i)

			if rat_1 == rat_2
				deno_ret << tmp_deno_1
				nume_ret << tmp_nume_1
			end
		end
	end

	return Rational(nume_ret.inject(:*),deno_ret.inject(:*)).denominator
end
