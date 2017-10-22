@address @geocoding
Feature: Cover the geocoding when address is used as parameter

  Scenario Outline: Check geocoding response with a valid address
    When I successfully browse to the url
      | parameter | value           |
      | address   | <address_value> |
    Then I see response with status 'OK'
    And I see <num_results> result in the response
    And I see first response formatted_address '<formatted_address>'
    And I see first response contains '<location_type>' geographic coordinates

    Examples:
      | address_value                         | formatted_address                                    | location_type    | num_results |
      | 88+Colin+P+Kelly+Jr+St,+San+Francisco | 88 Colin P Kelly Jr St, San Francisco, CA 94107, USA | ROOFTOP          | 1           |
      | 88 Colin P Kelly Jr St,+San Francisco | 88 Colin P Kelly Jr St, San Francisco, CA 94107, USA | ROOFTOP          | 1           |
      | 94107                                 | San Francisco, CA 94107, USA                         | APPROXIMATE      | 1           |
      | San Francisco                         | San Francisco, CA, USA                               | APPROXIMATE      | 1           |
      | 94107, San Francisco                  | San Francisco, CA 94107, USA                         | APPROXIMATE      | 1           |
      | 94107, California                     | San Francisco, CA 94107, USA                         | APPROXIMATE      | 1           |
      | Co Road 182                           | Co Rd 182, Bennett, CO 80102, USA                    | GEOMETRIC_CENTER | 9           |
      | Andalucia                             | Andalusia, Spain                                     | APPROXIMATE      | 1           |
      | Spain A42                             | A-42, Spain                                          | GEOMETRIC_CENTER | 1           |
      | Interstate 280                        | I-280, California, USA                               | GEOMETRIC_CENTER | 1           |

  Scenario: Check geocoding response with valid address and component
    When I successfully browse to the url
      | parameter  | value         |
      | address    | Calle Real    |
      | components | country:Spain |
    And I see 'GEOMETRIC_CENTER' response contains a formatted_address 'Calle Real, San Sebastián de los Reyes, Madrid, Spain'
    And I see all results contains an address_component
      | type    | attribute  | value |
      | country | short_name | ES    |

  Scenario: Check geocoding response with multi address
    When I successfully browse to the url
      | parameter  | value                                     |
      | address    | calle 6 Mozarabes                         |
      | address    | calle puerto                              |
      | components | administrative_area:Huelva\|country:Spain |
    Then I see response with status 'OK'
    And I see 1 result in the response
    And I see first response formatted_address 'Calle Puerto, Huelva, Spain'
    And I see first response contains an address_component
      | type                        | attribute  | value  |
      | administrative_area_level_2 | short_name | Huelva |

  Scenario: Check geocoding response with a address and region additional parameters
    When I successfully browse to the url
      | parameter  | value                                     |
      | address    | 1025 Los Mozarabes                        |
      | components | administrative_area:Huelva\|country:Spain |
    Then I see response with status 'OK'
    And I see 1 result in the response
    And I see first results is partial_match
    And I see first response formatted_address 'Calle los Mozárabes, 21002 Huelva, Spain'
