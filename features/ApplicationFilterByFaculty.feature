Feature: Faculty can look at all applications applied to his university

  Background: I am on the Welcome to Gremester page
    Given the following students have been added to Student Database:
      | first_name  | last_name  | email               |password  | username      | id |
      | Robin       | Hood       | robin@gmail.com     |12345678  | robin_hood    | 1  |
      | Thomas      | Edison     | thomas@gmail.com    |23456789  | thomas_edison | 2  |
      | Frank       | Robert     | frank@gmail.com     |34567890  | frank_robert  | 3  |
      | Alex        | Robert     | robert@gmail.com    |34567890  | robert        | 4  |
      | Harsha      | Pitawela   | harshainfo@gmail.com|12345678  | harsha_st     | 5  |
      | Michael     | Jordan     | h@a.com             |12345678  | h_st          | 6  |
      | Kobe        | Bryant     | h@b.com             |12345678  | b_st          | 7  |
      | Dwayne      | Wade       | h@c.com             |12345678  | c_st          | 8  |
      | Manu        | Ginobili   | h@d.com             |12345678  | d_st          | 9  |
      | Stephen     | Curry      | h@e.com             |12345678  | e_st          | 10 |
      | Kevin       | Durant     | h@f.com             |12345678  | f_st          | 11 |
      | Klay        | Thompson   | h@g.com             |12345678  | g_st          | 12 |
      | Tony        | Parker     | h@h.com             |12345678  | l_st          | 13 |
      | Tim         | Duncan     | h@i.com             |12345678  | i_st          | 14 |
      | Lebron      | James      | h@j.com             |12345678  | j_st          | 15 |
      | Dwight      | Howard     | h@k.com             |12345678  | k_st          | 16 |

    And the following faculties have been added to Faculty Database:
      | first_name  | last_name   | email             | password    |   username          | weblink | approved | confirmed_at | university_id |
      | Alice       | May         | alicen@uiowa.edu  | 12345689    |   alice_may         | http://homepage.cs.uiowa.edu/~alicem/ | true | 2019-02-15 02:46:01 UTC | 1|
      | Lily        | Edison      | lilys@uiowa.edu   | 23456789    |   lily12            | http://homepage.cs.uiowa.edu/~lily12/ | true | 2019-02-15 02:46:01 UTC | 1|
      | Hazel       | Robert      | hazel@uiowa.edu   | 34567890    |   hazel_robert      | http://homepage.cs.uiowa.edu/~hzel/ | true  | 2019-02-15 02:46:01 UTC | 2|

    And the following profiles have been added to Profile Database:
      |id|student_id|toefl|gre_writing|gre_verbal| gre_quant | interested_term | interested_year | year_work_exp | resume_data | sop_data | additional_attachment_data | degree_objective_phd | degree_objective_master  |gender|
      |1 |1         |100  |5          |140       |160        |fall             |2020             |1              |             |          |                            |5                     |2                         |Male  |
      |2 |2         |110  |4          |145       |150        |fall             |2020             |2              |             |          |                            |2                     |5                         |Male  |
      |3 |3         |102  |4          |130       |155        |fall             |2020             |0              |             |          |                            |3                     |3                         |Male  |
      |4 |4         |102  |4          |130       |155        |fall             |2020             |0              |             |          |                            |3                     |3                         |Male  |
      |5 |5         |110  |4          |164       |146        |Fall             |2019             |4 - 5 years    |             |          |                            |0                     |0                         |Male  |
      |6 |6         |100  |3          |160       |150        |Spring           |2020             |4 - 5 years    |             |          |                            |2                     |4                         |Male  |
      |7 |7         |90   |4          |158       |148        |Fall             |2019             |4 - 5 years    |             |          |                            |3                     |3                         |Male  |
      |8 |8         |110  |4          |164       |146        |Spring           |2020             |4 - 5 years    |             |          |                            |4                     |2                         |Male  |
      |9 |9         |115  |3          |160       |150        |Fall             |2019             |4 - 5 years    |             |          |                            |5                     |1                         |Male  |
      |10|10        |100  |4          |158       |148        |Spring           |2020             |4 - 5 years    |             |          |                            |1                     |5                         |Male  |
      |11|11        |110  |4          |164       |146        |Fall             |2019             |4 - 5 years    |             |          |                            |2                     |4                         |Male  |
      |12|12        |115  |3          |160       |150        |Spring           |2020             |4 - 5 years    |             |          |                            |3                     |3                         |Male  |
      |13|13        |112  |4          |158       |148        |Fall             |2019             |4 - 5 years    |             |          |                            |4                     |2                         |Male  |
      |14|14        |100  |4          |164       |146        |Spring           |2020             |4 - 5 years    |             |          |                            |3                     |1                         |Male  |
      |15|15        |120  |3          |160       |150        |Fall             |2019             |4 - 5 years    |             |          |                            |4                     |5                         |Male  |
      |16|16        |110  |4          |158       |148        |Spring           |2020             |4 - 5 years    |             |          |                            |5                     |4                         |Male  |


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
      |id |country_id     |university_name                      | university_type | acceptance_rate | location                                                                                                                                                                                                                                                                                                                                                                                                                                                      |university_desc                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
      |1  |236            |Massachusetts Institute of Technology|Public           |18               |Located in Cambridge, Massachusetts, MIT is located on the north shore of the Charles River Basin. The campus is within 3 miles of two major interstate highways, and is less than 6 miles from Logan international airport. The Kendall (or MIT) Station is at a 5 minute walk from the campus. MIT is roughly a 20 minute walk from downtown Boston, and a 30–40 minute walk from Harvard University, which is located just up the river from the MIT campus.|Although it’ll no doubt be fascinating and highly inspiring to read about MIT, it could also give you a serious inferiority complex. Because Massachusetts Institute of Technology is perhaps the best overall college in the world, and it makes sure its students are no less. To get into MIT, you need to be excellent in everything, and even that probably won’t be enough. MIT is absolutely top-notch in everything, from infrastructure to faculty to extracurriculars to placements to alumni. An interesting bit of trivia: the aggregated revenues of companies founded by MIT alumni would rank as the eleventh largest economy in the world. Now, that's MIT. We associate only one word with MIT - WOW.|
      |2  |236            |Stanford University                  |Public           |18               |Located 35 miles south of San Francisco and 20 miles north of San Jose, Stanford University is in the heart of Northern California’s dynamic Silicon Valley.                                                                                                                                                                                                                                                                                                   |The very famous Stanford University is a private research university with a high output, located in Stanford, California. Simply, if anyone gets into Stanford, she/he takes it blindly, as the acceptance rate is a mere 4.8% and financial aids are among the most generous ones. To get an idea of exactly how competitive Stanford is, you don’t have to look further than the long list of prominent companies founded by Stanford alumni- Google, Hewlett-Packard, LinkedIn, Yahoo, and Sun Microsystems. And that’s not even one tenth of the list. Also, it ranks #3 according to U.S. News' 'Best Global Universities Ranking' list.                                                                         |
      |3  |236            |University of California – Berkeley  |Public           |18               |University of California – Berkeley is located in the Bay Area of California, a very in-demand and rather expensive area. The university is roughly 5 miles from Oakland, and 12 miles from San Francisco. Anyone who knows will tell you that UC Berkeley has a fantastic location, with Tilden Park and Berkeley Marina pretty close by.                                                                                                                     |UC Berkeley is the flagship institute of the University of California. Statistically, Berkeley (as it’s called) is the most consistently well ranked university in the world. It has the highest number of distinguished graduate programs ranked in the top 10 in their fields by the United States National Research Council. As you can probably gauge, it isn’t easy to get into Berkeley, unless you have an untouchable academic track record. And rightly so – some of the achievements at this institute are fantastic. To give you an idea, UC Berkeley and its researchers are associated with 6 chemical elements of the periodic table. Now that’s something, isn’t it?                                   |
      |4  |236            |California Institute Of Technology   |Public           |18               |Like you probably just read, Caltech is located in Pasadena, which fortunately is just about 18km away from downtown Los Angeles. Sounds like the Best of Both Worlds? Definitely.                                                                                                                                                                                                                                                                             |The highly renowned California Institute of Technology is a private research university started in the year 1891. Located in Pasadena, Caltech has gained a reputation as one of the best technological institutes in the world. Understandably, it receives a massive number of applications from all over the world. However, it isn’t easy to get in. In fact, Caltech is arguably one of the toughest universities to get into; call it bias, prejudice, or racism, Caltech just doesn’t seem to admit enough Indians. Though we think this perhaps has something to do with the extremely high levels of expectation here, and not much else.                                                                    |
      |5  |236            |University of Michigan - Ann Arbor   |Public           |18               |University of Michigan is a 45 minute drive from Detroit, the main city of Michigan. Apart from the University, Ann Arbor is pretty boring but fortunately Detroit is quite accessible.                                                                                                                                                                                                                                                                        |University of Michigan, Ann Arbor, is a public research university which was founded in 1817. UMich is very famous for its research work and has one of the largest research expenditures amongst American Universities.  It is one of the high ranking universities in the States, and thus it’s clearly not easy to get in. Many students still apply, though, putting it in the ‘ambitious’ category, and keeping their fingers firmly crossed.                                                                                                                                                                                                                                                                    |

    And the following profiles_undergrad_universities have been added to ProfilesUndergradUniversity Database:
      |profile_id | undergrad_university_id |cgpa|degree_type|major               |start_year|end_year|grading_scale_type_id|
      |1          |1                        |3.5 |M.S        |Computer Science    |2010      |2014    |1                    |
      |2          |2                        |2.8 |B.S        |Computer Engineering|2012      |2016    |2                    |
      |3          |1                        |3.1 |B.S        |Computer Science    |2011      |2015    |1                    |
      |4          |1                        |3.1 |B.S        |Computer Science    |2011      |2015    |1                    |
      |5          |1                        |3.56|B.S.       |Computer Science    |2010      |2014    |1                    |
      |6          |2                        |3   |B.S.       |Computer Science    |2010      |2014    |2                    |
      |7          |3                        |8   |B.S.       |Computer Science    |2010      |2014    |3                    |
      |8          |4                        |2.5 |B.S.       |Computer Science    |2010      |2014    |4                    |
      |9          |5                        |1.1 |B.S.       |Computer Science    |2010      |2014    |5                    |
      |10         |1                        |2.98|B.S.       |Computer Science    |2010      |2014    |1                    |
      |11         |2                        |4   |B.S.       |Computer Science    |2010      |2014    |2                    |
      |12         |3                        |9   |B.S.       |Computer Science    |2010      |2014    |3                    |
      |13         |4                        |3.8 |B.S.       |Computer Science    |2010      |2014    |4                    |
      |14         |5                        |2.1 |B.S.       |Computer Science    |2010      |2014    |5                    |
      |15         |1                        |4.2 |B.S.       |Computer Science    |2010      |2014    |1                    |
      |16         |2                        |2   |B.S.       |Computer Science    |2010      |2014    |2                    |


    And the following universities have been added to University Database:
      |id| rank   | university_name  | university_type | acceptance_rate | tuition |location|weather|university_link|university_desc|
      |1 |1       |Massachusetts Institute of Technology|Private|18|$49,600|Located in Cambridge, Massachusetts, MIT is located on the north shore of the Charles River Basin. The campus is within 3 miles of two major interstate highways, and is less than 6 miles from Logan international airport. The Kendall (or MIT) Station is at a 5 minute walk from the campus. MIT is roughly a 20 minute walk from downtown Boston, and a 30–40 minute walk from Harvard University, which is located just up the river from the MIT campus.|If there’s any negative about MIT, then this is it. The climate here is of the continental type. Massachusetts receives about 40 inches of rain annually, fairly evenly distributed throughout the year, slightly wetter during the winter.Summers are warm with average high temperatures in July about 26.7 °C and overnight lows about 15.5 °C. Winters are pretty cold though, with temperatures often going sub-zero.|http://www.mit.edu/|Although it’ll no doubt be fascinating and highly inspiring to read about MIT, it could also give you a serious inferiority complex. Because Massachusetts Institute of Technology is perhaps the best overall college in the world, and it makes sure its students are no less. To get into MIT, you need to be excellent in everything, and even that probably won’t be enough. MIT is absolutely top-notch in everything, from infrastructure to faculty to extracurriculars to placements to alumni. An interesting bit of trivia: the aggregated revenues of companies founded by MIT alumni would rank as the eleventh largest economy in the world. Now, that's MIT. We associate only one word with MIT - WOW.|
      |2 |2       |Stanford University|Public|17|$16,900|Located 35 miles south of San Francisco and 20 miles north of San Jose, Stanford University is in the heart of Northern California’s dynamic Silicon Valley.|Most students are of the common opinion that the weather at Stanford is pretty good. Apart from the winter months, when it’s slightly cold and wet, the rest of the year is sunny and pleasant. Stanford University area doesn’t receive snowfall and fortunately doesn’t experience extremes of temperature. It’s pretty normal to see people roaming around in shorts and tshirts.|http://www.stanford.edu/|The very famous Stanford University is a private research university with a high output, located in Stanford, California. Simply, if anyone gets into Stanford, she/he takes it blindly, as the acceptance rate is a mere 4.8% and financial aids are among the most generous ones. To get an idea of exactly how competitive Stanford is, you don’t have to look further than the long list of prominent companies founded by Stanford alumni- Google, Hewlett-Packard, LinkedIn, Yahoo, and Sun Microsystems. And that’s not even one tenth of the list. Also, it ranks #3 according to U.S. News' 'Best Global Universities Ranking' list.|

    And the following applications have been added to Application Database:
      |id | university_id        | profile_id |applied | applied_date   | admitted | admitted_date | rejected | rejected_date |term	 |year|
      | 1 | 1                    | 1          | t      | 2019-03-12 	|          |               |          |               |Fall	 |2019|
      | 2 | 2                    | 1          | t      | 2019-03-12 	|          |               |          |               |Fall	 |2019|
      | 3 | 1                    | 2          | t      | 2019-03-12 	|          |               |          |               |Spring|2020|
      | 4 | 2                    | 2          | t      | 2019-03-12 	|          |               |          |               |Spring|2020|
      | 5 | 1                    | 3          | t      | 2019-03-12 	|          |               |          |               |Fall  |2020|
      | 6 | 2                    | 3          | t      | 2019-03-12 	|          |               |          |               |Fall  |2020|
      | 7 | 1                    | 4          | t      | 2018-03-12 	| true     | 2018-04-12    |          |               |Fall  |2020|
      | 8 | 1                    | 4          | t      | 2018-03-12 	|          |               |  true    |  2018-05-01   |Fall  |2020|

    And the following grading_scale_types have been added to GradingScaleType Database:
      |id | grading_scale_name          |
      | 1 | Standard with A+            |
      | 2 | Standard with no plus/minus |
      | 3 | 1 – 10 scale                |
      | 4 | Standard with no A+         |
      | 5 | Germany scale               |

    And the following grading_scales have been added to GradingScale Database:
      |id |grading_scale_type_id | letter_grade |gpa   | low_percent | high_percent |
      |1  |1                     |A+            |4.33  |97           |100           |
      |2  |1                     |A             |4     |93           |96            |
      |3  |1                     |A−            |3.67  |90           |92            |
      |4  |1                     |B+            |3.33  |87           |89            |
      |5  |1                     |B             |3     |83           |86            |
      |6  |1                     |B−            |2.67  |80           |82            |
      |7  |1                     |C+            |2.33  |77           |79            |
      |8  |1                     |C             |2     |73           |76            |
      |9  |1                     |C−            |1.67  |70           |72            |
      |10 |1                     |D+            |1.33  |67           |69            |
      |11 |1                     |D             |1     |63           |66            |
      |12 |1                     |D−            |0.67  |60           |62            |
      |13 |1                     |E             |0     |0            |60            |
      |14 |2                     |A             |4     |90           |100           |
      |15 |2                     |B             |3     |80           |89            |
      |16 |2                     |C             |2     |70           |79            |
      |17 |2                     |D             |1     |60           |69            |
      |18 |2                     |F             |0     |0            |59            |
      |19 |3                     |1             |1     |0            |5             |
      |20 |3                     |2             |2     |5            |15            |
      |21 |3                     |3             |3     |15           |25            |
      |22 |3                     |4             |4     |25           |35            |
      |23 |3                     |5             |5     |35           |45            |
      |24 |3                     |6             |6     |45           |55            |
      |25 |3                     |7             |7     |55           |65            |
      |26 |3                     |8             |8     |65           |80            |
      |27 |3                     |9             |9     |80           |95            |
      |28 |3                     |10            |10    |95           |100           |
      |29 |4                     |A             |4     |93           |100           |
      |30 |4                     |A-            |3.67  |90           |92            |
      |31 |4                     |B+            |3.33  |87           |89            |
      |32 |4                     |B             |3     |83           |86            |
      |33 |4                     |B-            |2.67  |80           |82            |
      |34 |4                     |C+            |2.33  |77           |79            |
      |35 |4                     |C             |2     |73           |76            |
      |36 |4                     |C-            |1.67  |70           |72            |
      |37 |4                     |D+            |1.33  |67           |69            |
      |38 |4                     |D             |1     |63           |66            |
      |39 |4                     |D-            |0.67  |60           |62            |
      |40 |4                     |F             |0     |0            |59            |
      |41 |5                     |A             |1     |93           |100           |
      |42 |5                     |A-            |1.3   |90           |92            |
      |43 |5                     |B+            |1.7   |87           |89            |
      |44 |5                     |B             |2     |83           |86            |
      |45 |5                     |B-            |2.3   |80           |82            |
      |46 |5                     |C+            |2.7   |77           |79            |
      |47 |5                     |C             |3     |73           |76            |
      |48 |5                     |C-            |3.3   |70           |72            |
      |49 |5                     |D+            |3.7   |67           |69            |
      |50 |5                     |D             |4     |63           |66            |
      |51 |5                     |D-            |5     |60           |62            |
      |52 |5                     |F             |6     |0            |59            |

  Scenario: Faculty can see all undergrad universities
    When I log in as a faculty
    Then I can see all undergrad universities

  Scenario: Faculty can see all research interests
    When I log in as a faculty
    Then I can see all research interests

  @javascript
  Scenario: Faculty can see filter form
    When I log in as a faculty
    Then I can see all filtering options

  @javascript
  Scenario: Faculty can see all applications to his university
    When I log in as a faculty
    Then I can see all applications to my university that do not have admitted or rejected date

  @javascript
  Scenario: Faculty can filter applications by research interest
    When I log in as a faculty
    And I select Artificial Intelligence as research interest
    And I click on Filter button
    Then I can see all applications with Artificial Intelligence as research interest

  @javascript
  Scenario: Faculty can filter applications by undergrad university
    When I log in as a faculty
    And I select Stanford University as undergrad university
    And I click on Filter button
    Then I can see all applications from Stanford University

  @javascript
  Scenario: Faculty can filter applications by GREQ
    When I log in as a faculty
    And I slide GREQ to range 140,160
    And I click on Filter button
    Then I can see all applications with GREQ in range 140,160

  @javascript
  Scenario: Faculty can filter applications by GREV
    When I log in as a faculty
    And I slide GREV to range 135,150
    And I click on Filter button
    Then I can see all applications with GREV in range 135,150

  @javascript
  Scenario: Faculty can filter applications by GREV and GREQ
    When I log in as a faculty
    And I slide GREV to range 135,150
    And I slide GREQ to range 155,165
    And I click on Filter button
    Then I can see all applications with GREV and GREQ in ranges 135,150 and 155,165

  @javascript
  Scenario: Faculty can filter applications by MSOB
    When I log in as a faculty
    And I slide MSOB to range 3,5
    And I click on Filter button
    Then I can see all applications with MSOB in range 3,5

  @javascript
  Scenario: Faculty can filter applications by PHDO
    When I log in as a faculty
    And I slide PHDO to range 3,5
    And I click on Filter button
    Then I can see all applications with PHDO in range 3,5

  @javascript
  Scenario: Faculty can see filter form
    When I log in as a faculty
    And I select Multiple in research interests
    Then I can see research interests modal

  @javascript
  Scenario: Faculty cannot select 0 interests in modal
    When I log in as a faculty
    And I select Multiple in research interests
    And I can see research interests modal
    And I click on Done button
    Then I should see alert
    And modal should not close

  @javascript
  Scenario: Faculty can close modal by clicking on cancel
    When I log in as a faculty
    And I select Multiple in research interests
    And I can see research interests modal
    And I click on Cancel button
    And modal should close

  @javascript
  Scenario: Faculty can close modal by clicking on x
    When I log in as a faculty
    And I select Multiple in research interests
    And I can see research interests modal
    And I click on x button
    And modal should close

  @javascript
  Scenario: Faculty can see all applications by selecting any
    When I log in as a faculty
    And I select any in term
    And I select any in year
    And I click on Filter button
    Then I can see all applications to my university that do not have admitted or rejected date

  @javascript
  Scenario: Faculty can filter applications by selecting term
    When I log in as a faculty
    And I select Fall in term
    And I click on Filter button
    Then I can see all applications to my university for Fall

  @javascript
  Scenario: Faculty can filter applications by selecting year
    When I log in as a faculty
    And I select 2020 in year
    And I click on Filter button
    Then I can see all applications to my university for 2020

  @javascript
  Scenario: Faculty can filter applications by selecting year and term without and_later
    When I log in as a faculty
    And I select Fall in term
    And I select 2020 in year
    And I uncheck and_later
    And I click on Filter button
    Then I can see all applications to my university for Fall 2020

  @javascript
  Scenario: Faculty can filter applications by selecting year and term with and_later
    When I log in as a faculty
    And I select Fall in term
    And I select 2019 in year
    And I check and_later
    And I click on Filter button
    Then I can see all applications to my university for Fall 2019 and later terms

  Scenario: Faculty can view student profile
    When I log in as a faculty
    And I can click any student profile if I click on their name in the application table

  @javascript
  Scenario: Faculty can filter applications by GPA on all grading scales
    When I log in as a faculty
    And I select all as scale
    And I slide CGPA to range 80,100
    And I click on Filter button
    Then I can see all applications with CGPA in range 80,100

  @javascript
  Scenario: Faculty can filter applications by GPA on Standard with A+ scale
    When I log in as a faculty
    And I select Standard with A+ as scale
    And I slide CGPA to range 80,100
    And I click on Filter button
    Then I can see all applications with CGPA in range 80,100 in Standard with A+ scale

  @javascript
  Scenario: Faculty can filter applications by GPA on German scale
    When I log in as a faculty
    And I select German scale as scale
    And I slide CGPA to range 80,100
    And I click on Filter button
    Then I can see all applications with CGPA in range 80,100 in German scale



