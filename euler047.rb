# coding: utf-8
# Problem 47 「異なる素因数」
# 
# 簡単な方針
# 
# それぞれ2つの異なる素因数を持つ連続する2つの数が最初に現れるのは、「2,3,5,7」の内から2つの数値が取られているものが必ず1つ存在している。
# それぞれ3つの異なる素因数を持つ連続する3つの数が最初に現れるのは、「2,3,5,7,11,13,17,19,23,29」の内から3つの数値が取られているものが必ず1つ存在している。
# という事から察するに、
# それぞれ4つの異なる素因数を持つ連続する4つの数が最初に現れるのは、「2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,49,51」の内から4つの数値が取られているものが必ず1つ存在しているのではないか？と推測できる。
# 
# 
# (1)nが偶数の時、
# nとn+1,n+3が、n/2と(n+2)/2が互いに素であるような数値の組を探す。
# 
# (2)nが偶数の時、
# nとn+1,n+2,n+3が、互いに素であるであるような数値の組を探す。
# 
# ……と思ったら、nとn+1は絶対に互いに素となるので、それ以外の数値での組み合わせを考慮する。
# 

require 'prime'
def euler047
	#num_set = Prime.each.take(16).combination(4).to_a
	num_set = Prime.each.take(16)
	num_max = num_set.max**0.5
	num_set.each do |data|
		tmp = data**2
		while tmp < num_set.max do
			num_set << tmp if tmp < num_max
			tmp *= data
		end
	end
	
	num_set = num_set.combination(4).to_a
	ret = []
	while ret == [] do
		num_set.each do |data|
			tmp = data.inject(:*)
			if [tmp-3,tmp-2,tmp-1,tmp,tmp+1,tmp+2,tmp+3].map{|d| Prime.prime_division(d).length}.to_s.delete(" ").include?("4,4,4,4")
				tmp_idx = [tmp-3,tmp-2,tmp-1,tmp,tmp+1,tmp+2,tmp+3].map{|d| Prime.prime_division(d).length}.index(4)-3
				ret << tmp + tmp_idx
			end
		end	
	end
	return ret.min
end


=begin
require 'prime'
def euler047

	num = 2*3*5*7
	ret = 0
	
	while ret == 0 do
		num+=1
		next if Prime.prime?(num) == true
		
		p Prime.each.take(9).to_a
		
		hoge = [num, num+1, num+2, num+3].map{|d| Prime.prime_division(d).length}
		if hoge.inject(:+)/hoge.length != 4 && hoge.min != 4
			
		(num*(num+1)*(num+2)*(num+3))
			num += (hoge.rindex{|item| item < 4})
			next
		end
		p [num, num+1, num+2, num+3].map{|d| Prime.prime_division(d).map{|e| e[0]**e[1]}}
		ret = num if [num, num+1, num+2, num+3].map{|d| Prime.prime_division(d).map{|e| e[0]**e[1]}}.flatten.uniq.length == 16
	end
	return ret
end
p euler047
=end