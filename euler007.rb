# coding: utf-8
# Problem 7 「10001番目の素数」


require 'prime'
def euler007
	return Prime.each.take(10001).last
end
# ちゃんと手も動かした証拠を残しておく
=begin
def euler007(num=10001)
	count=0
	base=1
	
	while count < num do
		if base < 3
			base += 1
		else
			base += 2
		end
		count += 1 if isprime(base)
	end

	return base
end

def isprime(n)
	return true if n == 2
	return false if n % 2 == 0 || n < 2
	
	i=3
	while i <= Math.sqrt(n)
		return false if n % i == 0
		i += 1
	end
	return true
end
=end