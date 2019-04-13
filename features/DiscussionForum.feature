Feature: Allow students, faculties and admins to login

  Background: I am on the homepage of Gremester
    Given the following students have been added to Student Database:
      | first_name  | last_name  | email          | password  | username          | confirmed_at | isModerator |
      | Robin       | Hood       | robin@gmail.com  | 12345678    |   robin_hood      | 2019-02-15 02:46:01 UTC | false |
      | Thomas      | Edison     | thomas@gmail.com  | 23456789    |   thomas_edison   | 2019-02-15 02:46:01 UTC | false |
      | Frank       | Robert     | frank@gmail.com | 34567890    |   frank_robert    | 2019-02-15 02:46:01 UTC | true    |


    And the following admins have been added to Admin Database:
      | first_name  | last_name   | email             | password    | password_confirmation |
      | Linh        | Pham         | linh@gmail.com    | 12345689    |  12345689            |
      | Jordan        | Peterson      | jordan@gmail.com   | 23456789    | 23456789         |

    And the following message boards have been added to Messageboards Database:
      |id | name  | position   | description             | slug |
      | 1 | Test      | 1      | Board for testing   | test     |
    And the following topics have been added to Topics Database:
      | user_id  | title   | messageboard_id             | slug | hash_id | moderation_state |
      | 1      | First Topic      | 1   | first_topic           | c27ffab75f9139c8fcbf | 0   |

    And the following posts have been added to Posts Database:
      | user_id     | messageboard_id              | content | moderation_state | postable_id |
      | 1            | 1   | There's not a whole lot here for now| 0   | 1|

  Scenario: Student can log out from the forum page
    When I log in as a student
    Then I can log out of my account from the forum page

  Scenario: Student can go to the main page from the forum page
    When I log in as a student
    Then I can go to the main page from the forum page

  Scenario: Student can post question if they go to specific message board
    When I log in as a student
    Then I can post my question if I go to any message board

  Scenario: Student can reply to any post
    When I log in as a student
    Then I can reply to any post

  Scenario: Student can look at unread message
    When I log in as a student
    Then I can look at unread message

  Scenario: Student can search for topic
    When I log in as a student
    Then I can search for topic by keyword

  Scenario: Student moderator can approve or disapprove message
    When I login as a student moderator
    Then I can approve or disapprove message








