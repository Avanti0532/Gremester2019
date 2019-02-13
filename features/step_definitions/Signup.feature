Feature: Allow faculties and students to sign up

  Background: I am on the homepage of Gremester

  Scenario: Students sign up with valid details
    When I sign up with valid student details
    Then I should get a message saying confirmation email has been sent

  Scenario: Faculties sign up with valid details
    When I sign up with valid faculties details
    Then I should see a message saying my account is pending for admin approval

  Scenario: Students sign up with blank first name
    When I sign up with blank first name as a student
    Then I should see a blank first name error message

  Scenario: Faculties sign up with blank first name
    When I sign up with blank first name as a faculty
    Then I should see a blank first name error message

  Scenario: Students sign up with blank last name
    When I sign up with blank last name as a student
    Then I should see a blank last name error message

  Scenario: Faculties sign up with blank last name
    When I sign up with blank last name as a faculty
    Then I should see a blank last name error message

  Scenario: Students sign up with blank email
    When I sign up with blank email as a student
    Then I should see a blank email error message

  Scenario: Students sign up with blank email
    When I sign up with blank email as a faculty
    Then I should see a blank email error message

  Scenario: Students sign up with invalid password
    When I sign up with invalid password as a student
    Then I should see an invalid password message

  Scenario: Faculties sign up with invalid password
    When I sign up with invalid password as a faculty
    Then I should see an invalid password message

  Scenario: Students sign up without password
    When I sign up with blank password
    Then I should see a blank password error message
