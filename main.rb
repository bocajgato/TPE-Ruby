require_relative 'Output.rb'
require_relative 'Task.rb'
require_relative 'TaskList.rb'
require_relative 'TaskDate.rb'
require_relative 'Parser.rb'
require_relative 'InvalidCommandError.rb'
require_relative 'InvalidAnswerError.rb'

task_list=TaskList.new
while((str=gets.chomp)!="exit")
  begin
    parsed_input=Parser.new(str)
    output=Output.case
    new parsed_input.command #Se encarga de realizar el comando correspondiente
      when "add"
        task=Task.new(parsed_input.description,parsed_input.date,parsed_input.group)
        output.print_add(tareas.add(task))
      when "list"
        group=parsed_input.group
        description=parsed_input.description
        output.print_list(tareas.list(parsed_input.date,group,description),group,description)
      when "complete"
        output.print_complete(tareas.complete(parsed_input.description.to_i))
        when "ac"
        tareas.ac
        output.print_ac
      when "save"
        tareas.save(parsed_input.description+".yml")
        output.print_save
      when "open" #Se asegura de que el usuario sabe que las tareas en ejecucion seran reemplazadas por las del archivo
        output.print_question_open
        str=(gets.chomp).downcase
        raise InvalidAnswerError unless str=="no" || str=="yes"
        tareas.open(parsed_input.description) unless str=="no"
        output.print_open if str=="yes"
      when "find"
        output.print_find(tareas.find(parsed_input.description))
      else
        raise InvalidCommandError
      end
  rescue Exception => e #Rescata las excepciones para evitar la terminacion del programa
    puts e.message #Envia el mensaje de error correspondiente
  end
end