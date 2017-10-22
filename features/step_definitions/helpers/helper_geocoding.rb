def check_response_code(status, response_code)
  if status == 'successfully'
    expect(response_code).to eq(200)
  else
    expect(response_code).not_to eq(200)
  end
end

def symb_body_resp(response)
  JSON.parse(response.body, symbolize_names: true)
end

def resp_status
  response_atr(:status)
end

def resp_error_message
  response_atr(:error_message)
end

# check if all objets in a response contains an atr:value
def check_in_result(result, type, atr, value)
  addr_obj_from_result(result).map { |adr| return (adr.send atr).casecmp(value).zero? if adr.types.include? type }.include? true
end

def get_address_obj(pos)
  arry_add_comp = result(pos)[:address_components]
  arry_add_comp.map { |h| AddressComponent.new(h) }
end

def address_com(pos, type_value)
  get_address_obj(pos).map { |item| item if check_type(item.types, type_value) }.compact.first
end

def geo_coord_type(pos)
  all_location_types[pos]
end

def result(pos)
  all_results[pos]
end

def formatted_address(pos)
  result(pos)[:formatted_address]
end

def geo_coord(pos)
  check_in_all_results(:geometry)[pos][:location]
end

def location_type(result)
  result[:geometry][:location_type]
end

##### All ####

def all_results
  response_atr(:results)
end

def all_form_address(location_type)
  all_results.map { |rslt| rslt[:formatted_address] if location_type(rslt).casecmp(location_type).zero? }
end

def all_result_types
  check_in_all_results(:types)
end

def all_location_types
  all_results.map { |result| location_type(result) }
end

def all_parcial_match
  check_in_all_results(:partial_match)
end

# check if all objets in all responses contains an address objet with type and atr:value
def check_in_all_respond(type, atr, value)
  all_results.map { |result| check_in_result(result, type, atr, value) }.uniq
end
