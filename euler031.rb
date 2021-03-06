# coding: utf-8
# Problem 31 「硬貨の和」

# 簡単な方針
#
# 格好をつけて動的計画法なんて使ってみる。
# まず、使用可能なペンスの集合を求める。
# pence = [1,2,5,10,20,50,100,200]
# 
# 次に、今回200ペンス以下の構成数を考えればいいので、
# ひとまず添え字を0~200とする配列memoを考える。この時、memo[0]=1、それ以外を0として探索の準備をする。
#
# あとは深さ優先探索で以下のように計算していく。
#
# pence=1の時、
# 1ペンス硬貨で1ペンスを構成する方法は1通りであり、これをmemo[1]に代入する。
# 2ペンス、3ペンスも同様なので同じようにし、memo[200]まで1が代入された状態にする。
# 
# pence=2の時、
# 1ペンスを構成できないのでmemo[1]については無視。
# 2ペンス硬貨で2ペンスを構成する方法は自身の1通りであり、2ペンス=1ペンス+1ペンスの1通りがmemo[2]に加わっているのでmemo[2]には1を加算する。
# 3ペンスを構成する方法は、3ペンス=2ペンス+1ペンスor1ペンス*3と考えると、現在memo[3]には1ペンス*3との場合の1パターンが格納されているので同じように１を加算。
# 4ペンスを構成する方法は、4ペンス=2ペンス+2ペンスとなり、2ペンスの構成方法は現在2個なので、2を足す
# ……という形で、n<2以下については何もせず、n=2ペンスの時には1を追加し、n>3の時にはnペンスの構成数にn-2ペンスの構成数を加えていく。
#
# pence=5の時
# 1ペンスから4ペンスは構成できないので5ペンスからスタート
# 5ペンス硬貨で5ペンスを構成する方法は自身の1通りであるのでmemo[5]+=1
# 5ペンス硬貨込みで6ペンスを構成する方法は5ペンス+1ペンスより、1ペンスの構成数をmemo[6]に加える
#
# ……と、こんな感じでやっていけばそのうち計算が終わる。


def euler031
	pence = [1,2,5,10,20,50,100,200]
	memo = Array.new(201, 0)
	memo[0] = 1		#0+n番目にpence[n]の回数が追加されるという意味を込める。	
	pence.each do |data|
		0.upto(200) do |idx|
			next if memo[idx] == 0	#今回は関係ないが、1ペンスが無い時などには必要な処理
			tmp_idx = idx + data
			break if 200 <tmp_idx
			memo[tmp_idx] += memo[idx]
		end
	end
	return memo[200]
end