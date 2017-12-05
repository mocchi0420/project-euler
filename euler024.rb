# coding: utf-8
# Problem 24 「辞書式順列」

# 簡単な方針
# n個の数値を並べる方法はn!通り。
# 頭文字が0～9までの数字が辞書の何番目に存在するかを考えると、
# 頭文字が0のとき：辞書の1番目から9!番目
# 頭文字が1のとき：辞書の9!+1番目から2*9!番目
# (中略)
# 頭文字がnのとき：辞書のn*9!番目から(n+1)*9!番目
# また、頭文字がnのとき、残った9つの数字がどのような順番に並ぶかについても同様に、
# 頭文字がnで2番目の文字がmのとき：辞書のn*9!+m*8!番目からn*9!+(m+1)*8!番目
# という形に表される。
# このことから、
# ある数AをA=X9*9!+……+X2*2!+X1*1!
# と置き、Xnの配列A(Xn)を流れで算出して終了

def euler024(num=1000000)
	num -= 1
	index_list = (0..9).to_a
	ret = []
	9.downto(0) do |data|
		tmp = num.divmod(get_fact(data))
		ret << index_list[tmp[0]]
		index_list.delete_at(tmp[0])
		num = tmp[1]
	end
	return ret.map{|d| d.to_s}.inject(:+).to_i
end

def get_fact(n)
  (1..n).to_a.inject(1) {|f, i| f*i}
end