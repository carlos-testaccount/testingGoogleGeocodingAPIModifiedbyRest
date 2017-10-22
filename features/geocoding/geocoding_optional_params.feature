Feature: Check aditional params

  Scenario: bounds additional parameters
    When I successfully browse to the url
      | parameter | value                                       |
      | address   | Los Mozarabes                               |
      | bounds    | 37.2605085,-6.9558192\|37.2596631,-6.958557 |
    Then I see response with status 'OK'
    And I see 2 result in the response
    And I see all results contains an address_component
      | type    | attribute  | value |
      | country | short_name | ES    |

  Scenario Outline: language additional parameters
    When I successfully browse to the url
      | parameter | value      |
      | address   | London     |
      | language  | <language> |
    Then I see response with status 'OK'
    And I see 1 result in the response
    And I see first response formatted_address '<formatted_address>'

    Examples:
      | language | formatted_address    |
      | EN       | London, UK           |
      | ES       | Londres, Reino Unido |
      | IT       | Londra, Regno Unito  |
      | PT       | Londres, Reino Unido |
      | FR       | Londres, Royaume-Uni |

  Scenario: region additional parameters
    When I successfully browse to the url
      | parameter | value  |
      | address   | Huelva |
      | region    | es     |
    Then I see response with status 'OK'
    And I see 1 result in the response
    And I see first response formatted_address 'Huelva, Spain'
    And I see first response contains 'APPROXIMATE' geographic coordinates