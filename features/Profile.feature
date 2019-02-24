Feature: Allow students to edit their profile

  Background: I am on the homepage of Gremester
    Given the following students have been added to Student Database:
      | first_name  | last_name  | email          | password  | username          | confirmed_at |
      | Robin       | Hood       | robin@gmail.com  | 12345678    |   robin_hood      | 2019-02-15 02:46:01 UTC |
      | Thomas      | Edison     | thomas@gmail.com  | 23456789    |   thomas_edison   | 2019-02-15 02:46:01 UTC |
      | Frank       | Robert     | frank@gmail.com | 34567890    |   frank_robert    | 2019-02-15 02:46:01 UTC |

    And the following profiles have been added to Profile Database:
      | student_id    | cgpa   | toefl   | gre_writing    |   gre_verbal  | gre_quant | interested_term | interested_major | college   | year_work_exp | month_work_exp | resume_data | sop_data | additional_attachment_data |
      | 1             | 3.0    | 100     | 5.0            |   140         | 130       | fall            | Computer Science | Uiowa     | 1             | 4              | test resume | test sop | test additional            |
      | 2             | 3.2    | 110     | 4.0            |   145         | 150       | fall            | Computer Science | Grinnell  | 2             | 5              | test resume | test sop | test additional            |
      | 3             | 3.4    | 102     | 4.0            |   130         | 155       | fall            | Computer Science | UMichigan | 0             | 7              | test resume | test sop | test additional            |

  @wip
  Scenario: Students can update their name
    When I log in as a student
    Then I can update my last name and first name
  @wip
  Scenario: Students can update their toefl score
    When I log in as a student
    Then  I can update my toefl score
  @wip
  Scenario: Students can update their undergraduate college
    When I log in as a student
    Then  I can update my undergraduate college

  @wip
  Scenario: Students can update their cgpa
    When I log in as a student
    Then  I can update my cgpa
  @wip
  Scenario: Students can update their major
    When I log in as a student
    Then  I can update my major

  @wip
  Scenario: Students can update their gre score
    When I log in as a student
    Then  I can update my gre verbal, writing or quant score
  @wip
  Scenario: Students can update their work experience
    When I log in as a student
    Then  I can update my work experience
  @wip
  Scenario: Students can update their intended start term
    When I log in as a student
    Then  I can update intended start term
  @wip
  Scenario: Students can update their resume
    When I log in as a student
    Then  I can update my resume
  @wip
  Scenario: Students can update their sop
    When I log in as a student
    Then  I can update my sop
  @wip
  Scenario: Students can update their additional attachment
    When I log in as a student
    Then  I can update my additional attachment
  @wip
  Scenario: Students can update their profile picture
    When I log in as a student
    Then  I can update my profile picture

