class HashArray < Hash
  attr_accessor :collection

  def initialize
    @collection = Hash.new
  end

  def [](key)
    @collection[key]
  end

  def push(key, value)
    @collection[key] = Array.new unless @collection.key? key
    @collection[key].push(value)
  end
end
