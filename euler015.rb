# coding: utf-8
# Problem 15 「格子経路」

# 簡単な方針
# n*nの格子経路を左上から右下に行くためには、必ず2n個の格子を通らないといけない。
# この2n個の格子の内、n個の縦列or横列の選び方は2nCnで与えられる。
# 実際、2*2マスの場合は4C2=4*3/2*1=6通りとなっている。このことから算出を行う。

def euler015(grid=[20,20])
	route_length = grid[0]+grid[1]
	
	#階乗
	return ((grid[1]+1)..route_length).to_a.inject(:*)/(1..grid[1]).to_a.inject(:*)
end