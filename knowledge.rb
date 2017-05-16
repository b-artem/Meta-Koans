class Object

  define_method :attribute do |name, &block|
    class_eval { @attributes ||= {} }
    if name.instance_of?(Hash)
      attr_name = name.keys[0]
      class_eval { @attributes[attr_name] = name.values[0] }
    elsif !block.nil? # block_given? == false for some reason
      attr_name = name
      class_eval { @attributes[attr_name] = block }
    else
      attr_name = name
    end

    attr_accessor attr_name
    define_method((attr_name + '?')) do
      instance_variable_get('@' + attr_name) ? true : false
    end

    define_method :initialize do
      attrs = self.class.instance_variable_get('@attributes')
      self.class.class_eval { attr_accessor(*attrs.keys) }
      attributes_set(attrs)
    end
  end

  def self.inherited(subclass)
    attributes_inherit(subclass)
  end

end

class Module
  def included(other_class)
    attributes_inherit(other_class)
  end
end

def attributes_inherit(other_class)
  return unless attrs = instance_variable_get(:@attributes)
  other_class.class_eval do
    @attributes = attrs
    attributes_set(attrs)
  end
end

def attributes_set(attrs)
  attrs.each do |name, val|
    val = instance_eval(&val) if val.is_a? Proc
    instance_variable_set('@' + name, val)
  end
end
