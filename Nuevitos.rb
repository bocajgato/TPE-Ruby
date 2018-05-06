class Task
  attr_reader :description, :date, :group
  def initialize(description,date,group)
    @description=description
    @date=date
    @group=group
  end
  def to_s
    "#{@description}"
  end
  def all_info
    sprintf("%-10s" + @group==nil?? "":"+#{@group}" + "%s",[@date.to_s,@description])
  end
  def <=>(other)
    return -1 if @date.nil? && !other.date.nil?
    return 1 if other.date.nil? && !@date.nil?
    return @date<=>other.date
  end
  def ==(other)
    [@description, @date, @group]==[other.description,other.date,other.group]
  end
end

class PendingTask < Task
  def all_info
    "[ ] " + super
  end
  def overdue?
    self.date<Date.today
  end
end

class CompletedTask < Task
  def all_info
    "[X] " + super
  end
end

class TaskList
  attr_reader :pending_tasks, :completed_tasks
  def initialize
    @pending_tasks=SortedSet.new
    @completed_tasks=SortedSet.new
    @autonumeric=1
  end

  def ac
    @completed_tasks=""
  end

end

class AcTasks
  def initialize(command_parameters,task_list)
    @tasklist=task_list
    @command_parameters=command_parameters
  end
  def execute
    raise InvalidAc unless @description==""
    @tasklist.complete
  end
  def to_s
    "All completed todos have been archived."
  end
end


class InputParser
    def initialize (user_input)
      @user_input=user_input
      @command_parameters=nil
      @command=nil
    end
    def command
      operation=@to_operate.partition(" ") #Separa el comando
      @command=operation.first.downcase
      @command_parameters=(operation.last)
      @command
    end
    def command_parameters
      @command_parameters
    end
end   
