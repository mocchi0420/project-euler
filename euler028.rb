# coding: utf-8
# Problem 28 「螺旋状に並んだ数の対角線」

# 簡単な方針
# n回の移動でn*nの正方形が生成されると想定する。
# この時、中心点からの4方向で観測できる対角線上の数値の配列をupper_right, upper_left, lower_right, lower_leftとして定義する(中心となるマスが存在する場合には、その数値をすべての配列に格納)と、
# n=2k+1(k=0,1,2…)のとき、
# upper_right : n^2の集合
# upper_left : n^2 - (n-1) の集合
# lower_right : n^2 - 3(n-1) の集合
# lower_left : n^2 - 2(n-1) の集合
# n=2k(k=0,1,2…)のとき、
# upper_right : n^2 - 2*(n-1) の集合
# upper_left :  n^2 - 3*(n-1) の集合
# lower_right : n^2 - (n-1) の集合
# lower_left : n^2 の集合
# ※証明は割愛。
# 
# あとは与えられたn*nの正方形に対して、配列をちょちょいといじくって数値を出せばおｋ

def euler028(n=1001)
	if n%2 == 1 then
		tmp = (0..(n-1)/2).to_a.map{|d| 2*d+1}
		upper_right = tmp.map{|d| d**2}
		upper_left = tmp.map{|d| d**2 - (d-1)}
		lower_right = tmp.map{|d| d**2 - 3*(d-1)}
		lower_left = tmp.map{|d| d**2 - 2*(d-1)}
	else
		tmp = (1..n/2).to_a.map{|d| 2*d}
		upper_right = tmp.map{|d| d**2 - 2*(d-1)}
		upper_left = tmp.map{|d| d**2 - 3*(d-1)}
		lower_right = tmp.map{|d| d**2 - (d-1)}
		lower_left = tmp.map{|d| d**2}
	end
	return (upper_right | upper_left | lower_right | lower_left).inject(:+)
end