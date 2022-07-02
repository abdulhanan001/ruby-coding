class Serializer
  @@attrs = []

  def initialize(object)
    @@object = object
  end

  def serialize
    result = {}

    @@attrs.each do |attr|
      result[attr] = @@object.send(attr) if attr.is_a? Symbol
      result[attr[:key]] = attr[:block].call if attr.is_a? Hash
    end

    result
  end

  def self.object
    @@object
  end

  def self.attribute(attr, &block)
    return @@attrs << attr unless block_given?

    @@attrs << { key: attr, block: block }
  end
end
