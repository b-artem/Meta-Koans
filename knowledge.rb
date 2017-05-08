puts 'Hello!'

class Object
  def attribute(name)
    inst_var = ('@' + name).to_sym
    define_method(name.to_sym) { instance_variable_get(inst_var) }
    define_method((name + '=').to_sym) { |arg| instance_variable_set(inst_var, arg) }
    define_method((name + '?').to_sym) { instance_variable_get(inst_var) ? true : false }
    # puts instance_methods.grep("#{name}")
  end
end

puts 'Bye!'
