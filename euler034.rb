# coding: utf-8
# Problem 34 「桁の階乗」

# 簡単な方針
#
# 今回も取りうる限界の値から考える。
# 今回のパターンだと、9999999……となった場合にはn*9!(※nは桁数)が取りうる最大値となる。
# この場合、n*9!が元の数を越える(=元の数を表現できる)ためにはn*9! - (10^n - 1) > 0となる最大のnが分かればいい。
# この場合だとn=6が限界値。
# 
# あとは30問目と同じノリで...と思ったら、30問目とは同じノリにできない理由があるので考える。
# 具体的には0!=1が存在してしまう問題である。
# このため、[0,0,0,0,3,4]は、問30では34も340も3400も同じ数だったが、今回はそうはいかなくなってしまった。
#
# そこで、今回は計算時間は増えてしまうが、桁ごとに別の配列の集合を作成することを考える。
# 
# 

def euler034
	factorial = (0..9).to_a.map{|d| (1..d).inject(1,:*)}
	base_arr = Array.new(7,nil)
	ans_arr = Array.new(7,nil)	
	
	base_arr.each_with_index do |data, i|
		base_arr[i] = [];next if i==0
		base_arr[i] = (0..9).to_a.repeated_combination(i).to_a
		ans_arr[i] = base_arr[i].map{|d| d.map{|e| factorial[e]}.inject(:+)}
	end
	
	ret = []
	
	ans_arr.each_with_index do |arr, arr_idx|
		next if arr_idx == 0
		arr.each_with_index do |data, data_idx|
			tmp_data = data.to_s.split("").map{|d| d.to_i}
			ret << data if base_arr[arr_idx][data_idx] == tmp_data.sort
		end
	end
	return ret.select{|e| e!=1 && e!=2}.inject(:+)
end