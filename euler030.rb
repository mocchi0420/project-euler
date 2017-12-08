# coding: utf-8
# Problem 30 「各桁の5乗」

# 簡単な方針
#
# 各項の5乗の和をSと置く
#
# このとき、Sの数値の範囲から考えてみる。
# 10^0 <= S <= 10^1-1 :1桁の数値の5乗で1桁の数値(ただし1を除く)を表す
# 10^1 <= S <= 10^2-1 :2桁の数値の各項の5乗の和で2桁の数値を表す
# 10^2 <= S <= 10^3-1 :3桁の数値の各項の5乗の和で3桁の数値を表す
# ---(中略)---
# 10^(n-1) から 10^n-1 :n桁の数値の各項の5乗の和でn桁の数値を表す
# 
# また、9^5=59049であることから、n桁の数値がすべて9で埋め尽くされていても、
# その場合の数値はたかだかn*9^5である。よって、あるnを超えた時に、n*9^5 < 10^(n-1)となり、
# 絶対にn桁の数値を表すことができなくなる。ここをループの終端として考えると、
#
# n*9^5 >= 10^(n-1) <=> n*9^5 - 10^(n-1) >= 0
#
# これはもう計算機を回したほうが早いのでこのnを基準にループを回す。(回したらn=6でした。)
#
# さて、ここからが本題。
#

require 'prime'

def euler030
	loop_num = 2	# 最大ループ回数
	fp_arr = (0..9).map{|d| d.to_i**5}
	ret = []

	2.upto(loop_num) do |data|
	
		10**(data-1).upto(10**data-1) do |idx|
			tmp = idx.to_s.split("").map{|d| fp_arr[d.to_i]}.inject(:+)
			next if Math.log10(tmp).floor == data
			p "data: #{data}, idx: #{idx}, tmp: #{tmp}, log: #{Math.log(tmp,10).floor}"
		end
	
=begin	
		index = 10**(data)
		tmp_list = (0..9).to_a.select{|d| index > d**5}
		tmp_list.combination(data).each do |d|
			ans = d.map{|e| e**5}.inject(:+)

			ret << ans if ans.to_s.split("").sort.map{|e| e.to_i} == d.sort 
			#ret << ans if ans.to_s.split("").sort.map{|e| e.to_i} == d.map{|e| e.to_s}.sort
		end
=end
	end

	return ret.inject(:+)
end
