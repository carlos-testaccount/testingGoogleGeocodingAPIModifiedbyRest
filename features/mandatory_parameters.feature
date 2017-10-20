@ok
Feature: Cover the happy path case

  Scenario Outline: valid Address
    When I successfully browse to the url
      | parameter | value                                   |
      | address   | <address_value>                         |
      | key       | AIzaSyDLy4-E74lM7BHFgzC189ZhAuAGWl5jcl4 |
    Then I see response with status 'OK'
    And I see first response formatted_address '<formatted_address>'
    And I see first response contains '<location_type>' geographic coordinates

    Examples:
      | address_value                         | formatted_address                                    | location_type    |
      | 88+Colin+P+Kelly+Jr+St,+San+Francisco | 88 Colin P Kelly Jr St, San Francisco, CA 94107, USA | ROOFTOP          |
      | 88 Colin P Kelly Jr St,+San Francisco | 88 Colin P Kelly Jr St, San Francisco, CA 94107, USA | ROOFTOP          |
      | 94107                                 | San Francisco, CA 94107, USA                         | APPROXIMATE      |
      | San Francisco                         | San Francisco, CA, USA                               | APPROXIMATE      |
      | 94107, San Francisco                  | San Francisco, CA 94107, USA                         | APPROXIMATE      |
      | 94107, California                     | San Francisco, CA 94107, USA                         | APPROXIMATE      |
      | Co Road 82                            | County Rd 82 SE, Minnesota, USA                      | GEOMETRIC_CENTER |
      | State 82                              | FL-82, Fort Myers, FL, USA                           | GEOMETRIC_CENTER |
     # | U.S. 101                              | US-101, United States                                | GEOMETRIC_CENTER |
      | Interstate 280                        | I-280, California, USA                               | GEOMETRIC_CENTER |

  Scenario Outline: valid components
    When I successfully browse to the url
      | parameter  | value                                   |
      | components | <components_value>                      |
      | key        | AIzaSyDLy4-E74lM7BHFgzC189ZhAuAGWl5jcl4 |
    Then I see response with status 'OK'
    And I see first response formatted_address '<formatted_address>'
    And I see first response contains '<location_type>' geographic coordinates

    Examples:
      | components_value                                               | formatted_address                         | location_type    |
      | route:Annegatan                                                | Annankatu, 00101 Helsinki, Finland        | GEOMETRIC_CENTER |
      | locality:La Palma                                              | La Palma, CA, USA                         | APPROXIMATE      |
      | administrative_area:Huelva                                     | Huelva, Spain                             | APPROXIMATE      |
      | postal_code:94107                                              | San Francisco, CA 94107, USA              | APPROXIMATE      |
      | country:Spain                                                  | Spain                                     | APPROXIMATE      |
      | locality:La Palma \|country:Spain                              | 30593 La Palma, Murcia, Spain             | APPROXIMATE      |
      | locality:La Palma \|administrative_area:Huelva                 | 21700 La Palma del Condado, Huelva, Spain | APPROXIMATE      |
      | locality:La Palma \|administrative_area:Huelva \|country:Spain | 21700 La Palma del Condado, Huelva, Spain | APPROXIMATE      |

  Scenario: valid Address and components
    When I successfully browse to the url
      | parameter  | value                                         |
      | address    | 6 Mozarabes                                   |
      | components | administrative_area:Huelva\|postal_code:21002 |
      | key        | AIzaSyDLy4-E74lM7BHFgzC189ZhAuAGWl5jcl4       |
    Then I see response with status 'OK'
    And I see first response contains an address_component
      | type                        | attribute  | value  |
      | administrative_area_level_2 | short_name | Huelva |
    And I see first response contains 'ROOFTOP' geographic coordinates

  Scenario: several responses
    When I successfully browse to the url
      | parameter  | value                                   |
      | address    | Calle Real                              |
      | components | country:Spain                           |
      | key        | AIzaSyDLy4-E74lM7BHFgzC189ZhAuAGWl5jcl4 |
    And I see 'GEOMETRIC_CENTER' response contains a formatted_address 'Calle Real, San Sebastián de los Reyes, Madrid, Spain'
    And I see all results contains an address_component
      | type    | attribute  | value |
      | country | short_name | ES    |


