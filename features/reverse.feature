@ok
Feature: reverse geolocation

  Scenario: valid latlng
    When I successfully browse to the url
      | parameter | value                                   |
      | latlng    | 37.78226710000001,-122.3912479          |
      | language  | EN                                      |
      | key       | AIzaSyDLy4-E74lM7BHFgzC189ZhAuAGWl5jcl4 |
    Then I see response with status 'OK'
    And I see 'ROOFTOP' responses contains a formatted_address '88 Colin P Kelly Jr St, San Francisco, CA 94107, USA'
    And I see all results contains an address_component
      | type                        | attribute  | value |
      | administrative_area_level_1 | short_name | CA    |
      | country                     | short_name | US    |

  Scenario: valid place_id
    When I successfully browse to the url
      | parameter | value                                   |
      | place_id  | ChIJd8BlQ2BZwokRAFUEcm_qrcA             |
      | language  | EN                                      |
      | key       | AIzaSyDLy4-E74lM7BHFgzC189ZhAuAGWl5jcl4 |
    Then I see response with status 'OK'
    And I see 'ROOFTOP' responses contains a formatted_address '277 Bedford Ave, Brooklyn, NY 11211, USA'
    And I see first response contains 'ROOFTOP' geographic coordinates
    And I see all results contains an address_component
      | type                        | attribute  | value |
      | administrative_area_level_1 | short_name | NY    |
      | country                     | short_name | US    |

  Scenario Outline: TBD invalid latlng
    When I unsuccessfully browse to the url
      | parameter | value                                   |
      | latlng    | <lat>,<lng>                             |
      | language  | EN                                      |
      | key       | AIzaSyDLy4-E74lM7BHFgzC189ZhAuAGWl5jcl4 |
    Then I see response with status 'INVALID_REQUEST'
    And I see response message 'Invalid request. Invalid 'latlng' parameter.'

    Examples:
      | lat                | lng            |
      | 37.78226710000001N | -122.3912479N  |
      | 37.78226710000001$ | -122.3912479N$ |
      | 37.78226710000001& | -122.3912479   |
      | AAA                | -122.3912479   |
      | 37.78226710000001  | AAB            |
      | N37.78226710000001 | -122.3912479N  |

  Scenario Outline: TBD invalid place_id
    When I unsuccessfully browse to the url
      | parameter | value                                   |
      | place_id  | <place_id>                              |
      | language  | EN                                      |
      | key       | AIzaSyDLy4-E74lM7BHFgzC189ZhAuAGWl5jcl4 |
    Then I see response with status 'INVALID_REQUEST'
    And I see response message 'Invalid request. Invalid 'place_id' parameter.'

    Examples:
      | place_id                       |
      | Invalid                        |
      | Invalid Placce Id              |
      | AAAChIJd8BlQ2BZwokRAFUEcm_qrcA |

    #ZERO_RESULTS?