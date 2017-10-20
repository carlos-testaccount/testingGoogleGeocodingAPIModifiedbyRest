def check_response_code(status, response_code)
  if status == 'successfully'
    expect(response_code).to eq(200)
    #get_address_com(symb_body_resp) unless result_coord.nil?
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

def get_resp_error_message
  symb_body_resp[:error_message]
end

def get_adr_obj_from_result(result)
  result[:address_components].map { |h| Address_component.new(h) }
end

def get_resultados_json
  symb_body_resp[:results]
end

def get_all_obj_from_json
  get_resultados_json.map { |result| get_adr_obj_from_result(result) }
end

def check_all_adr_obj(atr, value)
  get_all_obj_from_json.map { |result|}
end

#check if all objets in a response contains an atr:value
def check_result_adr_obj(result, type, atr, value)
  #get_adr_obj_from_result(result).map { |adr| return (adr.send atr) == value if adr.types.include? type }.include? true
  get_adr_obj_from_result(result).map { |adr| return (adr.send atr) == value if adr.types.include? type }.include? true
end


#check if all objets in all responses contains an address objet with type and atr:value
def check_result_obj(type, atr, value)
  get_resultados_json.map { |result| check_result_adr_obj(result, type, atr, value) }
end





def get_address_com(pos)
  arry_add_comp = symb_body_resp[:results][pos][:address_components]
  @add_comp     = arry_add_comp.map { |h| Address_component.new(h) }
end

#TBD
def geometry
  symb_body_resp[:results][0][:geometry]
end

def all_address_obj
  symb_body_resp[:results].map { |result| result[:address_components] }
end

def get_addr(response, atrr, type)
  response.map { |adr| adr[:atrr] if adr[:short_name] == 'CA' }.compact
end

def address_com(pos, type_value)
  get_address_com(pos)
  @add_comp.map { |item| item if check_type(item.types, type_value) }.compact.first
end

def check_type(type, value)
  type.any? { |e| e.include? value }
end

def geo_coord(pos)
  symb_body_resp[:results][pos][:geometry][:location]
end

def geo_coord_type(pos)
  symb_body_resp[:results][pos][:geometry][:location_type]
end

def result_coord(pos = 0)
  symb_body_resp[:results][pos]
end

def formateed_address(pos)
  symb_body_resp[:results][pos][:formatted_address]
end