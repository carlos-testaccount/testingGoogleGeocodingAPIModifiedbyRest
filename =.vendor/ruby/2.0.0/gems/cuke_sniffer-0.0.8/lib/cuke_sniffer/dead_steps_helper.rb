module CukeSniffer
  # Author::    Robert Cochran  (mailto:cochrarj@miamioh.edu)
  # Copyright:: Copyright (C) 2014 Robert Cochran
  # License::   Distributes under the MIT License
  # Mixins: CukeSniffer::Constants
  # A static class to aid in the identification of dead steps.
  class DeadStepsHelper
    include CukeSniffer::Constants

    # Returns a hash of dead steps for displaying in the html.
    def self.build_dead_steps_hash(step_definitions)
      dead_steps_hash = gather_all_dead_steps_by_file(step_definitions)
      sort_dead_steps_in_file!(dead_steps_hash)
      dead_steps_hash[:total] = count_dead_steps(dead_steps_hash)
      dead_steps_hash
    end

    # Returns all dead step definitions in a file
    def self.gather_all_dead_steps_by_file(step_definitions)
      dead_steps_hash = {}
      step_definitions.each do |step_definition|
        location_match = step_definition.location.match(/(?<file>.*).rb:(?<line>\d+)/)
        file_name = location_match[:file]
        regex = format_step_definition_regex(step_definition.regex)
        if step_definition.calls.empty?
          dead_steps_hash[file_name] ||= []
          dead_steps_hash[file_name] << "#{location_match[:line]}: /#{regex}/"
        end
      end
      dead_steps_hash
    end

    # Formats the regex of a step definition to remove the (?-mix) part of the to_s
    def self.format_step_definition_regex(regex)
      regex.to_s.match(/\(\?\-mix\:(?<regex>.*)\)/)[:regex]
    end

    # Sorts the dead steps found in a hash by the line number in the file
    def self.sort_dead_steps_in_file!(dead_steps_hash)
      dead_steps_hash.each_key do |file|
        dead_steps_hash[file].sort_by! { |row| row[/^\d+/].to_i }
      end
    end

    # Returns the count of all possible dead steps in each file
    def self.count_dead_steps(dead_steps_hash)
      count = 0
      dead_steps_hash.each_value do |dead_steps_in_file_list|
        count += dead_steps_in_file_list.size
      end
      count
    end
  end
end