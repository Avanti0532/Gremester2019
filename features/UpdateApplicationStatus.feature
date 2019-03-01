Feature: Allow students to add school to list of potential schools and update status of the application

  Background: I am on the homepage of Gremester
    Given the following students have been added to Student Database:
      | first_name  | last_name  | email          | password  | username          | confirmed_at                  | id|
      | Robin       | Hood       | robin@gmail.com  | 12345678    |   robin_hood      | 2019-02-15 02:46:01 UTC   | 1 |
      | Thomas      | Edison     | thomas@gmail.com  | 23456789    |   thomas_edison   | 2019-02-15 02:46:01 UTC  |2  |
      | Frank       | Robert     | frank@gmail.com | 34567890    |   frank_robert    | 2019-02-15 02:46:01 UTC    |3  |

    And the following profiles have been added to Profile Database:
      | student_id    | cgpa   | toefl   | gre_writing    |   gre_verbal  | gre_quant | interested_term | interested_major | college   | year_work_exp | month_work_exp | resume_data | sop_data | additional_attachment_data |
      | 1             | 3.0    | 100     | 5.0            |   140         | 130       | fall            | Computer Science | Uiowa     | 1             | 4              | test resume | test sop | test additional            |
      | 2             | 3.2    | 110     | 4.0            |   145         | 150       | fall            | Computer Science | Grinnell  | 2             | 5              | test resume | test sop | test additional            |
      | 3             | 3.4    | 102     | 4.0            |   130         | 155       | fall            | Computer Science | UMichigan | 0             | 7              | test resume | test sop | test additional            |

  @wip
  Scenario: Students can add school to their potential school list
    When I log in as a student
    Then I can add school to my potential school list

  @wip
  Scenario: Students can update status of any school in the potential school list
    When I log in as a student
    Then I can update the status of any school in the list to be applied, rejected, interested or admitted

  @wip
  Scenario: Students can add date that they applied, admitted or rejected to any school
    When I log in as a student
    Then I can add date that they applied, admitted or rejected to any school

