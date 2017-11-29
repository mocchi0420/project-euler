# coding: utf-8
# Problem 3 「最大の素因数」
def euler003(target_num = 600851475143)
	if prime?(target_num)
		return target_num
	else
		p get_prime_factors(target_num)
		return get_prime_factors(target_num).last
	end
end

# ミラー-ラビン素数判定法に基づく素数チェック関数
def prime?(num)
	n = num.abs()
	return true if n == 2	#2は素数
	return false if n == 1 || n % 2 == 0	#1と2以外の偶数は素数ではない

	d = n-1
	s = 0
	while(d % 2 == 0) do
		d = d / 2
      s += 1
	end
	
	#判定サイクル(k=20程度で十分と仮定)
	20.times do
		isPP = false

		a = rand(n-2) + 1
		r = mod_pow(a,d,n)
		isPP = true if (r == 1 || r == n-1)

		s.times do
			r = mod_pow(r,2,n)
			isPP = true if(r == n - 1)
		end

		return false if isPP == false
	end
	return true
end

def mod_pow(base, power, mod)
	return 1 if (power == 0)
	if (power % 2 == 0)
		return mod_pow(base * base % mod, power / 2, mod)
	else
		return mod_pow(base, power - 1, mod) * base % mod
	end
end

# ρ法による素因数分解
# Euclidの互除法でGCDを求める関数
def gcd(a,b)
  while (a %= b) != 0 do
    a, b = b, a
  end
  return b
end

# nのp因子を全て取り除きながら、その都度配列へと格納する関数
def div_while_divisible(n, prob)
	ret = []
	while true do
		quot, rem = n.divmod(prob)
		return {num:n, arr:ret} if rem != 0
		ret << prob
		n = quot
	end
	return {num:n, arr:ret}
end
  

def get_prime_factors(n)
	ret = []
	c = 1
	y = x = rand(n)        # x_1をランダムに決定。 => y_1に代入
	x = (x**2+c)%n         # x_2を計算

	ubound = Math.sqrt(n).to_i + 2

	next_2pow = 2          # 現在のi以上の最小の2の羃
	i = 1

	while (i += 1) <= ubound
		g = gcd(y-x, n).abs
		if g == n then
			break
		elsif g != 1 then
			tmp= div_while_divisible(n,g)
			n = tmp[:num]
			ret << tmp[:arr] if tmp[:arr] != []
			ubound = Math.sqrt(n).to_i + 2
		end

		if i == next_2pow then         # iが2の羃に達したら
			y = x      	                # y_iを次の項に移す(直前のxの値を使える）
			next_2pow *= 2;             # 次の2の羃を設定
		end

		i += 1
		x = (x**2+c) % n
	end

	ret << n
	return ret.flatten.sort
end