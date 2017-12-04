# coding: utf-8
# Problem 14 「最長のコラッツ数列」

# 簡単な方針
# ※計算時間が長すぎたので方針転換
# コラッツ数列が必ずhoge→……→2→1という形で1に収束していくことを考えると、ある数N(N>=3)のコラッツ数列はN-1までのコラッツ数列のいずれかを必ずどこかに含むはずである。
# このことから考えて、愚直にコラッツ数列を求めるのではなく、コラッツ数列の長さのみを数列に格納していき、
# arr[N] = (Nのコラッツ数列の長さ)　という形をとるようにし、数列の長さだけを計算する。

require 'prime'
def euler014(num=1000000)
	collatz_arr = Array.new(num, 1)
	collatz_max = [1,1]
	
	2.upto(num-1) do |data|
		index = data
		count = 0
		while index >= data do
			index = (index % 2 == 0) ? index/2 : 3*index+1
			count += 1
		end
		count += collatz_arr[index]
		collatz_arr[data] = count
		collatz_max = [data, count] if count > collatz_max[1]
	end
	
	return collatz_max[0]

end