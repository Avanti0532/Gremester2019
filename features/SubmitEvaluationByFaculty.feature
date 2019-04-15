Feature: Faculty can submit evaluations for students

  Background: I am on the Welcome to Gremester page
    Given the following students have been added to Student Database:
      | first_name  | last_name  | email          | password  | username                |
      | Robin       | Hood       | robin@gmail.com  | 12345678    |   robin_hood        |
      | Thomas      | Edison     | thomas@gmail.com  | 23456789    |   thomas_edison    |
      | Frank       | Robert     | frank@gmail.com | 34567890    |   frank_robert       |
      | Alex        | Robert     | robert@gmail.com | 34567890    |   robert       |

    And the following faculties have been added to Faculty Database:
      | first_name  | last_name   | email             | password    |   username          | weblink | approved | confirmed_at | university_id |
      | Alice       | May         | alicen@uiowa.edu  | 12345689    |   alice_may         | http://homepage.cs.uiowa.edu/~alicem/ | true | 2019-02-15 02:46:01 UTC | 1|
      | Lily        | Edison      | lilys@uiowa.edu   | 23456789    |   lily12            | http://homepage.cs.uiowa.edu/~lily12/ | true | 2019-02-15 02:46:01 UTC | 1|
      | Hazel       | Robert      | hazel@uiowa.edu   | 34567890    |   hazel_robert      | http://homepage.cs.uiowa.edu/~hzel/ | true  | 2019-02-15 02:46:01 UTC | 2|
      | James       | Gordon      | james@uiowa.edu   | 23456789    |   james12            | http://homepage.cs.uiowa.edu/~james12/ | true | 2019-04-04 02:46:01 UTC | 1|

    And the following profiles have been added to Profile Database:
      | student_id    |toefl   | gre_writing    |   gre_verbal  | gre_quant | interested_term |  year_work_exp | resume_data | sop_data | additional_attachment_data | degree_objective_phd | degree_objective_master|
      | 1             |  100     | 5.0            |   140         | 160       | fall            |   1             |            |          |                            | 5                    | 2                      |
      | 2             |  110     | 4.0            |   145         | 150       | fall            |   2             |              |          |                            | 2                  | 5                      |
      | 3             | 102     | 4.0            |   130         | 155       | fall            |   0             |             |          |                            | 3                   | 3                      |
      | 4             | 102     | 4.0            |   130         | 155       | fall            |   0             |             |          |                            | 3                   | 3                      |

    And the following research interests have been added to ResearchInterest Database:
      | name  | id |
      | Artificial Intelligence | 1|
      | High Performance Computing | 2|
      | Machine Learning | 3|

    And the following research interests profiles have been added to ResearchInterestsProfile Database:
      |id | research_interest_id | profile_id |
      | 1 | 1                    | 1          |
      | 2 | 2                    | 1          |
      | 3 | 1                    | 2          |
      | 4 | 3                    | 2          |
      | 5 | 2                    | 3          |
      | 6 | 3                    | 3          |

    And the following undergrad universities have been added to UndergradUniversity Database:
      | id | country_id| university_name  | university_type | acceptance_rate | location|university_link|university_desc|
      | 1  |1          |Massachusetts Institute of Technology|Private|18|Located in Cambridge, Massachusetts, MIT is located on the north shore of the Charles River Basin. The campus is within 3 miles of two major interstate highways, and is less than 6 miles from Logan international airport. The Kendall (or MIT) Station is at a 5 minute walk from the campus. MIT is roughly a 20 minute walk from downtown Boston, and a 30–40 minute walk from Harvard University, which is located just up the river from the MIT campus.|http://www.mit.edu/|Although it’ll no doubt be fascinating and highly inspiring to read about MIT, it could also give you a serious inferiority complex. Because Massachusetts Institute of Technology is perhaps the best overall college in the world, and it makes sure its students are no less. To get into MIT, you need to be excellent in everything, and even that probably won’t be enough. MIT is absolutely top-notch in everything, from infrastructure to faculty to extracurriculars to placements to alumni. An interesting bit of trivia: the aggregated revenues of companies founded by MIT alumni would rank as the eleventh largest economy in the world. Now, that's MIT. We associate only one word with MIT - WOW.|
      | 2  |1          |Stanford University|Public|17|Located 35 miles south of San Francisco and 20 miles north of San Jose, Stanford University is in the heart of Northern California’s dynamic Silicon Valley.|http://www.stanford.edu/|The very famous Stanford University is a private research university with a high output, located in Stanford, California. Simply, if anyone gets into Stanford, she/he takes it blindly, as the acceptance rate is a mere 4.8% and financial aids are among the most generous ones. To get an idea of exactly how competitive Stanford is, you don’t have to look further than the long list of prominent companies founded by Stanford alumni- Google, Hewlett-Packard, LinkedIn, Yahoo, and Sun Microsystems. And that’s not even one tenth of the list. Also, it ranks #3 according to U.S. News' 'Best Global Universities Ranking' list.|

    And the following profiles_undergrad_universities have been added to ProfilesUndergradUniversity Database:
      | profile_id | undergrad_university_id |cgpa|degree_type|major|start_year|end_year|grading_scale_type_id|
      | 1          | 1                       |3.5 |M.S        |Computer Science|2010|2014|1                   |
      | 2          | 2                       |2.8 |B.S        |Computer Engineering|2012|2016|1               |
      | 3          | 1                       |3.1 |B.S        |Computer Science    |2011|2015|1               |

    And the following universities have been added to University Database:
      |id| rank   | university_name  | university_type | acceptance_rate | tuition |location|weather|university_link|university_desc|
      |1 |1       |Massachusetts Institute of Technology|Private|18|$49,600|Located in Cambridge, Massachusetts, MIT is located on the north shore of the Charles River Basin. The campus is within 3 miles of two major interstate highways, and is less than 6 miles from Logan international airport. The Kendall (or MIT) Station is at a 5 minute walk from the campus. MIT is roughly a 20 minute walk from downtown Boston, and a 30–40 minute walk from Harvard University, which is located just up the river from the MIT campus.|If there’s any negative about MIT, then this is it. The climate here is of the continental type. Massachusetts receives about 40 inches of rain annually, fairly evenly distributed throughout the year, slightly wetter during the winter.Summers are warm with average high temperatures in July about 26.7 °C and overnight lows about 15.5 °C. Winters are pretty cold though, with temperatures often going sub-zero.|http://www.mit.edu/|Although it’ll no doubt be fascinating and highly inspiring to read about MIT, it could also give you a serious inferiority complex. Because Massachusetts Institute of Technology is perhaps the best overall college in the world, and it makes sure its students are no less. To get into MIT, you need to be excellent in everything, and even that probably won’t be enough. MIT is absolutely top-notch in everything, from infrastructure to faculty to extracurriculars to placements to alumni. An interesting bit of trivia: the aggregated revenues of companies founded by MIT alumni would rank as the eleventh largest economy in the world. Now, that's MIT. We associate only one word with MIT - WOW.|
      |2 |2       |Stanford University|Public|17|$16,900|Located 35 miles south of San Francisco and 20 miles north of San Jose, Stanford University is in the heart of Northern California’s dynamic Silicon Valley.|Most students are of the common opinion that the weather at Stanford is pretty good. Apart from the winter months, when it’s slightly cold and wet, the rest of the year is sunny and pleasant. Stanford University area doesn’t receive snowfall and fortunately doesn’t experience extremes of temperature. It’s pretty normal to see people roaming around in shorts and tshirts.|http://www.stanford.edu/|The very famous Stanford University is a private research university with a high output, located in Stanford, California. Simply, if anyone gets into Stanford, she/he takes it blindly, as the acceptance rate is a mere 4.8% and financial aids are among the most generous ones. To get an idea of exactly how competitive Stanford is, you don’t have to look further than the long list of prominent companies founded by Stanford alumni- Google, Hewlett-Packard, LinkedIn, Yahoo, and Sun Microsystems. And that’s not even one tenth of the list. Also, it ranks #3 according to U.S. News' 'Best Global Universities Ranking' list.|

    And the following applications have been added to Application Database:
      | university_id | profile_id |applied | applied_date | admitted | admitted_date | rejected | rejected_date |term|year|
      | 1                    | 1          | t | 2019-03-12 |          |               |          |               |Fall|2019|
      | 2                    | 1          | t | 2019-03-12 |          |               |          |               |Fall|2019|
      | 1                    | 2          | t | 2019-03-12 |          |               |          |               |Spring|2020|
      | 2                    | 2          | t | 2019-03-12 |          |               |          |               |Spring|2020|
      | 1                    | 3          | t | 2019-03-12 |          |               |          |               |Fall  |2020|
      | 2                    | 3          | t | 2019-03-12 |          |               |          |               |Fall  |2020|
      | 1                    | 4          | t | 2018-03-12 | true     | 2018-04-12    |          |               |Fall  |2020|
      | 2                    | 4          | t | 2018-03-12 |          |               |  true    |  2018-05-01   |Fall  |2020|

    And the following evaluations have been added to FacultyEvaluation Database:
      |faculty_id|application_id|score|ee_background|comment|created_at|
      |1         |3             |4    |1            |Good Profile   |2018-04-07|

  @javascript
  Scenario: Faculty can submit evaluations for students
    When I log_in as a faculty as Alice
    And I click on Robin Hood link
    And I click on Add Evaluation button
    And I fill in evaluations and click submit
    Then I should see a successful evaluation message

  @javascript
  Scenario: Faculty can cancel evaluations for students by clicking on cancel
    When I log_in as a faculty as Alice
    And I click on Robin Hood link
    And I click on Add Evaluation button
    And I fill in evaluations and click submit and then cancel
    Then I should be on submit evaluation page

  Scenario: Faculty cannot submit evaluation again once done
    When I log_in as a faculty as Alice
    And I click on Thomas Edison link
    Then I should not see Add Evaluation button

  Scenario: Faculty can go back to view profile by clicking on back to profile
    When I log_in as a faculty as Alice
    And I click on Robin Hood link
    And I click on Add Evaluation button
    And I click on Back to profile button
    Then I should be on profile view page

  Scenario: Faculty can go back to applications profile filter page by clicking on back button
    When I log_in as a faculty as Alice
    And I click on Robin Hood link
    And I click on Back button
    Then I should be on application filtering page


