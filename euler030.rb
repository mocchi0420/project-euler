# coding: utf-8
# Problem 30 「各桁の5乗」

# 簡単な方針
# とにかくめちゃくちゃ高速化には成功したので、リファクタは後でやる



require 'prime'

def euler030

	start_time = Time.now

	hoge = (0..9).to_a.map{|d| [d]}
	1.upto(5) do |idx|
		tmp = []
		hoge.each do |d|
			0.upto(9) do |num|
				if d.max <= num
					t_ary = Marshal.load(Marshal.dump(d))
					t_ary << num
					tmp << t_ary.sort
				end
			end
		end
		hoge = tmp
	end
	hoge = hoge.uniq
	
	ans_arr = hoge.map{|d| d.map{|e| e**5}.inject(:+)}
	
	loop_num = 6*9**5	# 最大ループ回数

	ret = []
	
	ans_arr.each_with_index do |data, idx|
		tmp_data = data.to_s.split("").map{|d| d.to_i}
		if tmp_data.length < 6 then
			(6-tmp_data.length).times{tmp_data << 0}
		end
		ret << data if hoge[idx] == tmp_data.sort && hoge[idx] != [0,0,0,0,0,1]
	end
	
	return ret.inject(:+)
end
