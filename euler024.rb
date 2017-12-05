# coding: utf-8
# Problem 24 「辞書式順列」

# 簡単な方針
# n個の数値を並べる方法はn!通り。
# ある数AをA=X10*10!+X9*9!+……+X2*2!+X1*1!
# と置き、Xnの配列A(Xn)を取得する。
# あとは流れで

def euler024(num=1000000)
	list = Array.new(11,0)
	10.downto(1) do |idx|
		tmp = num.divmod(get_fact(idx))
		list[idx] = tmp[0]
		num = tmp[1]	
	end
	
	p list
	
	ret = 0
	1.upto(10) do |idx|
		ret += list[idx]*get_fact(idx)
	end
	p ret

	return list
end

def get_fact(n)
  (1..n).to_a.inject(1) {|f, i| f*i}
end