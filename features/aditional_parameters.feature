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


  #additional parameters
  #bounds
  #language
  #region


  #codigos
