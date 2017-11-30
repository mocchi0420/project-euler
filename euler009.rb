# coding: utf-8
# Problem 9 「特別なピタゴラス数」

# 一応の証明
# a<b<cが成立し、a^2+b^2=c^2が成立する場合には、
# (a+b)^2 > a^2+b^2 = c^2 よりa+b>cは自明
# a+b>c <=> a+b + a+b >a+b+c=1000より、a+b>500, c<500
# また、b+b>a+b>cより、b>c/2

# a<b<c <=> a+a+b<b+a+b<c+a+b <=> a+a+a<a+a+b<b+a+b<c+a+b=1000
# 3a<1000よりa<=333, a=333と最大値を想定すると、b+c=667
# b+c=667よりc+c>b+c>667から、c > b > 333, aの条件式と合わせてc > b > 333 > a
# b!=cより、335<=c, 334<=b, a<=331

# 結果として、0<a<=331, 334<=b<500, 335<=c<500
# この場合、C→bの順で取りうる値域が狭いので、これを元にループを作成

def euler009
	ret = 0
	335.upto(500) do |c|
		334.upto(500) do |b|
			a=1000-c-b
			return a*b*c if a**2+b**2==c**2
		end
	end
	return ret
end
