@ok
Feature: Cover the happy path case

  Scenario Outline: valid Address
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
      | Co Road 82                            | Independence Pass, Colorado 81210, USA               | APPROXIMATE      | 1           |
      | State 82                              | FL-82, Fort Myers, FL, USA                           | GEOMETRIC_CENTER | 10          |
      | U.S. 101                              | US-101, United States                                | GEOMETRIC_CENTER | 1           |
      | Interstate 280                        | I-280, California, USA                               | GEOMETRIC_CENTER | 1           |

  Scenario Outline: valid components
    When I successfully browse to the url
      | parameter  | value              |
      | components | <components_value> |
    Then I see response with status 'OK'
    And I see <num_results> result in the response
    And I see first response formatted_address '<formatted_address>'
    And I see first response contains '<location_type>' geographic coordinates

    Examples:
      | components_value                                               | formatted_address                         | location_type    | num_results |
      | route:Annegatan                                                | Annankatu, 00101 Helsinki, Finland        | GEOMETRIC_CENTER | 1           |
      | locality:La Palma                                              | La Palma, CA, USA                         | APPROXIMATE      | 1           |
      | administrative_area:Huelva                                     | Huelva, Spain                             | APPROXIMATE      | 1           |
      | postal_code:94107                                              | San Francisco, CA 94107, USA              | APPROXIMATE      | 1           |
      | country:Spain                                                  | Spain                                     | APPROXIMATE      | 1           |
      | locality:La Palma \|country:Spain                              | 30593 La Palma, Murcia, Spain             | APPROXIMATE      | 2           |
      | locality:La Palma \|administrative_area:Huelva                 | 21700 La Palma del Condado, Huelva, Spain | APPROXIMATE      | 1           |
      | locality:La Palma \|administrative_area:Huelva \|country:Spain | 21700 La Palma del Condado, Huelva, Spain | APPROXIMATE      | 1           |

  Scenario: valid Address and components
    When I successfully browse to the url
      | parameter  | value                                         |
      | address    | 6 Mozarabes                                   |
      | components | administrative_area:Huelva\|postal_code:21002 |
    Then I see response with status 'OK'
    And I see 1 result in the response
    And I see first response contains an address_component
      | type                        | attribute  | value  |
      | administrative_area_level_2 | short_name | Huelva |
    And I see first response contains 'ROOFTOP' geographic coordinates

  Scenario: several responses
    When I successfully browse to the url
      | parameter  | value         |
      | address    | Calle Real    |
      | components | country:Spain |
    And I see 'GEOMETRIC_CENTER' response contains a formatted_address 'Calle Real, San Sebastián de los Reyes, Madrid, Spain'
    And I see all results contains an address_component
      | type    | attribute  | value |
      | country | short_name | ES    |

  Scenario Outline: several address
    When I successfully browse to the url
      | parameter  | value                                     |
      | address    | <address>                                 |
      | components | administrative_area:Huelva\|country:Spain |
    Then I see response with status 'OK'
    And I see 1 result in the response
    And I see first response formatted_address '<formatted_address>'
    And I see first response contains an address_component
      | type                        | attribute  | value  |
      | administrative_area_level_2 | short_name | Huelva |
    And I see first response contains 'GEOMETRIC_CENTER' geographic coordinates

    Examples:
      | address                             | formatted_address                        |
      | calle 6 Mozarabes \| calle puerto   | Calle Puerto, Huelva, Spain              |
      | calle puerto \| calle los mozarabes | Calle los Mozárabes, 21002 Huelva, Spain |

  @carlos
  Scenario: several address
    When I successfully browse to the url
      | parameter  | value                                     |
      | address    | calle 6 Mozarabes                         |
      | address    | calle puerto                              |
      | components | administrative_area:Huelva\|country:Spain |
    Then I see response with status 'OK'
    And I see 1 result in the response
    And I see first response formatted_address 'Huelva, Spain'
    And I see first response contains an address_component
      | type                        | attribute  | value  |
      | administrative_area_level_2 | short_name | Huelva |
    And I see first response contains 'APPROXIMATE' geographic coordinates