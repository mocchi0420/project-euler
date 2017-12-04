# coding: utf-8
# Problem 19 「日曜日の数え上げ」

# 簡単な方針
# 365日を7で割ると52週と1日、366日を7で割ると52週と2日となり、
# 月初めの曜日は毎年1日、4年に1度だけ2日ずれていく。
# このことから、0:日曜日、1:月曜日、……、6:土曜日という形で数値を定義し、
# まず、1900年の月初めの曜日の配列を求める。
# その後、1901年から2000年まで100年分ループさせ、月初めの曜日が日曜日である月の数を数え上げる。


def euler019
	normalyear_days = [31,28,31,30,31,30,31,31,30,31,30,31]
	normalyear_weekdays = Array.new(12,0)
	
	normalyear_days.map{|d| d%7}.unshift(0).values_at(0..11).each_with_index do |data, idx|
		if data != 0
			idx.upto(normalyear_weekdays.length-1) do |d|
				normalyear_weekdays[d] = (normalyear_weekdays[d] + data) % 7
			end
		end
	end
	
	leapyear_weekdays = normalyear_weekdays.map{|d| (d+1)%7}
	leapyear_weekdays[0..1] = normalyear_weekdays[0..1]
	
	# 1900年の1年の曜日始まりを取得。(この場合は月曜日なので1になる)
	weekdays = normalyear_weekdays.map{|d| (d+1)%7}
	
	ret = 0
	diff = 1	# 日付のずれを格納(うるう年の次の年が2日ずれるのに注意)
	
	# 100年間のループを開始
	1901.upto(2000) do |year|
		if year % 4 == 0 && (year % 400 != 0 && year % 100 == 0) == false
			weekdays = leapyear_weekdays.map{|d| (d+weekdays[0]+diff)%7}
			diff = 2
		else
			weekdays = normalyear_weekdays.map{|d| (d+weekdays[0]+diff)%7}
			diff = 1
		end
		ret += weekdays.select{|d| d==0}.length
	end
	return ret

end