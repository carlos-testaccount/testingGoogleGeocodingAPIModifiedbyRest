@status_code @carlos2
Feature: Cover the happy path case

  Scenario Outline: check body code
    When I <answer> browse to the url
      | parameter  | value                                   |
      | address    | <address_value>                         |
      | components | <component_value>                       |
      | key        | AIzaSyDLy4-E74lM7BHFgzC189ZhAuAGWl5jcl4 |
    Then I see response with status '<status_code>'

    Examples:
      | answer         | address_value   | component_value                             | status_code     |
      | successfully   | 0000000         | empty                                       | ZERO_RESULTS    |
      | successfully   | 6 Los Mozarabes | administrative_area:Lyon\|postal_code:94107 | ZERO_RESULTS    |
      | successfully   | empty           | administrative_area:Lyon\|postal_code:94107 | ZERO_RESULTS    |
      | unsuccessfully | none            | none                                        | INVALID_REQUEST |

  Scenario: check body code
    When I successfully browse to the url
      | parameter | value           |
      | address   | 6 Los Mozarabes |
      | key       | invalid_key     |
    Then I see response with status 'REQUEST_DENIED'

  @performance @pend
  Scenario: check body code
    When I launch 100 requests with
      | parameter | value                                   |
      | address   | 6 Los Mozarabes                         |
      | key       | AIzaSyDLy4-E74lM7BHFgzC189ZhAuAGWl5jcl4 |
    Then I see response with status 'REQUEST_DENIED'

  #codigos
  #OK -> en validos
  #ZERO_RESULTS -> ok
  #OVER_QUERY_LIMITS -> mas de 50 en 1 segundo. Performance!
  #REQUEST_DENIED -> ok
  #INVALID_REQUEST -> ok. with no parameters
  #UNKNOWN_ERROR -??
