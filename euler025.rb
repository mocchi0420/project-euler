# coding: utf-8
# Problem 25 「1000桁のフィボナッチ数」

# 簡単な方針
# F(n) = F(n-1) + F(n-2)なので、フィボナッチ数を計算するにあたっては短絡的な計算はできず、愚直に1000桁を初めて超えるn=k項までのk個の数値を算出しないといけない。
# しかし、フィボナッチ数の再帰的な算出はあまりにも計算時間を要してしまうので、メモ化による短絡計算を試行する。
# これはn=i項におけるiを添え字としたキャッシュ的配列であり、n=i+1以上の計算においてf(i)までの計算結果を用いたい場合にはこちらを使用できる。
# あとは流れで。

def euler025(index=1000)
	memo = [0,1]
	count = 2
	fib_num = 0
	digit = fib_num.to_s.length # わざわざ10^999のような巨大な数値を持たずに文字列の長さ=桁として考える
	
	while digit < index do
		count += 1
		fib_num = get_fib(count, memo)
		digit = fib_num.to_s.length
	end
	return count
end

def get_fib(num, memo)
	memo.size.upto(num) do |idx|
		memo[idx] = memo[idx-1] + memo[idx-2] 
	end
	return memo[num]
end