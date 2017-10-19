def check_response_code(status, response_code)
  if status == 'successfully'
    expect(response_code).to eq(200)
    get_address_com(symb_body_resp)
  else
    expect(response_code).not_to eq(200)
  end
end

def symb_body_resp
  JSON.parse(@response.body, {symbolize_names: true})
end

def get_resp_status
  symb_body_resp[:status]
end

def get_address_com(resp_syb)
  arry_add_comp = resp_syb[:results][0][:address_components]
  @add_comp     = arry_add_comp.map { |h| Address_component.new(h) }
end

#TBD
def geometry
  symb_body_resp[:results][0][:geometry]
end

def address_com(type_value)
  #@add_comp.map {|item| item."#{field}"}
  #@add_comp.map { |item| item if item.types.include?(type_value) }.compact.first
  @add_comp.map { |item| item if check_type(item.types, type_value) }.compact.first

  #@add_comp[0].types.select { |str| str.include?('casa') }
  #@add_comp.map { |item| item if item.field.include?(value) }.compact.first
end

def check_type(type, value)
  type.any? {|e| e.include? value}
end