# coding: utf-8
# Problem 43 「部分文字列被整除性」

# 簡単な方針
# 
# こういうのは以下に計算量を減らすかにかかっているので、
# 今回は最も強い制約としてd_8,d_9,d_10が17の倍数に着目する。
# 17の倍数が3桁となるのは、(100を17で割った数の整数部+1)～(1000を17で割った数の整数部)の個数、つまり6~58なのでたかだが53個。
# しかも、この53個の中に同じ数字が2回使われていないものを抜き出すと、さらに数は減る。(※パンデジタル数なので同じ数字は2度出ない)
#
# ここから頭に数値を足していって、徐々に数値を絞り込んでいく(絞り込めず発散する可能性もあるが、まぁ多分収束するでしょ。)
# 頭に数値を足す流れは以下の通り。
# (1)頭に数値を足す処理をしたい数値Aを取得
# (2)n桁であるAをn個の数値のテーブルに変換し、[0..9]のテーブルとの差(diff_table)を取る。
# (3)diff_tableの各数値を頭文字としてAと組み合わせ、数値Bを作り、各桁の制約(d_7,d_8,d_9なら13の倍数)にあうものを抜き出して新たなAの集合とする

require 'prime'
def euler043
	index_table = [1,2,3,5,7,11,13,17].reverse
	num_table = (0..9).to_a
	ret = []
	
	index_table.each_with_index do |data, idx|
		if data == 17
			ret = ((100.0/data).ceil..(1000.0/data).floor).to_a.map{|d| (d*data).to_s}.select{|e| e.split("").uniq.length == 3} 
			next
		end

		tmp_ret = []
		ret.each do |ans|
			diff_table = num_table - ans.split("").map{|d| d.to_i}
			tmp_ret = tmp_ret | diff_table.map{|d| (d.to_s + ans)}.select{|e| e[0,3].to_i%data == 0}
		end
		if data > 1
			ret = tmp_ret
		else
			ret = tmp_ret.select{|e| e[0] != 0}.map{|d| d.to_i}
		end
	end
	return ret.inject(:+)
end
