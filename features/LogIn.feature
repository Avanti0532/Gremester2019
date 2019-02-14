Feature: Allow students, faculties and admins to login

  Background: I am on the homepage of Gremester
    Given the following students have been added to Student Database:
      | first_name  | last_name  | email          | password  | username          |
      | Robin       | Hood       | robin@gmail.com  | 123456    |   robin_hood      |
      | Thomas      | Edison     | thomas@gmail.com  | 234567    |   thomas_edison   |
      | Frank       | Robert     | frank@gmail.com | 345678    |   frank_robert    |

    And the following faculties have been added to Faculty Database:
      | first_name  | last_name   | email             | password    |   username          | weblink |
      | Alice       | May         | alicen@uiowa.edu  | 12345689    |   alice_may         | http://homepage.cs.uiowa.edu/~alicem/ |
      | Lily        | Edison      | lilys@uiowa.edu   | 23456789    |   lily12            | http://homepage.cs.uiowa.edu/~lily12/ |
      | Hazel       | Robert      | hazel@uiowa.edu   | 34567890    |   hazel_robert      | http://homepage.cs.uiowa.edu/~hzel/ |

    And the following admins have been added to Admin Database:
      | first_name  | last_name   | email             | password    |   username         |
      | Linh        | Pham         | linh@gmail.com    | 12345689    |   linh_pham       |
      | Jordan        | Peterson      | jordan@gmail.com   | 23456789    |   lily12      |

  Scenario: Student logs in with valid credentials
    When I log in with valid student credentials
    Then I should see a successful login message

  Scenario: Faculty logs in with valid credentials
    When I log in with valid faculty credentials
    Then I should see a successful login message

  Scenario: Admin logs in with valid credentials
    When I log in with valid admin credentials
    Then I should see a successful login message

  Scenario: Student logs in with wrong email
    When I log in with wrong student email
    Then I should see an invalid login message

  Scenario: Faculty logs in with wrong email
    When I log in with wrong faculty email
    Then I should see an invalid login message

  Scenario: Admin logs in with wrong email
    When I log in with wrong admin email
    Then I should see an invalid login message

  Scenario: Student logs in with wrong password
    When I log in with wrong student password
    Then I should see an invalid login message

  Scenario: Faculty logs in with wrong password
    When I log in with wrong faculty password
    Then I should see an invalid login message

  Scenario: Admin logs in with wrong password
    When I log in with wrong admin password
    Then I should see an invalid login message

  Scenario: Only one user can log in at one time
    When I log in with valid student credentials
    Then I cannot try to log into another account before signing out