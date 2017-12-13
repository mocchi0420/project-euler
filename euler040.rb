# coding: utf-8
# Problem 40 「チャンパーノウン定数」 

# 簡単な方針
#
# Rubyさんといえども無理やり100万桁の数字を作って数値を取り出すのは正気の沙汰ではない。
# 欲しいのはn_1,n_10,n_100…と、10^n区切りなので、それを利用して地道に探すことにする。
#
# まず、1桁の数字は1～9までで、9桁分を表す。
# 次に、2桁の数字は10～99までで、90*2=180桁分を表す。
# 同様に、3桁の数字は100～999までで、900*3=2700……となり、
# 数値の予想として、n桁の数字は10^(n-1)*n*9として表されそうである。
# 
# そこで、この正の整数を順に連結して得られる無理数の小数点以下の部分をDとして、
# D上のn番目の数値がどの桁のどの数値かを照合しながら地道に計算を行う事にする。

def euler040
	target = [0,1,10,100,1000,10000,100000,1000000]
	index_num = [0]
	ret = []
	1.upto(6) do |a|
		index_num << 10**(a-1)*a*9
	end
	
	target.each do |data|
		next if data == 0
		index_sum = actual_sum = 0
		index_num.each_with_index do |tmp_d, tmp_i|
			next if tmp_i == 0
			if data - (tmp_d+index_sum) > 0
				index_sum += tmp_d
				actual_sum += tmp_d/tmp_i
				next
			end
			div_set = (data - index_sum).divmod(tmp_i)
			if div_set[1] == 0
				actual_sum += div_set[0]
				ret << actual_sum.to_s.split("").last
			else
				actual_sum += (1+div_set[0])
				ret << actual_sum.to_s.split("")[div_set[1]-1]
			end
			break
		end
	end
	return ret.map{|d| d.to_i}.inject(:*)
end