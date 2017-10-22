@component @geocoding
Feature: Cover the geocoding when component is used as parameter

  Scenario Outline: Check geocoding response with valid components
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

  Scenario: Check geocoding response with an address and multi component
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

  Scenario Outline: Check geocoding response with multi address and multi component
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

    Examples:
      | address                             | formatted_address                        |
      | calle 6 Mozarabes \| calle puerto   | Calle Puerto, Huelva, Spain              |
      | calle puerto \| calle los mozarabes | Calle los Mozárabes, 21002 Huelva, Spain |
