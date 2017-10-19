@valid
Feature: Cover the happy path case

  Scenario Outline: valid Address
    When I successfully browse to the url
      | parameter | value                                   |
      | address   | <address_value>                         |
      | key       | AIzaSyDLy4-E74lM7BHFgzC189ZhAuAGWl5jcl4 |
    Then I see response with status 'OK'

    Examples:
      | address_value                         |
      | 88+Colin+P+Kelly+Jr+St,+San+Francisco |
      | 88 Colin P Kelly Jr St,+San Francisco |
      | 94107                                 |
      | San Francisco                         |
      | 94107, San Francisco                  |
      | 94107, California                     |
      | Co Road 82                            |
      | State 82                              |
      | U.S. 101                              |
      | Interstate 280                        |

  Scenario Outline: valid components
    When I successfully browse to the url
      | parameter  | value                                   |
      | components | <components_value>                      |
      | key        | AIzaSyDLy4-E74lM7BHFgzC189ZhAuAGWl5jcl4 |
    Then I see response with status 'OK'

    Examples:
      | components_value                                               |
      | route:Annegatan                                                |
      | locality:La Palma                                              |
      | administrative_area:Huelva                                     |
      | postal_code:94107                                              |
      | country:Spain                                                  |
      | locality:La Palma \|country:Spain                              |
      | locality:La Palma \|administrative_area:Huelva                 |
      | locality:La Palma \|administrative_area:Huelva \|country:Spain |

  @carlos
  Scenario: valid Address and components
    When I successfully browse to the url
      | parameter  | value                                         |
      | address    | 6 Mozarabes                                   |
      | components | administrative_area:Huelva\|postal_code:21002 |
      | key        | AIzaSyDLy4-E74lM7BHFgzC189ZhAuAGWl5jcl4       |
    Then I see response with status 'OK'
    And I see response contains an address_component
      | type                        | attribute  | value  |
      | administrative_area_level_2 | short_name | Huelva |


