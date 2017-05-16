require 'pry'

puts 'Hello!'

class Object

  define_method :attribute do |name, &block|

    class_eval { @attributes ||= {} }

    if name.instance_of?(Hash)
      inst_var = '@' + name.keys[0]
      method_name = name.keys[0]
      class_eval { @attributes[method_name] = name.values[0] }
      define_method(:initialize) do |*args|
        super(*args)
        attrs = self.class.instance_variable_get('@attributes')
        self.class.class_eval { attr_accessor(*attrs.keys) }
        attrs.each do |key, val|
          instance_variable_set('@' + key, val)
        end
      end
    elsif !block.nil? # block_given? false for some reason
      inst_var = '@' + name
      method_name = name
      class_eval { @attributes[method_name] = block }
      define_method(:initialize) do |*args|
        super(*args)
        attrs = self.class.instance_variable_get('@attributes')
        self.class.class_eval { attr_accessor(*attrs.keys) }
        attrs.each do |key, val|
          if val.is_a? Proc
            proc_val = instance_eval(&val)
            instance_variable_set('@' + key, proc_val) # Can I reuse val??????
            next
          end
          instance_variable_set('@' + key, val)
        end
      end
    else
      inst_var = '@' + name
      method_name = name
      class_eval { @attributes[method_name] = nil }
      define_method(:initialize) do |*args|
        super(*args)
        return unless attrs = self.class.instance_variable_get('@attributes')
        self.class.class_eval { attr_accessor(*attrs.keys) }
        attrs.each do |key, val|
          instance_variable_set('@' + key, val)
        end
      end
    end

    attr_accessor method_name
    define_method((method_name + '?').to_sym) { instance_variable_get(inst_var) ? true : false }

    print 'Default values are: '
    puts instance_variable_get(:@attributes)

  end

  def self.inherited(subclass)
    return unless attrs = instance_variable_get(:@attributes)
    puts "#{subclass} inherited from #{self}"

    subclass.class_eval do

      @attributes ||= attrs
      @attributes.each do |key, val|
        if val.is_a? Proc
          proc_val = instance_eval(&val)
          instance_variable_set('@' + key, proc_val)
          next
        end
        instance_variable_set('@' + key, val)
      end

      define_method :initialize do |*args|
        super(*args)
        attrs = self.class.instance_variable_get('@attributes')
        self.class.class_eval { attr_accessor(*attrs.keys) }
        attrs.each do |key, val|
          instance_variable_set('@' + key, val)
        end
      end
      # binding.pry
    end
  end

end

puts 'Bye!'
