@status_code @ok
  #codigos:
  #OK -> en validos
  #ZERO_RESULTS -> ok
  #OVER_QUERY_LIMITS -> mas de 50 en 1 segundo. Performance!
  #REQUEST_DENIED -> ok
  #INVALID_REQUEST -> ok. with no parameters
  #UNKNOWN_ERROR -??
Feature: Cover the happy path case

  Scenario Outline: check body code
    When I successfully browse to the url
      | parameter  | value                                   |
      | address    | <address_value>                         |
      | components | <component_value>                       |
      | key        | AIzaSyDLy4-E74lM7BHFgzC189ZhAuAGWl5jcl4 |
    Then I see response with status '<status_code>'
    And I don't see first response contains geographic coordinates

    Examples:
      | address_value   | component_value                             | status_code  |
      | 0000000         | empty                                       | ZERO_RESULTS |
      | 6 Los Mozarabes | administrative_area:Lyon\|postal_code:94107 | ZERO_RESULTS |
      | empty           | administrative_area:Lyon\|postal_code:94107 | ZERO_RESULTS |

  Scenario Outline: check body code
    When I unsuccessfully browse to the url
      | parameter         | value                                   |
      | <address_name>    | <address_value>                         |
      | <components_name> | <component_value>                       |
      | key               | AIzaSyDLy4-E74lM7BHFgzC189ZhAuAGWl5jcl4 |
    Then I see response with status '<status_code>'
    And I don't see first response contains geographic coordinates
    And I see response message 'Invalid request. Missing the 'address', 'bounds', 'components', 'latlng' or 'place_id' parameter.'

    Examples:
      | address_name | address_value | components_name | component_value | status_code     |
      | address      | none          | components      | none            | INVALID_REQUEST |
      | addres       | none          | none            | none            | INVALID_REQUEST |
      | none         | none          | none            | none            | INVALID_REQUEST |


  Scenario: check body code
    When I successfully browse to the url
      | parameter | value           |
      | address   | 6 Los Mozarabes |
      | key       | invalid_key     |
    Then I see response with status 'REQUEST_DENIED'



