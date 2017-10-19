class Address_component
  attr_accessor :long_name
  attr_accessor :short_name
  attr_accessor :types

  def initialize(hash)
    @long_name, @short_name, @types = hash.values_at(:long_name, :short_name, :types)
  end

end