Feature: Allow students to edit their profile

  Background: I am on the homepage of Gremester
    Given the following students have been added to Student Database:
      | first_name  | last_name  | email          | password  | username          | confirmed_at |
      | Robin       | Hood       | robin@gmail.com  | 12345678    |   robin_hood      | 2019-02-15 02:46:01 UTC |
      | Thomas      | Edison     | thomas@gmail.com  | 23456789    |   thomas_edison   | 2019-02-15 02:46:01 UTC |
      | Frank       | Robert     | frank@gmail.com | 34567890    |   frank_robert    | 2019-02-15 02:46:01 UTC |


  Scenario: Students can update their name
    When I log in as a student
    Then I can update my last name and first name

  Scenario: Students can update their toefl score
    When I log in as a student
    Then  I can update my toefl score

  Scenario: Students can update their undergraduate college
    When I log in as a student
    Then  I can update my undergraduate college


  Scenario: Students can update their cgpa
    When I log in as a student
    Then  I can update my cgpa

  Scenario: Students can update their major
    When I log in as a student
    Then  I can update my major


  Scenario: Students can update their gre score
    When I log in as a student
    Then  I can update my gre verbal, writing or quant score

  Scenario: Students can update their work experience
    When I log in as a student
    Then  I can update my work experience

  Scenario: Students can update their intended start term
    When I log in as a student
    Then  I can update intended start term

  Scenario: Students can update their resume
    When I log in as a student
    Then  I can update my resume

  Scenario: Students can update their sop
    When I log in as a student
    Then  I can update my sop

  Scenario: Students can update their additional attachment
    When I log in as a student
    Then  I can update my additional attachment

  Scenario: Students can update their profile picture
    When I log in as a student
    Then  I can update my profile picture


