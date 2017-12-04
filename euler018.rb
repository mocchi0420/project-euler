# coding: utf-8
# Problem 18 「最大経路の和 その1」

# 簡単な方針
# まず、最も小さな木構造ABCを考える
#  A
# B C
# となっているような状態において、B>Cであるならば、
#   F
#  A D
# B C E
# という形で経路が追加された場合でも、最大値(または最小値)を取りうる場合には必ずB(最小値の場合にはC)を通過する 
# このことから、もっとも深いN階層目のN個の数列から順に2つずつを取り出し、大きい方だけを残した数列を取り出してN-1階層目の数列と足し算する。
# これをN回繰り返すことで、N=1にて最小値が確定する


def euler018
	arr = ["75",
			"95 64",
			"17 47 82",
			"18 35 87 10",
			"20 04 82 47 65",
			"19 01 23 75 03 34",
			"88 02 77 73 07 63 67",
			"99 65 04 28 06 16 70 92",
			"41 41 26 56 83 40 80 70 33",
			"41 48 72 33 47 32 37 16 94 29",
			"53 71 44 65 25 43 91 52 97 51 14",
			"70 11 33 28 77 73 17 78 39 68 17 57",
			"91 71 52 38 17 14 91 43 58 50 27 29 48",
			"63 66 04 68 89 53 67 30 73 16 69 87 40 31",
			"04 62 98 27 23 09 70 98 73 93 38 53 60 04 23"].map{|d| d.split(" ").map{|e| e.to_i}}
			
	depth = arr.length-1
	
	while arr.length > 1 do
		depth = arr.length-1
		tmp = []
		0.upto(arr[-1].length-2) do |d|
			tmp << arr[-1].values_at(d,(d+1)).max			
		end
		arr[-2] = arr[-2].zip(tmp).map{|f, s| f + s}
		arr.pop
	end

	return arr[0][0]
end