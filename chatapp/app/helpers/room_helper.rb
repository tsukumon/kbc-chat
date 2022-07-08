module RoomHelper
  def date_format(date)
    if date >= Date.today.beginning_of_day
      "今日" + date.strftime("%H:%M")
    elsif date < Date.today.beginning_of_day && date >= Date.yesterday.beginning_of_day
      "昨日" + date.strftime("%H:%M")
    else
      date.strftime("%Y/%m/%d")
    end
  end
end
