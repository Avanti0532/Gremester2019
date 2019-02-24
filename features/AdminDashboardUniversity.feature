Feature: Admin can add/edit/delete universities

  Background: I am on the Welcome to Gremester page
    Given the following universities have been added to University Database:
      | rank  | university_name  | university_type | acceptance_rate | tuition |location|weather|university_link|university_desc|
      | 1     |Massachusetts Institute of Technology|Private|18      |$49,600  |Located in Cambridge, Massachusetts, MIT is located on the north shore of the Charles River Basin.|If there is any negative about MIT, then this is it. The climate here is of the continental type.|http://www.mit.edu/|Although it will no doubt be fascinating and highly inspiring to read about MIT, it could also give you a serious inferiority complex.|
      | 2     |Stanford University| Private        |17               |$16,900  |Located 35 miles south of San Francisco and 20 miles north of San Jose|Most students are of the common opinion that the weather at Stanford is pretty good|http://www.stanford.edu/|The very famous Stanford University is a private research university with a high output, located in Stanford, California. Simply, if anyone gets into Stanford, she/he takes it blindly, as the acceptance rate is a mere 4.8% and financial aids are among the most generous ones|
      | 3     |University of California Berkeley|Public|14         |$28,000  |University of California Berkeley is located in the Bay Area of California|Berkeley has a Mediterranean climate, though the temperatures in general are rather lower than what you come to expect in, say, Spain.|https://www.berkeley.edu/|UC Berkeley is the flagship institute of the University of California. Statistically, Berkeley (as it is called) is the most consistently well ranked university in the world.                                           |

    And And the following admins have been added to Admin Database:
      | first_name  | last_name   | email             | password    | password_confirmation |
      | Linh        | Pham        | linh@gmail.com    | 12345689    |  12345689            |
      | Jordan      | Peterson    | jordan@gmail.com  | 23456789    | 23456789         |

  Scenario: Admin can see all universities in the database
    When I log in as an admin
    Then I can see all universities in the database

  Scenario: Admin can add universities in the database
    When I log in as an admin
    Then I can add an university

  Scenario: Admin can edit any university
    When I log in as an admin
    Then I can edit any university from the university database

  Scenario: Admin can delete any question
    When I log in as an admin
    Then I can delete any university from the university database

  Scenario: Admin can add another university and edit it if they click on save and edit
    When I log in as an admin
    Then I can add another university and edit it if they click on save and edit

  Scenario: Admin can add another university if he/she clicks on save and add another
    When I log in as an admin
    Then I can add another university if admin clicks on save and add another

  Scenario: Admin cannot export university data
    When I log in as an admin
    Then I cannot export university information


