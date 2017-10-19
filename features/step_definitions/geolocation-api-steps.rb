require 'httparty'
require 'jsonpath'

When /^I (successfully|unsuccessfully) browse to the url$/ do |http_status, table|
  param_options = convertTableToHash(table, 'parameter', 'value')

  @response     = HTTParty.get(URL, query: param_options)
  response_code = @response.code
  #response       = Faraday.get(URL, param_options)
  #response_code  = response.status
  @response_body = symb_body_resp
  #puts @response_body

  check_response_code(http_status, response_code)
end

Then /^I see response with status '(.*)'$/ do |status|
  expect(get_resp_status).to eq(status)
end

Then /^I see response contains an address_component$/ do |table|
  table.hashes.each do |row|
    adr = address_com(row['type'])
    #expect(adr.row['attribute']).to include(value)
    expect(adr.short_name).to include(row['value'])
  end
end