class Parser #Recibe el input del usuario y lo modifica para obtener los campos necesarios para operar
  def initialize (param)
    @to_operate=param
    @group=nil
    @date=nil
    @description=nil
    @command=nil
  end
  def command
    operation=@to_operate.partition(" ") #Separa el comando
    @command=operation.first.downcase
    @to_operate=(operation.last)
    @command
  end
  def group
    if( /[+]/ =~ @to_operate )  then
      group=@to_operate.partition("+").last.partition(" ").first #Separa el grupo sin el simbolo "+"
      @to_operate=@to_operate.partition("+").last.partition(" ").last
    end
      @group
  end
  def date
    if ( /due/ =~ @to_operate && !@to_operate.include?("overdue")) then
      @description=@to_operate.partition("due ").first #Separa la descripcion de la tarea
      to_analyze=@to_operate.partition("due ").last #Luego del due
      if  to_analyze.isdaterange? then #Si es un daterange es porque no es la fecha de una tarea a agregar,
        @description=to_analyze        #sino que es un parametro para realizar otro metodo
      else
        @date=(to_analyze).to_date
      end
    end
    @date
  end
  def descritpion
    return @descritpion unless @description.nil?
    @to_operate
  end
  def to_s
    "Descripcion:#{@description}, grupo:#{@group} ,date:#{@date} ,comando:#{@command}"
  end #No se utiliza en este programa, pero lo definimos por si es necesario imprimir los campos de interes del Input
end