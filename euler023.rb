# coding: utf-8
# Problem 23 「非過剰数和」

# 簡単な方針
# 28123という閾値が与えられているので、今回はそれを満たす過剰数のリストを作成する。
# また、検索の際にそのリスト内にある数値があるかどうかを探すのはコストが重いので、
# 取りうる数値が1から28123の間に入ることに着目して、添え字に対応してbool値を返すだけのキャッシュを準備する。
# これらの準備が整ったところで、1から28123までの全ての数値が過剰数の総和であらわされるのかどうかをチェックし、弾かれるものの総和を返す。

def euler023(index=28123)
	list = []
	cache = Array.new(index+1, false)

	# 過剰数をキャッシュとリストにぶち込む
	12.upto(index) do |idx|
		if idx < get_divisor_list(idx).select{|d| d != idx}.inject(:+)
			cache[idx] = true
			list << idx 
		end
	end
	ret = 0
	1.upto(index) do |idx|
		ret += idx if check_sumset(idx, list, cache) == false
	end
	return ret
end

def get_divisor_list(num)
	return [1] if num == 1
	(1..Math.sqrt(num).to_i).select do |i|
		num%i == 0
	end.map {|e| [e, num/e]}.flatten.uniq.sort
end

def check_sumset(num, list, cache)
	list.each do |data|
		break if data > num/2
		return true if cache[num-data] == true
	end
	return false
end