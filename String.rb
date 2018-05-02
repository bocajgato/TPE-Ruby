class String #Redefinimos la clase string
  def to_date #Los strings de input los queremos pasar a formato fecha para poder ordenar en base a las mismas
    case self
      when "today"
        return Date.today
      when "tomorrow"
        return Date.today+1
      when"yesterday"
        return Date.today-1
    end
    raise "Invalid date" unless self.include?"/"

    a=self.partition("/")
    day=a.first
    a=(a.last).partition("/")
    month=a.first
    year=a.last
    begin
      Date.new(year.to_i,month.to_i,day.to_i)
    rescue
      raise "Invalid date"
    end
  end

  def isdaterange? #Metodo necesario para utilizar en el list de chores (simplifica el codigo)
    self.downcase=="this week" || self.downcase=="this month" || self.downcase=="overdue"
  end
end