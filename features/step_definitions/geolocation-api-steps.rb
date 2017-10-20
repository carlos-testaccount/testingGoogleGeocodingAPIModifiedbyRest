require 'httparty'
require 'jsonpath'

def toInt(position)
  return %w(last first second third fourth fifth sixth seventh eigth ninth tenth).index(position) - 1
end

CAPTURE_POSITION = Transform(/^(last|first|second|third|fourth|fifth|sixth|seventh|eigth|ninth|tenth)$/) do |v|
  toInt(v)
end

When /^I (successfully|unsuccessfully) browse to the url$/ do |status, table|
  param_options = convertTableToHash(table, 'parameter', 'value')

  @response     = HTTParty.get(URL, query: param_options)
  response_code = @response.code
  #response       = Faraday.get(URL, param_options)
  #response_code  = response.status
  @response_body = symb_body_resp
  #puts @response_body

  check_response_code(status, response_code)
end

Then /^I see response with status '(.*)'$/ do |status|
  expect(get_resp_status).to eq(status)
end

Then /^I see response message '(.*)'$/ do |status|
  expect(get_resp_error_message).to eq(status)
end

Then /^I see (#{CAPTURE_POSITION}) response contains an address_component$/ do |pos, table|
  table.hashes.each do |row|
    adr = address_com(pos, row['type'])
    expect(adr.short_name).to include(row['value'])
  end
end

Then /^I see all results contains an address_component$/ do |table|
  table.hashes.each do |row|
    puts check_result_obj(row['type'], row['attribute'], row['value'])
    expect(check_result_obj(row['type'], row['attribute'], row['value']).include? false).to be false
  end
end

Then /^I (see|don't see) (#{CAPTURE_POSITION}) response contains(?: '(\w+)')? geographic coordinates$/ do |option, pos, location_type|
  if option == 'see'
    expect(geo_coord(pos).key?(:lat)).to be true
    expect(geo_coord(pos).key?(:lng)).to be true
    expect(geo_coord_type(pos)).to eq(location_type)
  else
    expect(result_coord(pos).nil?).to be true
    expect(result_coord(pos).nil?).to be true
  end
end

Then /^I (see|don't see) (#{CAPTURE_POSITION}) response formatted_address '(.*)'$/ do |option, pos, value|
  if option == 'see'
    expect(formateed_address(pos)).to eq(value)
  else
    pending
  end
end

def num_results
  symb_body_resp[:results].count
end

Then /^I see '(.*)' response(?:s)? contains a formatted_address '(.*)'$/ do |location_type, value|
  all_formateed_address = symb_body_resp[:results].map { |resp| resp[:formatted_address] if resp[:geometry][:location_type] == location_type }.compact
  expect(all_formateed_address).to include(value)
end