Feature: Allow students to edit their profile

  Background: I am on the homepage of Gremester
    Given the following students have been added to Student Database:
      | first_name  | last_name  | email          | password  | username          | confirmed_at                  | id|
      | Robin       | Hood       | robin@gmail.com  | 12345678    |   robin_hood      | 2019-02-15 02:46:01 UTC   | 1 |
      | Thomas      | Edison     | thomas@gmail.com  | 23456789    |   thomas_edison   | 2019-02-15 02:46:01 UTC  |2  |
      | Frank       | Robert     | frank@gmail.com | 34567890    |   frank_robert    | 2019-02-15 02:46:01 UTC    |3  |

    And the following countries have been added to Country Database:
      | name  | id |
      | United States | 1|

    And the following undergrad universities have been added to UndergradUniversity Database:
      | country_id| university_name  | university_type | acceptance_rate | location|university_link|university_desc|
      |1          |Massachusetts Institute of Technology|Private|18|Located in Cambridge, Massachusetts, MIT is located on the north shore of the Charles River Basin. The campus is within 3 miles of two major interstate highways, and is less than 6 miles from Logan international airport. The Kendall (or MIT) Station is at a 5 minute walk from the campus. MIT is roughly a 20 minute walk from downtown Boston, and a 30–40 minute walk from Harvard University, which is located just up the river from the MIT campus.|http://www.mit.edu/|Although it’ll no doubt be fascinating and highly inspiring to read about MIT, it could also give you a serious inferiority complex. Because Massachusetts Institute of Technology is perhaps the best overall college in the world, and it makes sure its students are no less. To get into MIT, you need to be excellent in everything, and even that probably won’t be enough. MIT is absolutely top-notch in everything, from infrastructure to faculty to extracurriculars to placements to alumni. An interesting bit of trivia: the aggregated revenues of companies founded by MIT alumni would rank as the eleventh largest economy in the world. Now, that's MIT. We associate only one word with MIT - WOW.|
      |1          |Stanford University|Public|17|Located 35 miles south of San Francisco and 20 miles north of San Jose, Stanford University is in the heart of Northern California’s dynamic Silicon Valley.|http://www.stanford.edu/|The very famous Stanford University is a private research university with a high output, located in Stanford, California. Simply, if anyone gets into Stanford, she/he takes it blindly, as the acceptance rate is a mere 4.8% and financial aids are among the most generous ones. To get an idea of exactly how competitive Stanford is, you don’t have to look further than the long list of prominent companies founded by Stanford alumni- Google, Hewlett-Packard, LinkedIn, Yahoo, and Sun Microsystems. And that’s not even one tenth of the list. Also, it ranks #3 according to U.S. News' 'Best Global Universities Ranking' list.|


    And the following profiles have been added to Profile Database:
      | student_id    | cgpa   | toefl   | gre_writing    |   gre_verbal  | gre_quant | interested_term | interested_major |  year_work_exp | month_work_exp | resume_data | sop_data | additional_attachment_data |
      | 1             | 3.0    | 100     | 5.0            |   140         | 130       | fall            | Computer Science |  1             | 4              |             |          |                            |
      | 2             | 3.2    | 110     | 4.0            |   145         | 150       | fall            | Computer Science |  2             | 5              |             |          |                            |
      | 3             | 3.4    | 102     | 4.0            |   130         | 155       | fall            | Computer Science |  0             | 7              |             |          |                            |

  Scenario: Students can update their name
    When I log in as a student
    Then I can update my last name and first name

  Scenario: Students can update their toefl score
    When I log in as a student
    Then I can update my toefl score

    @javascript
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
    Then  I can update my intended start term


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


