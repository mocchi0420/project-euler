# coding: utf-8
# Problem 12 「高度整除三角数」

# 簡単な方針
# 今回は目標の約数が500個以上ということがわかっていることから、約数の公式から約数の個数Nはある数XがX=p^x+q^y+r^z+……のときN=(x+1)(y+1)(z+1)……で表されるので、
# この場合、回答となる三角数は、素因数分析を行った結果から、N=(x+1)(y+1)(z+1)……>=500となるような最初のNを見つけてreturnすればよい。
# また、今回のXの区域はN=(x+1)(y+1)(z+1)……の時、x=y=z=……=1として考えると、2^8<500<2^9となることがわかる。
# つまり、一切重複しない素因数の積として見た場合に、取りうる値は、下から数えて8つの素因数の積<X<下から数えて9つの素因数の積、となる。

require 'prime'
def euler012(num=500)
	count_lower = (Math.sqrt(Prime.each.take(get_square_index(num)).inject(:*) * 2.0)).floor	#al = n(n+1)/2 > n*n/2より、n=√(2*al)より
	count_upper =  (Math.sqrt(Prime.each.take(get_square_index(num)+1).inject(:*)*2.0)-1).ceil	#au = n(n+1)/2 < (n+1)*(n+1)/2より、n=√(2*au)-1より
	
	count_lower.upto(count_upper) do |idx|
		next if idx.prime? == true || Prime.prime_division(idx *(idx+1)/2).map{|d| d[1]+1}.inject(:*) < num
		return idx*(idx+1)/2
	end
end

def get_square_index(num)
	count = 1
	while 2**count < num do
		count+=1
	end
	return count-1
end