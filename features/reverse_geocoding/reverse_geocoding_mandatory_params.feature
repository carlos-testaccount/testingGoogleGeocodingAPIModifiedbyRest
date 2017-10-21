@ok
Feature: reverse geolocation

  Scenario: valid latlng
    When I successfully browse to the url
      | parameter | value                          |
      | latlng    | 37.78226710000001,-122.3912479 |
      | language  | EN                             |
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
      | language  | EN                          |
    Then I see response with status 'OK'
    And I see 'ROOFTOP' responses contains a formatted_address '277 Bedford Ave, Brooklyn, NY 11211, USA'
    And I see first response contains 'ROOFTOP' geographic coordinates
    And I see all results contains an address_component
      | type                        | attribute  | value |
      | administrative_area_level_1 | short_name | NY    |
      | country                     | short_name | US    |
