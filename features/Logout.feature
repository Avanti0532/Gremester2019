Feature: Allow students, faculties or admin to log out

  Background: User is logged in
    Given the following students have been added to Student Database:
      | first_name  | last_name  | email          | password  | username          |
      | Robin       | Hood       | robin@gmail.com  | 12345678    |   robin_hood      |
      | Thomas      | Edison     | thomas@gmail.com  | 23456789    |   thomas_edison   |
      | Frank       | Robert     | frank@gmail.com | 34567890    |   frank_robert    |

    And the following faculties have been added to Faculty Database:
      | first_name  | last_name   | email             | password    |   username          | weblink |
      | Alice       | May         | alicen@uiowa.edu  | 12345689    |   alice_may         | http://homepage.cs.uiowa.edu/~alicem/ |
      | Lily        | Edison      | lilys@uiowa.edu   | 23456789    |   lily12            | http://homepage.cs.uiowa.edu/~lily12/ |
      | Hazel       | Robert      | hazel@uiowa.edu   | 34567890    |   hazel_robert      | http://homepage.cs.uiowa.edu/~hzel/ |

    And the following admins have been added to Admin Database:
      | first_name  | last_name   | email             | password    | password_confirmation |
      | Linh        | Pham         | linh@gmail.com    | 12345689    |  12345689            |
      | Jordan        | Peterson      | jordan@gmail.com   | 23456789    | 23456789         |

  Scenario: Student logs out
    When I log in as a student
    And I click on log out
    Then I should see a sign out message
    And I should see a log in button

  Scenario: Faculty logs out
    When I log in as a faculty
    And I click on log out
    Then I should see a sign out message
    And I should see a log in button

  Scenario: Admin logs out
    When I log in as an admin
    And I click on log out
    Then I should be directed to homepage
    And I should see a log in button
