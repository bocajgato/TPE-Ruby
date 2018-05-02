class Output
  def initialize
  end
  def print_add(output_add)
    puts "Todo [#{output_add[0]}: " + output_add[1].to_s + "] added"
  end
  def print_list(hash_list,group=nil,desc="") #TERMINARLO
    print_list_all(hash_list) if group.nil? && desc==""
    print_list_group(group,hash_list) unless group.nil?
    print_list_groups(hash_list) if desc=="group"
  end
  def print_ac
    puts "All completed todos have been archived"
  end
  def print_complete(output_complete)
    puts "Todo " + output_complete[0].to_s + ": " + output_complete[1].to_s + " completed"
  end
  def print_save
    puts "Chores successfully saved"
  end
  def print_find(hash_find)
    set_find.each { |task| puts "#{task[1]} " + " #{task[0].all_info}" }
  end
  def print_open
    "Chores successfully recovered"
  end
  private def print_list_all(hash_list)
    puts "all\n"
    set_list.each { |task| puts "#{task[1]}\t" + " #{task[0].all_info}" }
  end
  private def print_list_group(group,hash_list)
    puts "#{group}\n"
    set_list[1].each { |task| puts "#{task[1]}\t" + " #{task[0].all_info}" }
  end
  private def print_list_groups(hash_list)

  end
  def print_question_open
    puts "In order to recover old chores, the new ones will be replaced\nWould you like to continue? Yes/No"
  end
end

#NOTA1: EL EACH DEBERIA ESTAR EN EL MAIN, EL OUTPUT NO DEBERIA TENER LOGICA DEL PROGRAMA!!!!!!!!!!!
#NOTA2: NO OLVIDAR EL CASO CUANDO SE LISTA UN GRUPO DETERMINADO NO SE DEBE LISTAR DICHO GRUPO