module AttributeMaker
  def self.included(klass)
    klass.extend ClassMethods
  end
 
  module ClassMethods
    def attributes(*args)
      args.flatten.each do |attribute|
        puts "attribute: #{attribute}"

        define_method attribute do
          attributes[attribute]
        end

        define_method "#{attribute}=" do |value|
          attributes[attribute] = value
        end
      end
    end

    def create(args={})
      instance = new(args)
      instances.push(instance)
      instance
    end

    def find_by(attribute, value)
      found = []
      instances.each do |instance|
        if instance.attributes[attribute] == value
          found.push(instance)
        end
      end
      return found
    end

    def instances
      @instances ||= []
    end
  end

  def attributes
    @attributes ||= {}
  end

  def to_s
    "<#{self.class.to_s}: #{attributes.inspect}>"
  end

  def initialize(attrs={})
    attrs.each do |key, value|
      attributes[key] = value
    end
  end
end

class User
  include AttributeMaker

  attributes :first_name, :last_name
end
