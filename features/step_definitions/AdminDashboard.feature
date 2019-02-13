Feature: Admin can look at all user but cannot edit their information

  Background: I am on the Welcome to Gremester page
    Given the following students have been added to Student Database:
      | first_name  | last_name  | email          | password  | username          |
      | Robin       | Hood       | robin@gmail.com  | 123456    |   robin_hood      |
      | Thomas      | Edison     | thomas@gmail.com  | 234567    |   thomas_edison   |
      | Frank       | Robert     | frank@gmail.com | 345678    |   frank_robert    |

    And the following faculties have been added to Faculty Database:
      | first_name  | last_name   | email             | password    |   username          | weblink |
      | Alice       | May         | alicen@uiowa.edu  | 12345689    |   alice_may         | alice@uiowa.edu |
      | Lily        | Edison      | lilys@uiowa.edu   | 23456789    |   lily12            | lily@uiowa.edu |
      | Hazel       | Robert      | hazel@uiowa.edu   | 34567890    |   hazel_robert      | hazel@uiowa.edu |

    And the following admins have been added to Admin Database:
      | first_name  | last_name   | email             | password    |   username         |
      | Linh        | Pham         | linh@gmail.com    | 12345689    |   linh_pham       |
      | Jordan        | Peterson      | jordan@gmail.com   | 23456789    |   lily12      |

  Scenario: Admin can see all faculties in the database
    When I log in as an admin
    Then I can see all faculties in the database

  Scenario: Admin can see all students in the database
    When I log in as an admin
    Then I can see all students in the database

  Scenario: Admin cannot edit any student or faculty information
    When I log in as an admin
    Then I cannot edit any student or faculty information

  Scenario: Admin can add approve faculty
    When I log in as an admin
    Then I can approve faculty credential

  Scenario: Admin cannot add a new faculty or student
    When I log in as an admin
    Then I cannot add new faculty or student

  Scenario: Admin will be directed to dashboard when they signs in
    When I log in as an admin
    Then  I should be directed to the admin site

  Scenario: Admin can create other admin for the application
    When I log in as an admin
    Then I can create account for another admin

  Scenario: Admin can open weblink to validate faculty's credential
    When I log in as an admin
    Then I can open weblink to validate faculty's credential


