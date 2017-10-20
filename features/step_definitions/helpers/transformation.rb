def convertTableToHash(table, key, value)
  returnValue = {}
  table.hashes.each_with_object(returnValue) do |row, result|
    filterName  = row[key.to_sym]
    filterValue = row[value.to_sym]

    # skip if filter name is nil or empty
    next if filterName.to_s.strip.length == 0

    unless filterName == 'none'
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
  end

  returnValue
end