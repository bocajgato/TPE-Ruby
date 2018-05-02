require_relative 'InvalidTaskException.rb'
require_relative 'SaveFileError.rb'
require_relative 'OpenFileError.rb'
require_relative 'InvalidIndexError.rb'
require_relative 'TaskCompletedError.rb'

class TaskList
    attr_reader :task_list, :autonumeric
    def initialize
      @task_list=SortedSet.new
      @autonumeric=1
    end
    def add (task=nil)
      raise InvalidTaskException if task.description.nil? || task.description==""
      @task_list.add([task,@autonumeric])
      @autonumeric+=1
      [@autonumeric-1 , task]
    end
    def list(date,group,other) #CORREGIRLO
      hash_list = Hash.new { }
      hash_list["all"} = @task_list.select { |task| task[0].date===date } }) unless date.nil? #Selecciona en base a una fecha
      return hash_list.merge({:"all" => @task_list.select { |task| task[0].group==group } }) unless group.nil? #Selecciona en base a un grupo
      b=@task_list.select{ |task| !task[0].date.nil?} if other.isdaterange? #Elimina las tareas sin fechas si luego queremos
      case other                                                         #comparar por un rango de fechas porque los metodos
        when "this week"                                                 #siguientes no se definen para la clase nil
          return hash_list.merge({:"all" => b.select { |task| task[0].date.this_week? } })
        when "this month"
          return hash_list.merge({:"all" => b.select { |task| task[0].date.this_month? } })
        when "overdue"
          return hash_list.merge({:"all" => b.select { |task| task[0].overdue? } }) #agregar task(0) una variable
        when "group" #Al ordenar por grupos tambien tenemos que eliminar las tareas sin grupo por la razon anterior
          return [other,(@task_list.select{ |task| !task[0].group.nil?}).sort { |x,y| x[0].sort_by_group(y[0]) }] #MAL
        when ""
          hash_list.merge({:"all" => @task_list })
        else
          raise 'Invalid parameter'
      end
      hash_list
    end
    def ac
      @task_list.delete_if { |task| task[0].state==1}
    end
    def complete(idx)
      raise InvalidIndexError unless idx.is_a?(Integer) #El parametro no es un numero
      raise InvalidTaskException unless idx<@autonumeric && idx>0 #EL idx no corresponde a una tarea
      to_complete=@task_list.select{ |task| idx==task[1] }
      raise TaskCompletedError if to_complete[0][0].state==1
      to_complete[0][0].promote_state
      @task_list.add(to_complete[0])
      [ to_complete[0][1] , to_complete[0][0] ]
    end
    def find(str)
      @task_list.select{|task| task[0].description.downcase.include?(str.downcase)}
    end
    def save(my_file)
      raise SaveFileError unless my_file.include?(".yml")
      output= File.new(my_file,'w')
      output.puts YAML.dump(self) #Serializa un objeto de clase task_list
      output.close
    end
    def open(my_file)
      raise OpenFileError unless File.exists?(my_file)
      output=File.new(my_file, 'r')
      task_list=YAML.load(output.read) #ACA HAY QUE HACER UN RESCUE
      @task_list=old_chores.chores #cambiar esto!!!!!!!!!!!!!!!!
      @autonumeric=old_chores.autonumeric #Queremos mantener el indice donde se encontraba previamente
      output.close
    end
end
