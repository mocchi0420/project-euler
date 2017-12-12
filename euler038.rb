# coding: utf-8
# Problem 38 「パンデジタル倍数」

# 簡単な方針
#
# 設問より、「(1,2,...,n) (n > 1) との連結積」となっているので、最低でも(1,2)との連結積を考慮しないといけない。
# (1,2)のとき、この連結積が1～9のパンデジタル倍数となるのは2*Aが5桁となるような4桁の数Aである。
# すなわち、Aは5000<=A<=9999を満たすような数であり、10000<=AとなるようなAは題意を満たさないことが分かる。
#
# 同じように(1,2,3)についても考えていくと、すくなくともAは333以下であることがわかる。(※333666999は9桁だが、334になると3346681002となり10桁となってしまうため。)
# この連結積が9桁になるために必要な値域を獲得する関数を用意して範囲を常に狭めながら計算することで計算時間を下げる試みをしてみる。

def euler038
	product_num = [1,2]
	ret = 0
	while product_num.length <= 9 do
		tmp_num_set = get_num_range(product_num)
		if tmp_num_set != []
			tmp_ans = tmp_num_set.map{|d| product_num.map{|e| (e*d).to_s}.inject(:+)}.select{|d| d.split("").uniq.length == 9 && d.include?("0") != true}.map{|d| d.to_i}.max
			if tmp_ans != nil #場合によっては答えがnilの場合があるので。
				ret = tmp_ans if ret < tmp_ans 
			end
		end
		product_num << product_num.last+1
	end
	return ret
end

def get_num_range(product_num)
	min = 0
	max = 0
	flag = false
	index = [0,0]
	0.upto(4) do |idx|
		tmp = 10**idx
		num_length = product_num.map{|e| Math.log10(e*tmp).floor+1}.inject(:+)
		if num_length <= 9
			index[0] = idx
		else
			index[1] = idx
		end
		break if index[1] > 0
	end
	
	(10**index[0]).upto(10**index[1]) do |idx|
		if min == 0 && product_num.map{|e| Math.log10(e*idx).floor+1}.inject(:+) == 9
			min = idx
		end 
		if product_num.map{|e| Math.log10(e*idx).floor+1}.inject(:+) > 9
			max = idx-1
			flag = true
		end
		break if flag == true
	end
	
	if min == 0
		return []
	else
		return (min..max).to_a
	end
end