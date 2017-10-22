require 'httparty'

def pos_to_int(pos)
  %w[last first second third fourth fifth sixth seventh eigth ninth tenth].index(pos) - 1
end

CAPTURE_POSITION = Transform(/^(last|first|second|third|fourth|fifth|sixth|seventh|eigth|ninth|tenth)$/) do |v|
  pos_to_int(v)
end

When(/^I (successfully|unsuccessfully) browse to the url$/) do |status, table|
  param_options = convert_table_to_hash(table)
  # add key and language into parameters for request
  param_options.store('key', KEY_PASSED) unless param_options.key?('key')
  param_options.store('language', 'EN') unless param_options.key?('language')
  response       = HTTParty.get(URL, query: param_options)
  response_code  = response.code
  @response_body = symb_body_resp(response)

  check_response_code(status, response_code)
end

Then(/^I see response with status '(.*)'$/) do |status|
  expect(resp_status).to eq(status)
end

Then(/^I see response message '(.*)'$/) do |status|
  expect(resp_error_message).to eq(status)
end

Then(/^I see (#{CAPTURE_POSITION}) response contains an address_component$/) do |pos, table|
  table.hashes.each do |row|
    adr = address_com(pos, row['type'])
    expect(adr.short_name).to include(row['value'])
  end
end

Then(/^I see all results contains an address_component$/) do |table|
  table.hashes.each do |row|
    expect(check_in_all_respond(row['type'], row['attribute'], row['value'])).not_to include false
  end
end

Then(/^I (see|don't see) (#{CAPTURE_POSITION}) response contains(?: '(\w+)')? geographic coordinates$/) do |option, pos, location_type|
  if option == 'see'
    expect(geo_coord(pos).key?(:lat)).to be true
    expect(geo_coord(pos).key?(:lng)).to be true
    expect(geo_coord_type(pos)).to eq(location_type)
  else
    expect(result(pos).nil?).to be true
    expect(result(pos).nil?).to be true
  end
end

Then(/^I (see|don't see) (#{CAPTURE_POSITION}) response formatted_address '(.*)'$/) do |option, pos, value|
  if option == 'see'
    expect(formatted_address(pos)).to eq(value)
  else
    pending
  end
end

Then(/^I see '(.*)' response(?:s)? contains a formatted_address '(.*)'$/) do |location_type, value|
  expect(all_form_address(location_type).uniq).to include(value)
end

Then(/^I see (.*) result in the response$/) do |num_result|
  expect(all_results.count).to eq(num_result.to_i)
end

Then(/^I see all results are result_type '(.*)'$/) do |result|
  expect(all_result_types.uniq.count).to eq(1)
  expect(check_type(all_result_types.uniq[0], result)).to be true
end

Then(/^I see all results are location_type '(.*)'$/) do |result|
  expect(all_location_types.uniq.count).to eq(1)
  expect(all_location_types.uniq[0]).to eq result
end

Then(/^I see (#{CAPTURE_POSITION}) results is partial_match$/) do |pos|
  expect(all_parcial_match[pos]).to be true
end
