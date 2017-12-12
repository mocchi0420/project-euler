# coding: utf-8
# Problem 35 「巡回素数」

# 簡単な方針
#
# (1)100万未満の素数の配列を取得する。
# (2)それらの素数を桁ごとに分解し、2桁以上の数値で偶数が入っていたら削除(※2以外の素数はすべてアウトなため)
# (3)ここまでに残ったやつらで既にある程度ふるい分けが終わっているはずなので、後はメモ化しながらひたすらループを回す

require 'prime'
def euler035(num=1000000)
	primes = Prime.each(num).to_a.select{|d| check_include_even?(d) == true || d==2}
	memo = Array.new(num, false)
	count = 0

	primes.each do |num|
		if num < 10 # 10以下の数字は巡回素数が確定
			memo[num] = true 
			count+=1
			next
		end
		num_arr = num.to_s.split("")
		
		(1).upto(num_arr.length-1) do |idx|
			num_arr.unshift(num_arr.last).pop
			tmp = num_arr.inject(:+).to_i
			break if Prime.prime?(tmp) != true
			if memo[tmp] == true || idx == num_arr.length-1
				memo[tmp] = true if memo[tmp] == false
				count+=1
				break
			end
		end
	end
	return count
end

def check_include_even?(num)
	return false if num.to_s.include?("0")
	return false if num.to_s.include?("2")
	return false if num.to_s.include?("4")
	return false if num.to_s.include?("6")
	return false if num.to_s.include?("8")
	return true
end