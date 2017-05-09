gem 'byebug'

puts 'Hello!'

class Object
  def attribute(name, &block)
    puts name

    if name.instance_of?(Hash)
      inst_var = ('@' + name.keys[0]).to_sym
      method_name = name.keys[0]
      define_method(:initialize) do |*args|
        super(*args)
        instance_variable_set(inst_var, name.values[0])
      end
    else
      inst_var = ('@' + name).to_sym
      method_name = name
    end

    define_method(method_name.to_sym) { instance_variable_get(inst_var) }
    define_method((method_name + '=').to_sym) { |arg| instance_variable_set(inst_var, arg) }
    define_method((method_name + '?').to_sym) { instance_variable_get(inst_var) ? true : false }

    instance_eval(&block) if block_given?
    # puts instance_methods.grep("/#{name}/")
    # byebug

  end
end

puts 'Bye!'
