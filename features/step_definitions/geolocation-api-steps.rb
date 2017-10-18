require 'httparty'
#require 'typhoeus'
#require 'typhoeus/adapters/faraday'

When /^I (successfully|unsuccessfully) browse to the url$/ do |http_status, table|
  param_options = convertTableToHash(table, 'parameter', 'value')

  #response       = HTTParty.get(URL, query: param_options)
  #response_code  = response.code
  response       = Faraday.get(URL, param_options)
  response_code  = response.status
  @response_body = parse_body_response(response)
  #puts @response_body

  check_response_code(http_status, response_code)
end

Then /^I see response with status '(.*)'$/ do |status|
  expect(get_resp_status).to eq(status)
end


# When /^I launch (\d+) requests with$/ do |request_num, table|
#   param_options = convertTableToHash(table, 'parameter', 'value')
#   manager = Typhoeus::Hydra.new(:max_concurrency => 10)
#
#   Typhoeus.configure do |config|
#     config.memoize = false
#   end
#
#   responses = []
#
#   conn = Faraday.new(:url => URL, :parallel_manager => manager) do |faraday|
#     faraday.adapter :typhoeus
#   end
#
#   conn.in_parallel(manager) do
#     request_num.to_i.times do responses << conn.get(URL, param_options) end
#     #responses << conn.get(URL, param_options)
#   end
#   sleep(1)
# end