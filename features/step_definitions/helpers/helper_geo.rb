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
  @response_body[:status]
end

def resp_error_message
  @response_body[:error_message]
end

def addr_obj_from_result(result)
  result[:address_components].map { |h| AddressComponent.new(h) }
end

def results_json
  @response_body[:results]
end

def num_results
  results_json.count
end

def all_obj_from_json
  results_json.map { |result| addr_obj_from_result(result) }
end

# check if all objets in a response contains an atr:value
def check_in_result(result, type, atr, value)
  addr_obj_from_result(result).map { |adr| return (adr.send atr) == value if adr.types.include? type }.include? true
end

# check if all objets in all responses contains an address objet with type and atr:value
def check_in_all_respond(type, atr, value)
  results_json.map { |result| check_in_result(result, type, atr, value) }.uniq
end

def get_address_obj(pos)
  arry_add_comp = @response_body[:results][pos][:address_components]
  arry_add_comp.map { |h| AddressComponent.new(h) }
end

def geometry
  @response_body[:results][0][:geometry]
end

def address_com(pos, type_value)
  get_address_obj(pos).map { |item| item if check_type(item.types, type_value) }.compact.first
end

def check_type(type, value)
  type.any? { |e| e.include? value }
end

def geo_coord(pos)
  @response_body[:results][pos][:geometry][:location]
end

def geo_coord_type(pos)
  @response_body[:results][pos][:geometry][:location_type]
end

def result_coord(pos = 0)
  @response_body[:results][pos]
end

def formateed_address(pos)
  @response_body[:results][pos][:formatted_address]
end

def check_all_responses_form_addr(location_type)
  @response_body[:results].map { |resp| resp[:formatted_address] if resp[:geometry][:location_type] == location_type }.compact
end
