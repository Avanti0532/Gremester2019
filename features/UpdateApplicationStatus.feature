Feature: Allow students to add school to list of potential schools and update status of the application

  Background: I am on the homepage of Gremester
    Given the following students have been added to Student Database:
      | first_name  | last_name  | email          | password  | username          | confirmed_at                  | id|
      | Robin       | Hood       | robin@gmail.com  | 12345678    |   robin_hood      | 2019-02-15 02:46:01 UTC   | 1 |
      | Thomas      | Edison     | thomas@gmail.com  | 23456789    |   thomas_edison   | 2019-02-15 02:46:01 UTC  |2  |
      | Frank       | Robert     | frank@gmail.com | 34567890    |   frank_robert    | 2019-02-15 02:46:01 UTC    |3  |

    And the following profiles have been added to Profile Database:
      | student_id    | cgpa   | toefl   | gre_writing    |   gre_verbal  | gre_quant | interested_term | interested_major | college   | year_work_exp | month_work_exp | resume_data | sop_data | additional_attachment_data | id |
      | 1             | 3.0    | 100     | 5.0            |   140         | 130       | fall            | Computer Science | Uiowa     | 1             | 4              | test resume | test sop | test additional            | 1  |
      | 2             | 3.2    | 110     | 4.0            |   145         | 150       | fall            | Computer Science | Grinnell  | 2             | 5              | test resume | test sop | test additional            | 2  |
      | 3             | 3.4    | 102     | 4.0            |   130         | 155       | fall            | Computer Science | UMichigan | 0             | 7              | test resume | test sop | test additional            | 3  |

    And the following universities have been added to University Database:
      |id| rank  | university_name                     | university_type | acceptance_rate | tuition |location     |weather|university_link|university_desc|
      |1 |1      |Massachusetts Institute of Technology|Private          |18               |$49,600  |Located in Cambridge, Massachusetts, MIT is located on the north shore of the Charles River Basin. The campus is within 3 miles of two major interstate highways, and is less than 6 miles from Logan international airport. The Kendall (or MIT) Station is at a 5 minute walk from the campus. MIT is roughly a 20 minute walk from downtown Boston, and a 30–40 minute walk from Harvard University, which is located just up the river from the MIT campus.|If there’s any negative about MIT, then this is it. The climate here is of the continental type. Massachusetts receives about 40 inches of rain annually, fairly evenly distributed throughout the year, slightly wetter during the winter.Summers are warm with average high temperatures in July about 26.7 °C and overnight lows about 15.5 °C. Winters are pretty cold though, with temperatures often going sub-zero.|http://www.mit.edu/|Although it’ll no doubt be fascinating and highly inspiring to read about MIT, it could also give you a serious inferiority complex. Because Massachusetts Institute of Technology is perhaps the best overall college in the world, and it makes sure its students are no less. To get into MIT, you need to be excellent in everything, and even that probably won’t be enough. MIT is absolutely top-notch in everything, from infrastructure to faculty to extracurriculars to placements to alumni. An interesting bit of trivia: the aggregated revenues of companies founded by MIT alumni would rank as the eleventh largest economy in the world. Now, that's MIT. We associate only one word with MIT - WOW.|
      |2 |2      |Stanford University                  |Public           |17               |$16,900  |Located 35 miles south of San Francisco and 20 miles north of San Jose, Stanford University is in the heart of Northern California’s dynamic Silicon Valley.|Most students are of the common opinion that the weather at Stanford is pretty good. Apart from the winter months, when it’s slightly cold and wet, the rest of the year is sunny and pleasant. Stanford University area doesn’t receive snowfall and fortunately doesn’t experience extremes of temperature. It’s pretty normal to see people roaming around in shorts and tshirts.|http://www.stanford.edu/|The very famous Stanford University is a private research university with a high output, located in Stanford, California. Simply, if anyone gets into Stanford, she/he takes it blindly, as the acceptance rate is a mere 4.8% and financial aids are among the most generous ones. To get an idea of exactly how competitive Stanford is, you don’t have to look further than the long list of prominent companies founded by Stanford alumni- Google, Hewlett-Packard, LinkedIn, Yahoo, and Sun Microsystems. And that’s not even one tenth of the list. Also, it ranks #3 according to U.S. News' 'Best Global Universities Ranking' list.|
      |3 |15     |University of California – Berkeley  |Private          |14               |$28,000  |University of California – Berkeley is located in the Bay Area of California, a very in-demand and rather expensive area. The university is roughly 5 miles from Oakland, and 12 miles from San Francisco. Anyone who knows will tell you that UC Berkeley has a fantastic location, with Tilden Park and Berkeley Marina pretty close by.|Berkeley has a Mediterranean climate, though the temperatures in general are rather lower than what you come to expect in, say, Spain. Summers are cool and dry, while winters are cold and wet. Average temperatures in September (the ‘hottest’ month) are a high of 22.1°C and a low of 13.3°C, while average temperatures in January (the coldest month) are a high of 13.6°C and a low of 6.4°C. Berkeley also experiences rainfall once in a while, mainly during winters, and not much. Snowfall is a rare commodity, and normally takes place only on the peaks of hills.|https://www.berkeley.edu/|UC Berkeley is the flagship institute of the University of California. Statistically, Berkeley (as it’s called) is the most consistently well ranked university in the world. It has the highest number of distinguished graduate programs ranked in the top 10 in their fields by the United States National Research Council. As you can probably gauge, it isn’t easy to get into Berkeley, unless you have an untouchable academic track record. And rightly so – some of the achievements at this institute are fantastic. To give you an idea, UC Berkeley and its researchers are associated with 6 chemical elements of the periodic table. Now that’s something, isn’t it?|

    And the following applications have been added to Application Database:
      | profile_id    | university_id   | applied   | applied_date    |   admitted      | rejected    | rejected_date |
      | 1             | 1               | true      | 2019-02-15      |   false         | true        | 2019-03-16    |
      | 2             | 2               | false     |                 |   false         | false       |               |
      | 3             | 3               | false     |                 |   false         | false       |               |

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

  @wip
  Scenario: Students can remove any school from their potential school list
    When I log in as a student
    Then I can remove any school from their potential school list

