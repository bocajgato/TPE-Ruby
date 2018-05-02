class Task
    attr_reader :date, :group, :description, :state
    BLANK_SPACE_DATE="           "
    def initialize(description=nil,date=nil,group=nil)
      return nil if description.nil?
      @description=description
      @date=date
      @group=group
      @state=0 #Estado 0 indica pendiente y 1 indica completado
    end
    def promote_state
      @state += 1
    end
    def ==(other)
      [@description, @date, @group]==[other.description,other.date,other.group]
    end
    def <=>(other) #Se ordena por estado, fecha
      return @state<=>other.state unless (@state <=> other.state)==0
      return -1 if @date.nil? && !other.date.nil? #Las ultimas tres lineas de codigo buscan salvar el hecho de comparar
      return 1 if other.date.nil? && !@date.nil?  #un objeto de clase Date con uno de clase nil
      return @date<=>other.date
    end
    def sort_by_group(other) #Aca buscamos ordenar por grupo y dentro del grupo mantener el orden [estado fecha]
      return @group<=>other.group unless (@group<=>other.group)==0
      self<=>other
    end
    def to_s
      "#{@description}"
    end
    def all_info(with_group=true) #Cada vez que quiero listar voy a poner toda la informacion de la tarea
      (@state==1? "[X] " : "[ ] ") + (@date.nil?? BLANK_SPACE_DATE : "#{@date.taskdate_to_s}" ) + ( @group.nil?? "" : " +") + "#{@group} #{@description}"
    end
    end
  def overdue?
    self.date<Date.today
  end
end