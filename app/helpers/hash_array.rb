class HashArray
  extend Forwardable
  attr_reader :hash
  
  def_delegator :@hash, :[], :[]

  def initialize
    @hash = Hash.new
  end

  def push(key, value)
    @hash[key] = Array.new unless @hash.key? key
    @hash[key].push(value)
  end
end
