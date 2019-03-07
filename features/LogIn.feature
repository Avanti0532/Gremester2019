Feature: Allow students, faculties and admins to login

  Background: I am on the homepage of Gremester
    Given the following students have been added to Student Database:
      | first_name  | last_name  | email          | password  | username          | confirmed_at |
      | Robin       | Hood       | robin@gmail.com  | 12345678    |   robin_hood      | 2019-02-15 02:46:01 UTC |
      | Thomas      | Edison     | thomas@gmail.com  | 23456789    |   thomas_edison   | 2019-02-15 02:46:01 UTC |
      | Frank       | Robert     | frank@gmail.com | 34567890    |   frank_robert    | 2019-02-15 02:46:01 UTC |

    And the following faculties have been added to Faculty Database:
      | first_name  | last_name   | email             | password    |   username          | weblink | approved | confirmed_at | university_id |
      | Alice       | May         | alicen@uiowa.edu  | 12345689    |   alice_may         | http://homepage.cs.uiowa.edu/~alicem/ | true | 2019-02-15 02:46:01 UTC | 1|
      | Lily        | Edison      | lilys@uiowa.edu   | 23456789    |   lily12            | http://homepage.cs.uiowa.edu/~lily12/ | true | 2019-02-15 02:46:01 UTC | 1|
      | Hazel       | Robert      | hazel@uiowa.edu   | 34567890    |   hazel_robert      | http://homepage.cs.uiowa.edu/~hzel/ | false  | 2019-02-15 02:46:01 UTC | 1|


    And the following admins have been added to Admin Database:
      | first_name  | last_name   | email             | password    | password_confirmation |
      | Linh        | Pham         | linh@gmail.com    | 12345689    |  12345689            |
      | Jordan        | Peterson      | jordan@gmail.com   | 23456789    | 23456789         |


  Scenario: Student logs in with valid credentials
    When I log in as a student
    Then I should see a successful login message

  Scenario: Faculty logs in with valid credentials
    When I log in as a faculty
    Then I should see a successful login message

  Scenario: Admin logs in with valid credentials
    When I log in as an admin
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
    When I log in as an admin
    Then I will receive message saying I'm already logged in if I attempt to go to faculty or student login page
    And I will receive message saying I'm already logged in if I attempt to go to faculty or student signup page

  Scenario: Only one user can log in at one time
    When I log in as a student
    Then I will receive message saying I'm already logged in if I attempt to go to admin or faculty login page
    And I will receive message saying I'm already logged in if I attempt to go to admin or faculty signup page
    And I got redirected to homepage

  Scenario: Only one user can log in at one time
    When I log in as a faculty
    Then I will see message saying that I logged in to the system
    And I will receive message saying I'm already logged in if I attempt to go to admin or student login page
    And I will receive message saying I'm already logged in if I attempt to go to admin or student signup page
    And I got redirected to homepage

