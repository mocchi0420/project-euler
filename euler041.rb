# coding: utf-8
# Problem 41 「パンデジタル素数」

# 簡単な方針
# 
# まず悲しいお知らせとして、9桁と8桁のパンデジタル素数は存在しない。
# 理由は単純で1+2+3+4+5+6+7+8=36, 1+2+3+4+5+6+7+8+9=45となり、8桁または9桁のパンデジタル数は必ず3の倍数になってしまうからである。
# これと同じ理由で、1からnまでの合計が3の倍数となるパンデジタル数は存在できないので、今回の題意を満たしうるのはn{1,4,7}の3種類の桁の時のみ。
# したがって、7桁の数値で素数となるものを探す事にする。
# また、この時欲しいのは「もっとも大きな素数」なので、先頭の数は7桁の場合は7、n桁の場合にはnから開始、という形で計算回数を減らす努力をしてみる

require 'prime'
def euler041
	index = [7,4,1]
	index.each do |idx|
		return 1 if idx == 1		#最後の手段
		idx.downto(1) do |tmp_i|
			arr = ((1..idx).to_a - [tmp_i]).to_a.permutation(idx-1).map{|d| d.unshift(tmp_i)}.to_a.select{|e| e.last.even? != true && e.last != 5}.map{|d| d.map{|e| e.to_s}.inject(:+).to_i}.select{|e| Prime.prime?(e)}
			return arr.last if arr != []
		end
	end
end