# coding: utf-8
# Problem 21 「友愛数」

# 簡単な方針
# 友愛数の組にはa!=bの条件から、絶対にa<bとなるような数値が存在している。
# また、友愛数の性質上、約数の和が自身の数値より大きくなるような数値が対象となる。
# このことから、自身より大きな約数の和を持っている数値を見つけたら、その相手の数値を調べる。
# もしこの結果、友愛数となる組が見つかったら、そのまま結果に格納する。

def euler021(index=10000)
	arr = Array.new(index,0)
	ret = []
	2.upto(index-1) do |hoge|
		arr[hoge] = get_divisor_list(hoge).select{|d| d != hoge}.inject(:+)
		if hoge < arr[hoge] && arr[hoge] <10000
			fuga = get_divisor_list(arr[hoge]).select{|d| d != arr[hoge]}.inject(:+)
			ret << [hoge, arr[hoge]] if hoge == fuga
		end
		
	end
	return ret.flatten.inject(:+)
	
end

def get_divisor_list(num)
	return [1] if num == 1
	(1..Math.sqrt(num).to_i).select do |i|
		num%i == 0
	end.map {|e| [e, num/e]}.flatten.uniq.sort
end
