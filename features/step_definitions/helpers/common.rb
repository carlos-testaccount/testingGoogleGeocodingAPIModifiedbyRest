def convert_table_to_hash(table)
  table.rows_hash.delete(table.headers.first)
  # remove when attribute or its value is none
  table.rows_hash.each { |key, value| table.rows_hash.delete(key) if key == 'none' || value == 'none' }
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
