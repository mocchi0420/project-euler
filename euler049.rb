# coding: utf-8
# Problem 49 「素数数列」
# 
# 簡単な方針
# 
# 0~9から4つの数値を取り出し、それぞれの数値のセットに対して4桁の数値の全組み合わせを作成する。(このような4桁の数値の組み合わせをSとでも置く。)
# 次に、Sからある数値Xを取り出し、Sの全ての数値とXの差の絶対値を取る。この時この絶対値の中に重複する値hogeがあれば、X-hoge,X,X+hogeの数列が求める数列となるはずである。
# あとは、以下の全条件を満たすようなX-hoge,X,X+hogeの組み合わせを取り出せばよい
# (1)X-hoge>=1000,X+hoge<=9999を満たす
# (2)X-hoge,X,X+hogeのすべてが素数である
# (3)X-hoge,X,X+hogeそれぞれを構成する数字が全て同じ

require 'prime'
def euler049
	num_set = (0..9).to_a.repeated_combination(4).to_a.map{|d| check_prime_progression(d)}.select{|e| e != nil}
	return num_set.uniq.select{|e| e != 148748178147}.last
end

def check_prime_progression(arr)
	ret = nil
	num_set = arr.permutation(4).map{|d| d.map{|e| e.to_s}.inject(:+).to_i}.select{|e| e>=1000}.uniq
	num_set.each do |item|
		next if Prime.prime?(item) != true
		diff = num_set.map{|d| (d-item).abs}.group_by{|i| i}.reject{|k,v| v.one?}.keys.select{|e| item+e<10000 && item-e>999}
		next if diff == []
		diff.each do |a|
			next if Prime.prime?(item-a)!=true || Prime.prime?(item+a)!=true
			next if item.to_s.split("").sort != (item-a).to_s.split("").sort || item.to_s.split("").sort != (item+a).to_s.split("").sort
			ret = ((item-a).to_s + item.to_s + (item+a).to_s).to_i
		end
	end
	return ret
end