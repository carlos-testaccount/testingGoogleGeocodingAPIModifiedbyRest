def convertTableToHash(table, key, value)
  returnValue = {}
  table.hashes.each_with_object(returnValue) do |row, result|
    filterName  = row[key.to_sym]
    filterValue = row[value.to_sym]

    # skip if filter name is nil or empty
    next if filterName.to_s.strip.length == 0

    unless filterName == 'none'
      unless filterValue == 'none'
        if result.key?(filterName)
          tmp = result[filterName]
          if tmp.is_a?(Array)
            tmp.push(filterValue)
          else
            tmp = [tmp, filterValue]
            result[filterName] = tmp
          end
        else
          result[filterName] = filterValue
        end
      end
    end
  end

  returnValue
end

def check_type(type, value)
  type.any? { |e| e.include? value }
end

def check_in_all_results(atr)
  all_results.map { |resp| resp[atr] }
end

def response_atr(atr)
  @response_body[atr]
end