class TaskDate < Date
  def this_week?
    thisweek=Date.today.cweek
    self.cweek==thisweek
  end
  def this_month?
    self.month==Date.today.month
  end
  def taskdate_to_s #Imprime en formato DD/MM/YYYY. No lo llamamos to_s para no afectar la forma en que se guarda el archivo yml
    "#{format('%02d',self.day)}/#{format('%02d',self.month)}/#{self.year}"
  end
end