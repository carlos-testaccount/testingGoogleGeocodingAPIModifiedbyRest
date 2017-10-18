def check_response_code(error)
  expect([200, 400]).to contains(response_code)
end

def parse_body_response(response)
  JSON.parse(response.body, object_class: OpenStruct)
end

def get_resp_status
  @response_body.status
end

def convertTableToHash(table, key, value)
  returnValue = {}
  table.hashes.each_with_object(returnValue) do |row, result|
    filterName  = row[key.to_sym]
    filterValue = row[value.to_sym]

    # skip if filter name is nil or empty
    next if filterName.to_s.strip.length == 0

    unless filterValue == 'none'
      if result.has_key?(filterName)
        tmp = result[filterName];
        if (tmp.kind_of?(Array))
          tmp.push(filterValue);
        else
          tmp = [tmp, filterValue];
          result[filterName] = tmp;
        end
      else
        result[filterName] = filterValue;
      end
    end
  end

  returnValue
end

def check_response_code(status, response_code)
  if status == 'successfully'
    expect(response_code).to eq(200)
  else
    expect(response_code).not_to eq(200)
  end
end