@ok
Feature: reverse geolocation

  Scenario Outline: TBD invalid latlng
    When I unsuccessfully browse to the url
      | parameter | value       |
      | latlng    | <lat>,<lng> |
      | language  | EN          |
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
      | parameter | value      |
      | place_id  | <place_id> |
      | language  | EN         |
    Then I see response with status 'INVALID_REQUEST'
    And I see response message 'Invalid request. Invalid 'place_id' parameter.'

    Examples:
      | place_id                       |
      | Invalid                        |
      | Invalid Placce Id              |
      | AAAChIJd8BlQ2BZwokRAFUEcm_qrcA |