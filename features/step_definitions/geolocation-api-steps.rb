require 'httparty'

When /^I successfully browse to the url$/ do |table|
  param_options = convertTableToHash(table, 'parameter', 'value')

  #param_options = Hash[*table.transpose.hashes.flatten]
  #param_options.delete('parameter')
  ####puts param_options

  response       = HTTParty.get(URL, query: param_options)
  response_code  = response.code
  @response_body = parse_body_response(response)
  #puts @response_body
  should_be_successful(response_code)
end

Then /^I see response with status '(.*)'$/ do |status|
  ####puts get_resp_status
  expect(get_resp_status).to eq(status)
end
