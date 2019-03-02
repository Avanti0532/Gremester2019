Feature: Admin can look at all user but cannot edit their information

  Background: I am on the Welcome to Gremester page
    Given the following students have been added to Student Database:
      | first_name  | last_name  | email          | password  | username                | id |
      | Robin       | Hood       | robin@gmail.com  | 12345678    |   robin_hood        | 1  |
      | Thomas      | Edison     | thomas@gmail.com  | 23456789    |   thomas_edison    | 2  |
      | Frank       | Robert     | frank@gmail.com | 34567890    |   frank_robert       | 3  |

    And the following faculties have been added to Faculty Database:
      | first_name  | last_name   | email             | password    |   username          | weblink |
      | Alice       | May         | alicen@uiowa.edu  | 12345689    |   alice_may         | http://homepage.cs.uiowa.edu/~alicem/ |
      | Lily        | Edison      | lilys@uiowa.edu   | 23456789    |   lily12            | http://homepage.cs.uiowa.edu/~lily12/ |
      | Hazel       | Robert      | hazel@uiowa.edu   | 34567890    |   hazel_robert      | http://homepage.cs.uiowa.edu/~hzel/ |

    And the following admins have been added to Admin Database:
      | first_name  | last_name   | email             | password    | password_confirmation |
      | Linh        | Pham         | linh@gmail.com    | 12345689    |  12345689            |
      | Jordan        | Peterson      | jordan@gmail.com   | 23456789    | 23456789         |

    And the following profiles have been added to Profile Database:
      | student_id    | cgpa   | toefl   | gre_writing    |   gre_verbal  | gre_quant | interested_term | interested_major | college   | year_work_exp | month_work_exp | resume_data | sop_data | additional_attachment_data |
      | 1             | 3.0    | 100     | 5.0            |   140         | 130       | fall            | Computer Science | Uiowa     | 1             | 4              |             |          |                            |
      | 2             | 3.2    | 110     | 4.0            |   145         | 150       | fall            | Computer Science | Grinnell  | 2             | 5              |             |          |                            |
      | 3             | 3.4    | 102     | 4.0            |   130         | 155       | fall            | Computer Science | UMichigan | 0             | 7              |             |          |                            |

  Scenario: Admin can see all faculties in the database
    When I log in as an admin
    Then I can see all faculties in the database

  Scenario: Admin can see all students in the database
    When I log in as an admin
    Then I can see all students in the database

  Scenario: Admin can see all admins in the database
    When I log in as an admin
    Then I can see all admins in the database

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

  Scenario: Admin cannot export student data
    When I log in as an admin
    Then I cannot export student information

  Scenario: Admin cannot export faculty data
    When I log in as an admin
    Then I cannot export faculty information

  Scenario: Admin can go to homepage from the dashboard
    When I log in as an admin
    Then I will go to homepage of Gremester if I click on Home button on the navigation bar

  Scenario: Admin approves faculty once faculty signs up
    When I sign up with valid faculties details
    Then I should see a message saying my account is pending for admin approval
    Then administrator can log in to verify faculty
    Then I can approve the faculty
    Then I can see successful approval message


  Scenario: Admin can see all profiles in the database
    When I log in as an admin
    Then I can see all profiles in the database

  Scenario: Admin cannot add any profile in the database
    When I log in as an admin
    Then I cannot add any profile in the database

  Scenario: Admin cannot edit any profile in the database
    When I log in as an admin
    Then I cannot edit any profile in the database

  Scenario: Admin cannot export profile data
    When I log in as an admin
    Then I cannot export profile information

  Scenario: Admin cannot delete profile data
    When I log in as an admin
    Then I cannot delete profile information
