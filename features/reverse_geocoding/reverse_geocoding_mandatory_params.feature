@ok
Feature: reverse geolocation

  Scenario: valid latlng
    When I successfully browse to the url
      | parameter | value                          |
      | latlng    | 37.78226710000001,-122.3912479 |
    Then I see response with status 'OK'
    And I see 'ROOFTOP' responses contains a formatted_address '88 Colin P Kelly Jr St, San Francisco, CA 94107, USA'
    And I see all results contains an address_component
      | type                        | attribute  | value |
      | administrative_area_level_1 | short_name | CA    |
      | country                     | short_name | US    |

  Scenario: valid place_id
    When I successfully browse to the url
      | parameter | value                       |
      | place_id  | ChIJd8BlQ2BZwokRAFUEcm_qrcA |
    Then I see response with status 'OK'
    And I see 'ROOFTOP' responses contains a formatted_address '277 Bedford Ave, Brooklyn, NY 11211, USA'
    And I see first response contains 'ROOFTOP' geographic coordinates
    And I see all results contains an address_component
      | type                        | attribute  | value |
      | administrative_area_level_1 | short_name | NY    |
      | country                     | short_name | US    |

  Scenario: valid latlng a location_type=ROOFTOP
    When I successfully browse to the url
      | parameter     | value                          |
      | latlng        | 37.78226710000001,-122.3912479 |
      | location_type | ROOFTOP                        |
    Then I see response with status 'OK'
    And I see all results are location_type 'ROOFTOP'
    And I see 'ROOFTOP' responses contains a formatted_address '88 Colin P Kelly Jr St, San Francisco, CA 94107, USA'

  Scenario: valid latlng a location_type=ROOFTOP&result_type=street_address
    When I successfully browse to the url
      | parameter   | value                          |
      | latlng      | 37.78226710000001,-122.3912479 |
      | result_type | street_address                 |
    Then I see response with status 'OK'
    And I see all results are result_type 'street_address'
    And I see 'ROOFTOP' responses contains a formatted_address '88 Colin P Kelly Jr St, San Francisco, CA 94107, USA'