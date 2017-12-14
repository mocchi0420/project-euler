# coding: utf-8
# Problem 44 「五角数」

# 簡単な方針
# 
# ※実行速度が遅かったのでちょっといろいろ調べて頑張って改善してみた。
# 最終的な出力Dが、D = |Pk - Pj|として表されることに着目する。
# Pk > Pjであると仮定すると、
# D = |Pk - Pj| = n_k(3n_k-1)/2 - n_j(3n_j-1)/2 
# D = 1/2*{ 3(n_k^2-n_j^2) -(n_k - n_j) } = 1/2*[ {n_k - n_j}{3(n_k+n_j) - 1} ]
# このDがあるn_l*(3*n_l-1)/2と一致すればいいことを考えると、
# 1/2*[ {n_k - n_j}{3(n_k+n_j) - 1} ] = n_l*(3*n_l-1)/2
# {n_k - n_j}{3(n_k+n_j) - 1} = n_l*(3*n_l-1)
# 
# ここで、n_l*(3*n_l-1)はn_lと(3*n_l-1)は互いに素であり、2つの数の掛け合わせ(ただし、はn_l < (3*n_l-1))で構成されることに着目する。
# 同様に左辺も{n_k - n_j}と{3(n_k+n_j) - 1}の組み合わせで成立することを考えると、
# Pk > Pjという仮定からn_k > n_jなので、{n_k - n_j} < {3(n_k+n_j) - 1}
#
# 実際にn_kとn_jがどういった数値となるかは不明だが、n_l および (3*n_l-1))の素因数分解した結果から、{n_k - n_j} と {3(n_k+n_j) - 1}が導き出せるはずである。
# 
# このことからn_lを加算していくループを軸として、下記のアルゴリズムを考える。
# (1)1<=n_lにおいてn_l=1からループを開始する。
# (2)n_lを素因数分解した上で、同一の数値は全て掛け合わせた状態の数値の集合を配列T_kとして用意する。
#    たとえば、n_l=12ならば、[2,2,3]ではなく[3,4]として持つことを意味する。
#    こうする理由は単純で、これから作成する3*n_l-1の項とn_lとは互いに素であるため共通項を持たないためである。
#    そのため、2^2の項は確実にすべてがどちらかの数値に従属する、と仮定してよいので、同一の数値がある場合にはすべて掛け合わせておく。
# (3)上記と同様に、3*n_l-1を素因数分解し、同一の数値は全て掛け合わせた状態の数値の集合を配列T_jとして用意する。
# (4)T_kとT_jを1つの集合とし、この集合内の数値を全てを用いて2つの組に分け、掛け合わせて2つの数値を作成する。
# (5)これらの数値を条件に合わせて篩分けし、2つの数の内、小さい方を{n_k - n_j}、大きい方を{3(n_k+n_j) - 1}と仮定して、n_kとn_jを導出する。
# (6)n_kとn_jを導出したら、それぞれを使用して三角数を出し、足し合わせる。
#    もしこれが5角数判別式において真になるのならば、それが求めていた解なので、それを出力して終了。
# 
# ※5角数判別式とは？
# ある5角数X=N(3N-1)/2から、Nの2次方程式として捉えると、
# 3N^2 - N -2X = 0 <=> N = 1/6 * {1 ± √(1+24X)} = 0
# このときX>0なので、N = 1/6 * {1 + √(1+24X)}
# これがXを代入して整数となる場合に、5角数であるということが断定できる。


require 'prime'
def euler044
	count = 1 # ループのカウンタ
	ret = 0 # 答えの格納先
	
	while ret == 0 do
		table_k = Prime.prime_division(count).map{|d| d[0]**d[1]}
		table_j = Prime.prime_division(3*count-1).map{|d| d[0]**d[1]}
		table = table_k | table_j
		1.upto(table.length-1) do |idx|
			tmp_k = table.combination(idx).to_a
			tmp_k.each do |co_table|
				tmp_j = table - co_table

				next if (co_table.inject(:*) > tmp_j.inject(:*)) || (tmp_j.inject(:*)+1)%3 != 0
				n_j = ( (tmp_j.inject(:*)+1)/3 + co_table.inject(:*) )/2
				n_k = n_j - co_table.inject(:*)
				next if n_j <= 0 || n_k <= 0
				
				ans = n_k*(n_k*3-1)/2 + n_j*(n_j*3-1)/2
				judge = ((1 + 24 * ans) ** 0.5 + 1) / 6.0
				
				if judge == judge.to_i				
					ret = count*(3*count-1)/2
					break
				end
			end
		end
		count+=1
	end
	return ret
end

=begin
def euler044
	ret = 0
	memo = [0,1]
	index = 1
	
	while ret == 0 do
		memo.store(get_penta_num(index), true)
		if index > 2
			1.upto((index.to_f/2).floor) do |idx|
				next if idx == index - idx
				a = [index-idx, idx].min
				b = [index-idx, idx].max
				next if memo[get_penta_num(index)-3*a*b] == nil
				next if memo[get_penta_num(b-a)+3*a*(b-a)] == nil
				ret = get_penta_num(b-a)+3*a*(b-a)
				break
			end
		end
		index += 1
	end
	return ret
end

def get_penta_num(num)
	return num*(3*num-1)/2
end
=end