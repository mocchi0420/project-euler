# coding: utf-8
# Problem 27 「二次式素数」

# 簡単な方針
# f(n) = n^2 + a*n + b > 0 (∵f(n)は素数)において、
#
# n=0 とすると、f(0) = b より、題意からbは素数でないといけない。このことからbは素数かつb>0　(∵素数は自然数より) (1)
# 
# 続いて、n=1およびn=bのときを考えると、f(1) = (1+a+b), f(b) = b^2 + a*b + b = b*(b+a+1) = b*f(1) となり、必ず素数でなくなる。
# つまり、f(n)が連続する素数を生成すると仮定した場合、必ずn < bが成立する。(2)
# するとこのとき、
# (※)問題例よりb=41のときに0 <= n <= 39までの40個の数値を満たすことが発見されている
# これら二つの条件から、題意を満たすような(a,b)の組を探すにあたって、b=41において必ず40個の解を持ちうることからb > 40 (3)
#
# (1)~(3)により、bに関してはb > 40となる素数について解を探せばよい。見つからなかった場合には1*41を返す。
# 
# 次にaの値域について考えると、(3)より今回の題意を満たすような素数bはb>40であることから必ず奇数である。
# すると、f(n) = n^2+a*n+bより、
# f(1)=(1+a+b) <=> a = f(1) - (b + 1)
# (b + 1)はb>40の奇数より偶数、f(1)が素数であることから、素数-偶数=奇数(素数-偶数が2となる事もあるが、それはf(1)=2,b+1=0の場合のみで、それはありえない。)
# よって、aは-1000<a<1000を満たす奇数になる。 
#
# (3)と(4)から、aとbの組については高々1000通り*100~200通りの素数を試せばよくなった。
# しかし、これらのパターンに対してnを0から全て走査していくのはコストがかかりすぎる。
# そこで、計算の単純化のために、以下のアルゴリズムを考える。
#
# ～すずき的アルゴリズム～
# 
# b=41のときに0 <= n <= 39を満たすことが分かっていることから、これよりも多くの素数を含む式を探すには、n=40が満たされている必要がある。
# そこで初期値としてn=40の時にf(n)を素数にするaのリストlist_aを取得する。
# 1からb-1までの数値kで以下の調査を行う。(つまり、b>nの条件による調査)
# 　(1)list_aの各数値に対して、f(k)が素数にならないものを削除する。(※)
#   (2)もしlist_aがからっぽになってしまったらそこで計算終了
#	 (3)list_aが空っぽにならず、かつk>=nの場合、list_aの最後尾の数値とbの組を解として更新し、nの値を1増やす
# bすべてに対してこのアプローチを行う
# 多くの場合には(※)でつっかかって対象が減っていくので、計算量自体はそんなに増えない(はず)

require 'prime'
def euler027
	a_list = (-1000..1000).to_a.select{|d| d % 2 == 1}
	b_list =  Prime.each(1000).to_a.select{|d| d > 40}

	ans = [1,41]	#一応、a=-1,b=41を解として持っておく
	prime_length = 40	#現在の素数の数(40個が最大なら↑のansを解とする。
	
	b_list.each do |b|
		tmp_a_list = a_list.select{|a| Prime.prime?((prime_length)**2 + a * (prime_length) + b) == true} #現在取りうる最大の素数の数より1大きい数値で素数となるもののリストを取得する。

		#0<=n<bかつf(0)=b,f(b)は素数でないことから、1<=k<=b-1の範囲で走査
		1.upto(b-1) do |idx|
			tmp_a_list = tmp_a_list.select{|a| Prime.prime?((idx)**2 + a * (idx) + b) == true} #f(k)が素数になるもののリストを更新し続ける。
			break if tmp_a_list == [] #連続して素数にならない状況になったら計算終了

			# 現在観測している最大の連続素数の数を超えてきたら、解ansと閾値となる素数の数prime_lengthを更新
			if idx >= prime_length
				ans = [tmp_a_list.last, b]
				prime_length += 1
			end
		end
	end
	return ans.inject(:*)
end